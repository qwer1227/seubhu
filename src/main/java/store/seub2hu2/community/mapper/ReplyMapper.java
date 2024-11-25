package store.seub2hu2.community.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.community.vo.Board;
import store.seub2hu2.community.vo.Reply;

import java.util.List;
import java.util.Map;

@Mapper
public interface ReplyMapper {

    void updateReply(@Param("reply") Reply reply);
    void insertReply(@Param("reply") Reply reply);
    List<Reply> getRepliesByBoardNo(@Param("no") int boardNo);
    Reply getReplyByReplyNo(@Param("no") int replyNo);
    void deleteReplyByNo(@Param("no") int replyNo);
}
