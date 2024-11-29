package store.seub2hu2.message.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.message.dto.MessageForm;
import store.seub2hu2.message.mapper.MessageFileMapper;
import store.seub2hu2.message.mapper.MessageMapper;
import store.seub2hu2.message.vo.Message;
import store.seub2hu2.message.vo.MessageFile;
import store.seub2hu2.util.FileUtils;
import store.seub2hu2.util.ListDto;
import store.seub2hu2.util.Pagination;

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

    // 메시지 삽입 및 수신자 추가
    public void insertMessage(MessageForm form, int receiverNo) {
        Message message = new Message();
        message.setUserNo(form.getMessageNo());
        message.setTitle(form.getTitle());
        message.setContent(form.getContent());

        MultipartFile multipartFile = form.getMessageFile();

        // 첨부파일이 있으면 실행
        if (!multipartFile.isEmpty()) {
            String originalFilename = multipartFile.getOriginalFilename();
            String filename = System.currentTimeMillis() + originalFilename;
            FileUtils.saveMultipartFile(multipartFile, saveDirectory, filename);

            MessageFile messageFile = new MessageFile();
            messageFile.setOriginalName(originalFilename);
            messageFile.setSavedName(filename);

            message.setMessageFile(messageFile);
        }

        // 메시지 저장
        messageMapper.insertMessage(message);

        // 첨부파일이 있으면 실행
        if (message.getMessageFile() != null) {
            MessageFile messageFile = message.getMessageFile();
            messageFile.setMessageNo(message.getMessageNo());
            messageFile.setSavedName(message.getMessageFile().getSavedName());
            messageFile.setOriginalName(message.getMessageFile().getOriginalName());
            // UploadFile 테이블에 저장
            messageFileMapper.insertMessageFile(messageFile);

            // 메시지 수신자 저장
            messageMapper.insertMessageReceiver(message.getMessageNo(), receiverNo);
        }
    }

    public ListDto<Message> getReceivedMessages(Map<String, Object> condition) {
        // 메시지 총 개수 조회
        int totalRows = messageMapper.getTotalRows(condition);

        // 페이징 계산
        int page = (Integer) condition.getOrDefault("page", 1);
        int rows = (Integer) condition.getOrDefault("rows", 10);

        Pagination pagination = new Pagination(page, totalRows, rows);
        condition.put("begin", pagination.getBegin());
        condition.put("end", pagination.getEnd());

        // 받은 메시지 목록 조회
        List<Message> messages = messageMapper.getReceivedMessages(condition);

        return new ListDto<>(messages, pagination);
    }

    public ListDto<Message> getSentMessages(Map<String, Object> condition) {
        // 메시지 총 개수 조회
        int totalRows = messageMapper.getTotalRows(condition);

        // 페이징 계산
        int page = (Integer) condition.getOrDefault("page", 1);
        int rows = (Integer) condition.getOrDefault("rows", 10);

        Pagination pagination = new Pagination(page, totalRows, rows);
        condition.put("begin", pagination.getBegin());
        condition.put("end", pagination.getEnd());

        // 보낸 메시지 목록 조회
        List<Message> messages = messageMapper.getSentMessages(condition);

        return new ListDto<>(messages, pagination);
    }

    // 메시지 상세 조회
    public Message getMessageDetail(int messageNo, int userNo) {
        // 메시지 읽음 처리
        messageMapper.markMessageAsRead(messageNo, userNo);

        // 메시지 상세 조회
        return messageMapper.getMessageDetailByNo(messageNo);
    }

    // 메시지 삭제
    public void deleteMessage(int messageNo) {
        Message savedMessage = messageMapper.getMessageDetailByNo(messageNo);
        if (savedMessage != null) {
            savedMessage.setDeleted("Y");
            messageMapper.updateMessage(savedMessage);
        }
    }
}
