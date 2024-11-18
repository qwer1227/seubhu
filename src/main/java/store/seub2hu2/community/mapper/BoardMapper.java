package store.seub2hu2.community.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.community.dto.BoardForm;
import store.seub2hu2.community.vo.Board;
import store.seub2hu2.community.vo.Reply;

import java.util.List;
import java.util.Map;

@Mapper
public interface BoardMapper {

    void insertBoard(@Param("board") Board board);
    List<Board> getBoards(@Param("condition") Map<String, Object> condition);
    int getTotalRowsForBoard(@Param("condition") Map<String, Object> condition);
    Board getBoardByNo(@Param("no") int no);
    void updateBoard(@Param("board") Board board); // 게시글 수정 및 삭제
}
