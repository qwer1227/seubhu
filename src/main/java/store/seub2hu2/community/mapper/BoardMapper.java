package store.seub2hu2.community.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.community.vo.Board;

import java.util.List;
import java.util.Map;

@Mapper
public interface BoardMapper {

    void insertBoard(@Param("board") Board board);
    List<Board> getBoards(@Param("condition") Map<String, Object> condition);
    int getTotalRows(@Param("condition") Map<String, Object> condition);
    Board getBoardByNo(@Param("no") int no);
}
