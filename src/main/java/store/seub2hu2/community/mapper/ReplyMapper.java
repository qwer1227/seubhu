package store.seub2hu2.community.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.community.vo.Board;
import store.seub2hu2.community.vo.Reply;

import java.util.List;

@Mapper
public interface ReplyMapper {

    void insertReply(@Param("reply") Reply reply);
    List<Reply> getRepliesByBoardNo(@Param("boardNo") int boardNo);
}
