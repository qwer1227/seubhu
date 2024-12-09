package store.seub2hu2.message.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.message.dto.MessageForm;
import store.seub2hu2.message.dto.MessageReceived;
import store.seub2hu2.message.mapper.MessageFileMapper;
import store.seub2hu2.message.mapper.MessageMapper;
import store.seub2hu2.message.vo.Message;
import store.seub2hu2.message.vo.MessageFile;
import store.seub2hu2.user.mapper.UserMapper;
import store.seub2hu2.user.vo.User;
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

        MultipartFile multipartFile = form.getFile();

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

        messageMapper.insertMessage(message);

        // 첨부파일이 있으면 실행
        if (message.getMessageFile() != null) {
            MessageFile messageFile = message.getMessageFile();
            messageFile.setFileNo(message.getMessageNo());
            messageFile.setSavedName(message.getMessageFile().getSavedName());
            messageFile.setOriginalName(message.getMessageFile().getOriginalName());
            // UploadFile 테이블에 저장
            messageFileMapper.insertMessageFile(messageFile);

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
        }
    }

    // 메시지 리스트 조회
    private ListDto<MessageReceived> getMessages(Map<String, Object> condition, boolean isReceived) {
        // 검색 조건에 맞는 데이터 전체 갯수 조회
        int totalRows = messageMapper.getTotalRows(condition);

        // pagination 객체 생성
        int page = (Integer) condition.getOrDefault("page", 1);
        int rows = (Integer) condition.getOrDefault("rows", 10);
        Pagination pagination = new Pagination(page, totalRows, rows);

        //데이터 검색범위를 조회해서 Map에 저장
        condition.put("offset", pagination.getOffset());
        condition.put("rows", pagination.getRowsPerPage());

        // 받은 메시지 or 보낸 메시지 조회
        List<MessageReceived> messages = isReceived
                ? messageMapper.getReceivedMessages(condition)
                : messageMapper.getSentMessages(condition);

        // 반환할 DTO 생성
        return new ListDto<>(messages, pagination);
    }

    // 받은 메시지 목록 조회
    public ListDto<MessageReceived> getReceivedMessages(Map<String, Object> condition) {
        return getMessages(condition, true); // 받은 메시지 조회
    }

    // 보낸 메시지 목록 조회
    public ListDto<MessageReceived> getSentMessages(Map<String, Object> condition) {
        return getMessages(condition, false); // 보낸 메시지 조회
    }

    // 메시지 상세 조회
    public Message getMessageDetail(int messageNo) {
        return messageMapper.getMessageDetailByNo(messageNo);
    }


    // 단일 메시지 삭제
    public void deleteMessage(int messageNo) {
        messageMapper.deleteMessage(messageNo);
    }

    // 다중 메시지 삭제
    public void deleteMessages(List<Integer> messageNos) {
        messageMapper.deleteMessages(messageNos);
    }

    // 단일 메시지 읽음 처리
    public void markAsRead(int messageNo) {
        messageMapper.updateReadStatus(messageNo);
    }

    // 다중 메시지 읽음 처리
    public void markMultipleAsRead(List<Integer> messageNos) {
        messageMapper.updateReadStatuses(messageNos);
    }


}
