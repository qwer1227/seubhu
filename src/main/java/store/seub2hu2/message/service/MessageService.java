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
        Message message = new Message();
        message.setUserNo(userNo);
        message.setTitle(form.getTitle());
        message.setContent(form.getContent()); // MessageForm의 내용 추가
        messageMapper.insertMessage(message);

        // 수신자 처리
        String[] nicknames = form.getReceivers().split(",");
        for (String nickname : nicknames) {
            User user = userMapper.getUserByNickname(nickname.trim());
            if (user != null) {
                messageMapper.insertMessageReceiver(message.getMessageNo(), user.getNo());
            } else {
                throw new IllegalArgumentException("수신자 '" + nickname.trim() + "'은(는) 존재하지 않습니다.");
            }
        }

        // 첨부파일 저장 (파일 업로드 로직)
        if (form.getFile() != null && !form.getFile().isEmpty()) {
            File file = new File(saveDirectory + "/" + form.getFile().getOriginalFilename());
            try {
                form.getFile().transferTo(file);
            } catch (IOException e) {
                throw new RuntimeException("파일 저장 중 오류가 발생했습니다.", e);
            }
        }
    }

    // 메시지 목록 조회
    public ListDto<MessageReceived> getReceivedMessages(int page, int rows, String opt, String keyword, int userNo) {
        Map<String, Object> condition = buildCondition(page, rows, opt, keyword, userNo);
        return getMessageList(condition, true); // 받은 메시지 조회
    }

    public ListDto<MessageReceived> getSentMessages(int page, int rows, String opt, String keyword, int userNo) {
        Map<String, Object> condition = buildCondition(page, rows, opt, keyword, userNo);
        return getMessageList(condition, false); // 보낸 메시지 조회
    }

    // 메시지 리스트 조회
    private ListDto<MessageReceived> getMessageList(Map<String, Object> condition, boolean isReceived) {
        int page = (Integer) condition.getOrDefault("page", 1);
        int rows = (Integer) condition.getOrDefault("rows", 10);
        Pagination pagination = new Pagination(page, getTotalRows(condition), rows);
        condition.put("offset", pagination.getOffset());
        condition.put("rows", pagination.getRowsPerPage());

        List<MessageReceived> messages = isReceived
                ? messageMapper.getReceivedMessages(condition)
                : messageMapper.getSentMessages(condition);

        return new ListDto<>(messages, pagination);
    }

    // 조건 생성 메서드 (Search 조건)
    private Map<String, Object> buildCondition(int page, int rows, String opt, String keyword, int userNo) {
        Map<String, Object> condition = new HashMap<>();
        condition.put("userNo", userNo);
        if (StringUtils.hasText(opt)) condition.put("opt", opt);
        if (StringUtils.hasText(keyword)) condition.put("keyword", keyword);
        condition.put("page", page);
        condition.put("rows", rows);
        return condition;
    }

    // 메시지 상세 조회
    public Message getMessageDetail(int messageNo) {
        return messageMapper.getMessageDetailByNo(messageNo);
    }

    // 메시지 삭제 서비스
    public void deleteMessages(int messageNo) {
        messageMapper.updateMessageDeleted(messageNo);  // 메시지 삭제 상태를 'Y'로 변경

    }


    private int getTotalRows(Map<String, Object> condition) {
        return messageMapper.getTotalRows(condition);
    }
}
