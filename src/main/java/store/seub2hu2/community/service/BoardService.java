package store.seub2hu2.community.service;

import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.community.dto.BoardForm;
import store.seub2hu2.community.exception.CommunityException;
import store.seub2hu2.community.mapper.BoardMapper;
import store.seub2hu2.community.vo.Board;
import store.seub2hu2.util.ListDto;
import store.seub2hu2.util.Pagination;

import java.util.List;
import java.util.Map;

@Slf4j
@Service
@Transactional
public class BoardService {

    @Autowired
    private BoardMapper boardMapper;

    public void addNewBoard(Board board){
        boardMapper.insertBoard(board);
    }

    public ListDto<Board> getBoards(Map<String,Object> condition){
        // 검색 조건에 맞는 데이터 전체 갯수 조회
        int totalRows = boardMapper.getTotalRows(condition);

        // pagination 객체 생성
        int page = (Integer)condition.get("page");
        int rows = (Integer)condition.get("rows");
        Pagination pagination = new Pagination(page, totalRows, rows);

        //데이터 검색범위를 조회해서 Map에 저장
        condition.put("begin", pagination.getBegin());
        condition.put("end", pagination.getEnd());

        // 조회범위에 맞는 데이터 조회하기
        List<Board> boards = boardMapper.getBoards(condition);
        ListDto<Board> dto = new ListDto<>(boards, pagination);

        return dto;
    }

    public Board getBoardDetail(int boardNo){
        Board board = boardMapper.getBoardByNo(boardNo);

        if(board == null){
            throw new CommunityException("존재하지 않는 게시글입니다.");
        }

        return board;
    }

    public void updateBoard(BoardForm boardForm){
        boardMapper.updateBoard(boardForm);
    }

    public Board getBoardByNo(int boardNo) {
        return boardMapper.getBoardByNo(boardNo);
    }
}
