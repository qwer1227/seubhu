package store.seub2hu2.community.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.community.dto.ModifyBoardForm;
import store.seub2hu2.community.dto.RegisterBoardForm;
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

    @Autowired
    private BoardUploadMapper boardUploadMapper;

    @Value("${upload.directory.community}")
    private String saveDirectory;

    public void addNewBoard(RegisterBoardForm form){
        // Board 객체를 생성하여 사용자가 입력한 제목과 내용을 저장한다.
        Board board = new Board();
        board.setCatName(form.getCatName());
        board.setTitle(form.getTitle());
        board.setContent(form.getContent());

//        User user = User.builder().no(loginUser.getNo()).build();
//        board.setUser(user);
        MultipartFile multipartFile = form.getUpfile();

        // 첨부파일이 있으면 실행
        if(!multipartFile.isEmpty()) {
            String originalFilename = multipartFile.getOriginalFilename();
            String filename = System.currentTimeMillis() + originalFilename;
            FileUtils.saveMultipartFile(multipartFile, saveDirectory, filename);

            UploadFile uploadFile = new UploadFile();
            uploadFile.setOriginalName(originalFilename);
            uploadFile.setSaveName(filename);

            board.setUploadFile(uploadFile);
        }
        // board -> {no:0, ....}
        boardMapper.insertBoard(board);
        // board -> {no:34, }

        // 첨부파일이 있으면 실행
        // boardMapper.insertBoard()를 통해 board_no를 얻은 후에 실행해야 함
        if (board.getUploadFile() != null) {
            UploadFile uploadFile = board.getUploadFile();
            uploadFile.setBoardNo(board.getNo());
            uploadFile.setSaveName(board.getUploadFile().getSaveName());
            uploadFile.setOriginalName(board.getOriginalFileName());
            // UploadFile 테이블에 저장
            boardUploadMapper.insertBoardFile(uploadFile);
        }
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
        return board;
    }

    public void updateBoard(ModifyBoardForm form){
        Board savedBoard = boardMapper.getBoardDetailByNo(form.getNo());
        savedBoard.setTitle(form.getTitle());
        savedBoard.setContent(form.getContent());
        savedBoard.setCatName(form.getCatName());

        MultipartFile multipartFile = form.getUpfile();

        if (!multipartFile.isEmpty()) {
            String originalFilename = multipartFile.getOriginalFilename();
            String filename = System.currentTimeMillis() + originalFilename;
            FileUtils.saveMultipartFile(multipartFile, saveDirectory, filename);

            UploadFile uploadFile = new UploadFile();
            uploadFile.setOriginalName(originalFilename);
            uploadFile.setSaveName(filename);
            savedBoard.setUploadFile(uploadFile);
        }

        boardMapper.updateBoard(savedBoard);

        if (savedBoard.getUploadFile() != null) {
            UploadFile uploadFile = savedBoard.getUploadFile();
            uploadFile.setBoardNo(savedBoard.getNo());
            uploadFile.setSaveName(savedBoard.getUploadFile().getSaveName());
            uploadFile.setOriginalName(savedBoard.getOriginalFileName());

            boardUploadMapper.insertBoardFile(uploadFile);
        }
    }

    public void deleteBoard(int boardNo){
        Board savedBoard = boardMapper.getBoardDetailByNo(boardNo);
        savedBoard.setDeleted("Y");

        boardMapper.updateBoard(savedBoard);
    }

    public void deleteBoardFile(int boardNo, int fileNo){
        UploadFile savedFile = boardUploadMapper.getBoardFileByBoardNo(boardNo);
        savedFile.setDeleted("Y");
        savedFile.setNo(fileNo);

        boardUploadMapper.updateBoardFile(savedFile);
    }

    public Board getBoardByNo(int boardNo) {
        return boardMapper.getBoardDetailByNo(boardNo);
    }
}
