package store.seub2hu2.message.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import store.seub2hu2.message.dto.MessageForm;
import store.seub2hu2.message.dto.MessageReceived;
import store.seub2hu2.message.mapper.MessageFileMapper;
import store.seub2hu2.message.mapper.MessageMapper;
import store.seub2hu2.message.vo.Message;
import store.seub2hu2.user.mapper.UserMapper;
import store.seub2hu2.user.vo.User;
import store.seub2hu2.util.ListDto;
import store.seub2hu2.util.Pagination;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MessageService {

    @Autowired
    private MessageMapper messageMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private MessageFileMapper messageFileMapper;

    @Value("C:/Users/jhta/Desktop/MessageFiles")
    private String saveDirectory;

    // 메시지 전송
    public void sendMessage(MessageForm form, int userNo) {
        // 쪽지 저장
        Message message = new Message();
        message.setUserNo(userNo);
        message.setTitle(form.getTitle());
        message.setContent(form.getContent()); // MessageForm의 내용 추가

        // selectKey를 이용해 messageNo를 생성하도록 매퍼 XML에 설정되어야 함
        messageMapper.insertMessage(message);

        // 받는 사람 저장
        String[] nicknames = form.getReceivers().split(","); // 콤마로 구분된 닉네임 문자열
        for (String nickname : nicknames) {
            User user = userMapper.getUserByNickname(nickname.trim());
            if (user != null) { // 유효한 사용자인 경우에만 처리
                // 메시지 수신자 삽입
                messageMapper.insertMessageReceiver(message.getMessageNo(), user.getNo());
            } else {
                // 예외 처리: 존재하지 않는 사용자인 경우 로깅 또는 알림
                throw new IllegalArgumentException("수신자 '" + nickname.trim() + "'은(는) 존재하지 않습니다.");
            }
        }

        // 첨부파일 저장 (파일 업로드 로직)
        if (form.getFile() != null && !form.getFile().isEmpty()) {
            // 첨부파일 저장 로직 구현
            File file = new File(saveDirectory + "/" + form.getFile().getOriginalFilename());
            try {
                form.getFile().transferTo(file); // Spring의 MultipartFile을 이용한 파일 저장
                // 파일 정보 DB 저장 로직 추가 가능
            } catch (IOException e) {
                throw new RuntimeException("파일 저장 중 오류가 발생했습니다.", e);
            }
        }
    }

    // 메시지 목록 조회 (받은 메시지 / 보낸 메시지)
    public ListDto<MessageReceived> getMessageList(Map<String, Object> condition, boolean isReceived) {
        // 페이지네이션 계산
        int page = (Integer) condition.getOrDefault("page", 1); // 기본값 1
        int rows = (Integer) condition.getOrDefault("rows", 10); // 기본값 10
        Pagination pagination = new Pagination(page, getTotalRows(condition), rows); // 페이징 객체 생성

        // 페이지네이션 정보 추가
        condition.put("offset", pagination.getOffset()); // offset 값 설정
        condition.put("rows", pagination.getRowsPerPage()); // 한 페이지에 표시할 데이터 수 설정

        // 받은 메시지 또는 보낸 메시지 조회
        List<MessageReceived> messages;
        if (isReceived) {
            messages = messageMapper.getReceivedMessages(condition);
        } else {
            messages = messageMapper.getSentMessages(condition);
        }

        // 반환할 결과 생성
        return new ListDto<>(messages, pagination);
    }


    // 받은 메시지 목록 조회
    public ListDto<MessageReceived> getReceivedMessages(Map<String, Object> condition, String opt, String keyword) {
        return getMessageList(condition, true); // 받은 메시지 조회
    }

    // 보낸 메시지 목록 조회
    public ListDto<MessageReceived> getSentMessages(Map<String, Object> condition, String opt, String keyword) {
        return getMessageList(condition, false); // 보낸 메시지 조회
    }

    // 메시지 총 개수 조회
    private int getTotalRows(Map<String, Object> condition) {
        return messageMapper.getTotalRows(condition); // 총 메시지 개수 조회
    }

    // 읽지 않은 메시지 갯수 조회
    public int getUnreadMessageCount(int userNo) {
        return messageMapper.countUnreadMessages(userNo);
    }

    // 메시지 삭제
    public void deleteMessage(int messageNo) {
        Message savedMessage = messageMapper.getMessageDetailByNo(messageNo);
        if (savedMessage != null) {
            savedMessage.setDeleted("Y"); // 삭제 상태 변경
            messageMapper.updateMessage(savedMessage); // Message 객체로 수정
        }
    }

    // 메시지 상세 조회
    public Message getMessageDetail(int messageNo) {
        Message message = messageMapper.getMessageDetailByNo(messageNo);

        if (message == null) {
            throw new IllegalArgumentException("메시지를 찾을 수 없습니다. messageNo: " + messageNo);
        }

        return message;
    }

    // 검색 조건 및 페이지 정보 설정
    public Map<String, Object> buildCondition(int page, int rows, String opt, String keyword, int userNo) {
        Map<String, Object> condition = new HashMap<>();
        condition.put("page", page);
        condition.put("rows", rows);
        condition.put("userNo", userNo);

        // offset 계산: (page - 1) * rows
        int offset = (page - 1) * rows;
        condition.put("offset", offset);

        if (StringUtils.hasText(keyword)) {
            condition.put("opt", opt);
            condition.put("keyword", keyword);
        }
        return condition;
    }
}
