package store.seub2hu2.message.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;
import store.seub2hu2.message.dto.MessageReceived;
import store.seub2hu2.message.vo.Message;

import java.util.List;
import java.util.Map;

@Mapper
public interface MessageMapper {

    // 메시지 삽입
    void insertMessage(@Param("message") Message message);

    // 메시지 업데이트 (삭제 상태 변경 등)
    void updateMessage(@Param("message") Message message);

    // 메시지 읽음 처리
    void markMessageAsRead(@Param("messageNo") int messageNo, @Param("userNo") int userNo);

    // 조건에 맞는 메시지 수 조회
    int getTotalRows(@Param("condition") Map<String, Object> condition);

    // 조건에 맞는 메시지 목록 조회
    List<MessageReceived> getMessages(@Param("condition") Map<String, Object> condition);

    // 메시지 수신자 삽입
    void insertMessageReceiver(@Param("messageNo") int messageNo, @Param("userNo") int userNo);

    // 받은 메시지 목록 조회 (검색 및 페이징 조건 포함)
    List<MessageReceived> getReceivedMessages(@Param("condition") Map<String, Object> condition);

    // 보낸 메시지 목록 조회
    List<MessageReceived> getSentMessages(@Param("condition") Map<String, Object> condition);

    // unread 메시지 개수 조회
    int countUnreadMessages(@Param("userNo") int userNo);

    Message getMessageDetailByNo(@Param("messageNo") int messageNo);

    // 메시지 소유자 확인
    boolean isMessageOwner(@Param("messageNo") int messageNo, @Param("userNo") int userNo);

    // 메시지 삭제 상태를 'Y'로 변경 (소프트 삭제)
    void updateMessageDeleted(@Param("messageNo") int messageNo);
}
