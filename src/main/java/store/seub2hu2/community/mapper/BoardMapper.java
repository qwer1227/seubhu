package store.seub2hu2.community.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.community.vo.Board;

import java.util.List;

@Mapper
public interface BoardMapper {

    void insertBoard(@Param("board") Board board);
    List<Board> getAllBoards(@Param("board") Board board);
}
