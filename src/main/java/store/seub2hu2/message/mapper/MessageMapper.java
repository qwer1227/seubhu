package store.seub2hu2.message.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.message.dto.MessageReceived;
import store.seub2hu2.message.vo.Message;

import java.util.List;
import java.util.Map;

@Mapper
public interface MessageMapper {

    // 메시지 삽입
    void insertMessage(@Param("message") Message message);

    // 메시지 수신자 삽입
    void insertMessageReceiver(@Param("messageNo") int messageNo, @Param("userNo") int userNo);

    // 조건에 맞는 메시지 수 조회
    int getTotalRows(@Param("condition") Map<String, Object> condition);

    // 조건에 맞는 메시지 목록 조회
    List<MessageReceived> getMessages(@Param("condition") Map<String, Object> condition);

    // 받은 메시지 목록 조회
    List<MessageReceived> getReceivedMessages(@Param("condition") Map<String, Object> condition);

    // 보낸 메시지 목록 조회
    List<MessageReceived> getSentMessages(@Param("condition") Map<String, Object> condition);

    Message getMessageDetailByNo(@Param("messageNo") int messageNo);

    // unread 메시지 개수 조회
    int countUnreadMessages(@Param("userNo") int userNo);

    // 단일 메시지 삭제
    void deleteMessage(@Param("messageNo") int messageNo);

    // 단일 메시지 읽음 처리
    void updateReadStatus(@Param("messageRcvNo") int messageRcvNo);

    int findMessageRcvNo(@Param("messageNo") int messageNo, @Param("userNo") int userNo);

    // 다중 메시지 삭제
    void deleteMessages(@Param("messageNos") List<Integer> messageNos);

    // 다중 메시지 읽음 처리
    void updateReadStatuses(@Param("messageNos") List<Integer> messageNos);

}
