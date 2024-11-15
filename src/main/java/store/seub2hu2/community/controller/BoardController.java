package store.seub2hu2.community.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.community.dto.AddBoardFileForm;
import store.seub2hu2.community.dto.BoardForm;
import store.seub2hu2.community.service.BoardService;
import store.seub2hu2.community.vo.Board;
import store.seub2hu2.community.vo.BoardCategory;
import store.seub2hu2.util.FileUtils;
import store.seub2hu2.util.ListDto;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller("communityController")
@RequestMapping("/community")
public class BoardController {

    @Value("${upload.directory.community}")
    private String saveDirectory;

    @Autowired
    public BoardService boardService;

    @GetMapping("/main")
    public String list(@RequestParam(name = "page", required = false, defaultValue = "1") int page
            , @RequestParam(name = "rows", required = false, defaultValue = "10") int rows
            , @RequestParam(name = "sort", required = false, defaultValue = "date") String sort
            , @RequestParam(name = "opt", required = false) String opt
            , @RequestParam(name = "keyword", required = false) String keyword
            , @RequestParam(name = "category", required = false) String category
            , Model model) {


        Map<String, Object> condition = new HashMap<>();
        condition.put("page", page);
        condition.put("rows", rows);
        condition.put("sort", sort);

        // 카테고리 필터링 처리
        if (StringUtils.hasText(category)) {
            condition.put("category", category);
        }

        if (StringUtils.hasText(keyword)){
            condition.put("opt", opt);
            condition.put("keyword", keyword);
        }

        ListDto<Board> dto = boardService.getBoards(condition);

        model.addAttribute("boards", dto.getData());
        model.addAttribute("paging", dto.getPaging());

        return "community/main";
    }

    @GetMapping("/form")
    public String form(@RequestParam(name="boardNo", required = false) Integer boardNo, Model model) {
        Board board = new Board();
        // boardNo가 있으면, 해당하는 게시글번호의 board 반환
        if (boardNo != null) {
            board = boardService.getBoardByNo(boardNo);
        }
        model.addAttribute("board", board);
        return "community/form";
    }

    @GetMapping("/detail")
    public String detail(int no, Model model) {

        Board board = boardService.getBoardDetail(no);
        model.addAttribute("board", board);

        return "community/detail";
    }

    // 나중에 구현 완료되면 지울 코드
    @GetMapping("/write")
    public String write() {
        return "community/write";
    }

    @PostMapping("/register")
//    @PreAuthorize("isAuthenticated()")
    public String register(BoardForm boardForm
        ,@RequestParam(value = "upfile", required = false)AddBoardFileForm addBoardFileForm){
//                          , @AuthenticationPrincipal LoginUser loginUser) {
        // Board 객체를 생성하여 사용자가 입력한 제목과 내용을 저장한다.
        Board board = new Board();
        board.setCatName(boardForm.getCatName());
        board.setNo(boardForm.getNo());
        board.setTitle(boardForm.getTitle());
        board.setContent(boardForm.getContent());

//        User user = User.builder().no(loginUser.getNo()).build();
//        board.setUser(user);

        if (addBoardFileForm != null){
            MultipartFile multipartFile = boardForm.getFilename();

            if(!multipartFile.isEmpty()) {
                String originalFilename = multipartFile.getOriginalFilename();
                String filename = System.currentTimeMillis() + originalFilename;
                FileUtils.saveMultipartFile(multipartFile, saveDirectory, filename);
                board.setFilename(filename);
            }
        }
        boardService.addNewBoard(board);
        return "redirect:main";
//        return "redirect:detail?no=" + board.getNo();
    }

    @GetMapping("/modify")
    public String update(BoardForm boardForm) {
        Board board = new Board();
        board.setCatName(boardForm.getCatName());
        board.setTitle(boardForm.getTitle());
        board.setContent(boardForm.getContent());
        board.setUpdatedDate(new Date());

        boardService.updateBoard(boardForm);
        return "redirect:detail?no=" + boardForm.getNo();
    }

    @GetMapping("/delete")
    public String delete(BoardForm boardForm) {
        Board board = new Board();
        board.setIsDeleted(boardForm.getIsDeleted());

        boardService.updateBoard(boardForm);
        return "/community/main";
    }
}
