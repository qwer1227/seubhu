package store.seub2hu2.message.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.message.dto.MessageRecieved;
import store.seub2hu2.message.vo.Message;

import java.util.List;
import java.util.Map;

@Mapper
public interface MessageMapper {

    // 메시지 삽입
    void insertMessage(@Param("message") Message message);

    // 메시지 업데이트 (삭제 상태 변경 등)
    void updateMessage(@Param("message") Message message);

    // 메시지 상세 조회
    Message getMessageDetailByNo(@Param("messageNo") int messageNo);

    // 조건에 맞는 메시지 수 조회
    int getTotalRows(@Param("condition") Map<String, Object> condition);

    // 조건에 맞는 메시지 목록 조회
    List<MessageRecieved> getMessages(@Param("condition") Map<String, Object> condition);

    // 메시지 수신자 삽입
    void insertMessageReceiver(@Param("messageNo") int messageNo, @Param("userNo") int userNo);

    // 수신자 메시지 읽음 처리
    void markMessageAsRead(@Param("messageNo") int messageNo, @Param("userNo") int userNo);

    List<MessageRecieved> getReceivedMessages(Map<String, Object> condition);
    List<MessageRecieved> getSentMessages(Map<String, Object> condition);


    // unread 메시지 개수 조회
    int countUnreadMessages(@Param("userNo") int userNo);
}
