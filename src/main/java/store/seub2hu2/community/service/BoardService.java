package store.seub2hu2.community.service;

import lombok.extern.slf4j.Slf4j;
import org.eclipse.tags.shaded.org.apache.bcel.generic.IF_ACMPEQ;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.community.dto.BoardForm;
import store.seub2hu2.community.exception.CommunityException;
import store.seub2hu2.community.mapper.BoardMapper;
import store.seub2hu2.community.mapper.BoardUploadMapper;
import store.seub2hu2.community.mapper.ReplyMapper;
import store.seub2hu2.community.vo.Board;
import store.seub2hu2.community.vo.Reply;
import store.seub2hu2.community.vo.UploadFile;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.user.vo.User;
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
    @Autowired
    private ReplyMapper replyMapper;

    public void addNewBoard(BoardForm form
                , @AuthenticationPrincipal LoginUser loginUser) {
        // Board 객체를 생성하여 사용자가 입력한 제목과 내용을 저장한다.
        Board board = new Board();
        board.setNo(form.getNo());
        board.setCatName(form.getCatName());
        board.setTitle(form.getTitle());
        board.setContent(form.getContent());

        User user = new User();
        user.setNo(loginUser.getNo());
        user.setNickname(loginUser.getNickname());
        board.setUser(user);

        MultipartFile multipartFile = form.getUpfile();

        // 첨부파일이 있으면 실행
        if (!multipartFile.isEmpty()) {
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

    public ListDto<Board> getBoards(Map<String, Object> condition) {
        // 검색 조건에 맞는 데이터 전체 갯수 조회
        int totalRows = boardMapper.getTotalRowsForBoard(condition);

        // pagination 객체 생성
        int page = (Integer) condition.get("page");
        int rows = (Integer) condition.get("rows");
        Pagination pagination = new Pagination(page, totalRows, rows);

        //데이터 검색범위를 조회해서 Map에 저장
        condition.put("begin", pagination.getBegin());
        condition.put("end", pagination.getEnd());

        // 조회범위에 맞는 데이터 조회하기
        List<Board> boards = boardMapper.getBoards(condition);
        ListDto<Board> dto = new ListDto<>(boards, pagination);

        return dto;
    }

    public Board getBoardDetail(int boardNo) {
        Board board = boardMapper.getBoardDetailByNo(boardNo);
        UploadFile uploadFile = boardUploadMapper.getFileByBoardNo(boardNo);
        List<Reply> reply = replyMapper.getRepliesByBoardNo(boardNo);


        if (board == null) {
            throw new CommunityException("존재하지 않는 게시글입니다.");
        }

        board.setViewCnt(board.getViewCnt() + 1);
        board.setUploadFile(uploadFile);
        board.setReply(reply);

        User user = new User();
        user.setNo(board.getUser().getNo());
        user.setNickname(board.getUser().getNickname());
        board.setUser(user);

        boardMapper.updateBoardCnt(board);
        return board;
    }

    public void updateBoard(BoardForm form) {
        Board savedBoard = boardMapper.getBoardDetailByNo(form.getNo());
        savedBoard.setTitle(form.getTitle());
        savedBoard.setContent(form.getContent());
        savedBoard.setCatName(form.getCatName());

        MultipartFile multipartFile = form.getUpfile();

        // 수정할 첨부파일이 있으면,
        if (!multipartFile.isEmpty()) {
            // 기존 파일 정보를 조회
            UploadFile prevFile = boardUploadMapper.getFileByBoardNo(savedBoard.getNo());
            // 기존 파일 정보가 존재하면 기존 파일 삭제
            if (prevFile != null) {
                prevFile.setDeleted("Y");
                boardUploadMapper.updateBoardFile(prevFile);
            }

            // 신규파일 정보를 조회하여 BOARD_UPLOADFILES 테이블에 저장
            String originalFilename = multipartFile.getOriginalFilename();
            String filename = System.currentTimeMillis() + originalFilename;
            FileUtils.saveMultipartFile(multipartFile, saveDirectory, filename);

            UploadFile uploadFile = new UploadFile();
            uploadFile.setOriginalName(originalFilename);
            uploadFile.setSaveName(filename);
            uploadFile.setBoardNo(savedBoard.getNo());
            savedBoard.setUploadFile(uploadFile);

            boardUploadMapper.insertBoardFile(uploadFile);
        }

        // 수정한 게시글 내용을 BOARDS 테이블에 저장
        boardMapper.updateBoard(savedBoard);
    }

    public void deleteBoard(int boardNo) {
        Board savedBoard = boardMapper.getBoardDetailByNo(boardNo);
        savedBoard.setDeleted("Y");

        boardMapper.updateBoard(savedBoard);
    }

    public void deleteBoardFile(int boardNo, int fileNo) {
        UploadFile uploadFile = boardUploadMapper.getFileByBoardNo(boardNo);
        uploadFile.setNo(fileNo);
        uploadFile.setDeleted("Y");

        boardUploadMapper.updateBoardFile(uploadFile);
    }

    public void updateBoardLikeCnt(int boardNo, int cnt){
        Board board = boardMapper.getBoardDetailByNo(boardNo);
        board.setNo(boardNo);
        board.setLike(cnt);

        boardMapper.updateBoardCnt(board);
    }
}
