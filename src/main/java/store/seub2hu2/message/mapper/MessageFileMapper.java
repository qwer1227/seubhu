package store.seub2hu2.message.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.message.vo.MessageFile;

import java.util.List;

@Mapper
public interface MessageFileMapper {

    void insertMessageFile(@Param("messageFile") MessageFile messageFile); // 파일 삽입
    List<MessageFile> getMessageFiles(); // 모든 파일 조회
    MessageFile getFileByMessageNo(int messageNo); // 메시지 번호로 파일 조회
    void updateMessageFile(MessageFile messageFile); // 파일 업데이트
}
