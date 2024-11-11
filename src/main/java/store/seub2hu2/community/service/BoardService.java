package store.seub2hu2.community.service;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.community.dto.BoardForm;
import store.seub2hu2.community.mapper.BoardMapper;
import store.seub2hu2.community.vo.Board;
import store.seub2hu2.util.ListDto;
import store.seub2hu2.util.Pagination;

import java.util.List;
import java.util.Map;

@Service
@Transactional
public class BoardService {

    @Autowired
    private BoardMapper boardMapper;

    public void insertBoard(Board board){
        boardMapper.insertBoard(board);
    }

    public ListDto<Board> getAllBoards(Map<String,Object> condition){
        // 검색 조건에 맞는 데이터 전체 갯수 조회
        int totalRows = boardMapper.getTotalRows(condition);

        // pagination 객체 생성
        int page = (Integer)condition.get("page");
        int rows = (Integer)condition.get("rows");
        Pagination pagination = new Pagination(totalRows, page, rows);

        //데이터 검색범위를 조회해서 Map에 저장
        int begin = pagination.getBegin();
        int end = pagination.getEnd();
        condition.put("begin", begin);
        condition.put("end", end);

        // 조회범위에 맞는 데이터 조회하기
        List<Board> boards = boardMapper.getAllBoards(condition);
        ListDto<Board> dto = new ListDto<>(boards, pagination);

        return dto;
    }

    public Board getBoardByNo(int boardNo){
        Board board = boardMapper.getBoardByNo(boardNo);

//        if(board == null){
//            throw new Exception("관리자에 의해 삭제된 게시글입니다.");
//        }

        return board;
    }
}
