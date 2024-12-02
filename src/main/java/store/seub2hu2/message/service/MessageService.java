package store.seub2hu2.message.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.message.dto.MessageForm;
import store.seub2hu2.message.dto.MessageRecieved;
import store.seub2hu2.message.mapper.MessageFileMapper;
import store.seub2hu2.message.mapper.MessageMapper;
import store.seub2hu2.message.vo.Message;
import store.seub2hu2.message.vo.MessageFile;
import store.seub2hu2.security.user.LoginUser;
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

    public void insertMessage(MessageForm form, LoginUser loginUser, int receiverNo) {
        // 1. 메시지 객체 생성
        Message message = new Message();
        message.setUserNo(loginUser.getNo());  // 로그인된 사용자 번호
        message.setTitle(form.getTitle());
        message.setContent(form.getContent());

        // 2. 첨부파일 처리
        MultipartFile multipartFile = form.getMessageFile();
        if (!multipartFile.isEmpty()) {
            String originalFilename = multipartFile.getOriginalFilename();
            String filename = System.currentTimeMillis() + originalFilename;
            // 파일 저장
            FileUtils.saveMultipartFile(multipartFile, saveDirectory, filename);

            MessageFile messageFile = new MessageFile();
            messageFile.setOriginalName(originalFilename);
            messageFile.setSavedName(filename);

            message.setMessageFile(messageFile);
        }

        // 3. 메시지 저장
        messageMapper.insertMessage(message); // 메시지를 먼저 저장하여 messageNo를 생성

        // 4. 첨부파일 저장 (있을 경우)
        if (message.getMessageFile() != null) {
            MessageFile messageFile = message.getMessageFile();
            messageFile.setMessageNo(message.getMessageNo());  // DB에 저장될 messageNo 설정
            messageFileMapper.insertMessageFile(messageFile);  // 파일 정보 저장
        }

        // 5. 메시지 수신자 저장
        messageMapper.insertMessageReceiver(message.getMessageNo(), receiverNo);
    }


    // 공통 메시지 목록 조회
    public ListDto<MessageRecieved> getMessageList(Map<String, Object> condition, String opt, String keyword, boolean isReceived) {
        // 사용자 번호 추가
        int userNo = (Integer) condition.get("userNo");
        condition.put("userNo", userNo);

        // 검색 조건 추가
        if (StringUtils.hasText(keyword)) {
            condition.put("opt", opt);    // 검색 필드 (title, content 등)
            condition.put("keyword", keyword); // 검색 키워드
        }

        // 메시지 총 개수 조회
        int totalRows = messageMapper.getTotalRows(condition);

        // 페이징 계산
        int page = (Integer) condition.getOrDefault("page", 1);
        int rows = (Integer) condition.getOrDefault("rows", 10);
        Pagination pagination = new Pagination(page, totalRows, rows);
        condition.put("offset", pagination.getOffset());
        condition.put("rows", pagination.getRowsPerPage());

        // 조건에 맞는 메시지 목록 조회
        List<MessageRecieved> messages = messageMapper.getMessages(condition);

        return new ListDto<>(messages, pagination);
    }

    // 받은 메시지 목록 조회
    public ListDto<MessageRecieved> getReceivedMessages(Map<String, Object> condition, String opt, String keyword) {
        return getMessageList(condition, opt, keyword, true);
    }

    // 보낸 메시지 목록 조회
    public ListDto<MessageRecieved> getSentMessages(Map<String, Object> condition, String opt, String keyword) {
        return getMessageList(condition, opt, keyword, false);
    }

    // 메시지 상세 조회
    //public MessageForm getMessageDetail(int messageNo) {
    //    return messageMapper.getMessageDetailByNo(messageNo);
    //}


    // 메시지 삭제
    public void deleteMessage(int messageNo) {
        Message savedMessage = messageMapper.getMessageDetailByNo(messageNo);
        if (savedMessage != null) {
            savedMessage.setDeleted("Y");
            messageMapper.updateMessage(savedMessage);
        }
    }
}
