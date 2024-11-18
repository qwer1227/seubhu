package store.seub2hu2.community.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.community.dto.ModifyBoardForm;
import store.seub2hu2.community.exception.CommunityException;
import store.seub2hu2.community.mapper.BoardMapper;
import store.seub2hu2.community.mapper.BoardUploadMapper;
import store.seub2hu2.community.vo.Board;
import store.seub2hu2.community.vo.UploadFile;
import store.seub2hu2.util.FileUtils;
import store.seub2hu2.util.ListDto;
import store.seub2hu2.util.Pagination;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@Transactional
public class BoardService {

    @Autowired
    private BoardMapper boardMapper;

    @Value("${upload.directory.community}")
    private String saveDirectory;

    public void addNewBoard(Board board){
        boardMapper.insertBoard(board);
    }

    public ListDto<Board> getBoards(Map<String,Object> condition){
        // 검색 조건에 맞는 데이터 전체 갯수 조회
        int totalRows = boardMapper.getTotalRowsForBoard(condition);

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
        Board board = boardMapper.getBoardDetailByNo(boardNo);
        if(board == null){
            throw new CommunityException("존재하지 않는 게시글입니다.");
        }
        board.setViewCnt(board.getViewCnt() + 1);
        boardMapper.updateBoard(board);

        return board;
    }

    public void updateBoard(ModifyBoardForm form){
        Board savedBoard = boardMapper.getBoardDetailByNo(form.getNo());
        savedBoard.setTitle(form.getTitle());
        savedBoard.setContent(form.getContent());
        savedBoard.setCatName(form.getCatName());
        savedBoard.setNo(form.getNo());
        savedBoard.setIsDeleted("N");
        savedBoard.setUpdatedDate(new Date());

        MultipartFile multipartFile = form.getUpfile();

        if (multipartFile != null || !multipartFile.isEmpty()) {
            String originalFilename = multipartFile.getOriginalFilename();
            String filename = System.currentTimeMillis() + originalFilename;
            FileUtils.saveMultipartFile(multipartFile, saveDirectory, filename);

            UploadFile uploadFile = new UploadFile();
            uploadFile.setOriginalName(originalFilename);
            uploadFile.setSaveName(filename);
            savedBoard.setUploadFile(uploadFile);
        } else {
            savedBoard.setUploadFile(null);
        }

        boardMapper.updateBoard(savedBoard);
    }

    public void deleteBoard(int boardNo){
        Board savedBoard = boardMapper.getBoardDetailByNo(boardNo);
        savedBoard.setIsDeleted("Y");

        boardMapper.updateBoard(savedBoard);
    }

    public Board getBoardByNo(int boardNo) {
        return boardMapper.getBoardDetailByNo(boardNo);
    }
}
