package store.seub2hu2.message.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.message.dto.MessageForm;
import store.seub2hu2.message.dto.MessageRecieved;
import store.seub2hu2.message.mapper.MessageFileMapper;
import store.seub2hu2.message.mapper.MessageMapper;
import store.seub2hu2.message.vo.Message;
import store.seub2hu2.message.vo.MessageFile;
import store.seub2hu2.util.ListDto;
import store.seub2hu2.util.Pagination;

import java.io.File;
import java.util.List;
import java.util.Map;

@Service
public class MessageService {

    @Autowired
    private MessageMapper messageMapper;

    @Autowired
    private MessageFileMapper messageFileMapper;

    @Value("C:/Users/jhta/Desktop/MessageFiles")
    private String saveDirectory;

    public void insertMessage(MessageForm form, MultipartFile file) throws Exception {
        // 1. 메시지 객체 생성
        Message message = new Message();
        message.setUserNo(form.getSenderUserNo()); // senderId 대신 senderUserNo 사용
        message.setTitle(form.getTitle());
        message.setContent(form.getContent());

        // 2. 메시지 저장
        messageMapper.insertMessage(message); // 저장 후 messageNo 자동 생성됨

        // 3. 파일 처리 (기존 코드와 동일)
        if (file != null && !file.isEmpty()) {
            String originalFilename = file.getOriginalFilename();
            String savedFilename = System.currentTimeMillis() + "_" + originalFilename;

            // 파일 저장
            File saveFile = new File(saveDirectory, savedFilename);
            file.transferTo(saveFile);

            // 파일 정보 DB 저장
            MessageFile messageFile = new MessageFile();
            messageFile.setMessageNo(message.getMessageNo()); // 저장된 메시지 번호 연결
            messageFile.setOriginalName(originalFilename);
            messageFile.setSavedName(savedFilename);
            messageFileMapper.insertMessageFile(messageFile);
        }
    }

    // 메시지 목록 조회 (받은 메시지 / 보낸 메시지)
    public ListDto<MessageRecieved> getMessageList(Map<String, Object> condition, boolean isReceived) {
        // 페이지네이션 계산
        int page = (Integer) condition.getOrDefault("page", 1);
        int rows = (Integer) condition.getOrDefault("rows", 10);
        Pagination pagination = new Pagination(page, getTotalRows(condition), rows);

        // 페이지네이션 정보 추가
        condition.put("offset", pagination.getOffset());
        condition.put("rows", pagination.getRowsPerPage());

        // 받은 메시지 또는 보낸 메시지 조회
        List<MessageRecieved> messages;
        if (isReceived) {
            messages = messageMapper.getReceivedMessages(condition);
        } else {
            messages = messageMapper.getSentMessages(condition);
        }

        // 반환할 결과 생성
        return new ListDto<>(messages, pagination);
    }

    // 받은 메시지 목록 조회
    public ListDto<MessageRecieved> getReceivedMessages(Map<String, Object> condition, String opt, String keyword) {
        return getMessageList(condition, true); // 받은 메시지 조회
    }

    // 보낸 메시지 목록 조회
    public ListDto<MessageRecieved> getSentMessages(Map<String, Object> condition, String opt, String keyword) {
        return getMessageList(condition, false); // 보낸 메시지 조회
    }

    // 메시지 총 개수 조회
    private int getTotalRows(Map<String, Object> condition) {
        return messageMapper.getTotalRows(condition); // 총 메시지 개수 조회
    }

    public int getUnreadMessageCount(int userNo) {
        // 사용자의 unread 메시지 갯수를 반환하는 로직
        return messageMapper.countUnreadMessages(userNo);
    }

    public void deleteMessage(int messageNo) {
        Message savedMessage = messageMapper.getMessageDetailByNo(messageNo);
        if (savedMessage != null) {
            savedMessage.setDeleted("Y"); // 삭제 상태 변경
            messageMapper.updateMessage(savedMessage); // Message 객체로 수정
        }
    }




    public Message getMessageDetail(int messageNo) {
        // 메시지 번호로 상세 정보 조회
        Message message = messageMapper.getMessageDetailByNo(messageNo);

        if (message == null) {
            throw new IllegalArgumentException("메시지를 찾을 수 없습니다. messageNo: " + messageNo);
        }

        return message;
    }


}
