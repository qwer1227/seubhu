package store.seub2hu2.community.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import store.seub2hu2.community.dto.BoardForm;
import store.seub2hu2.community.service.BoardService;
import store.seub2hu2.community.vo.Board;
import store.seub2hu2.security.LoginUser;
import store.seub2hu2.user.vo.User;
import store.seub2hu2.util.ListDto;

import java.util.HashMap;
import java.util.Map;

@Controller("communityController")
@RequestMapping("/community")
public class BoardController {

    @Value("")
    private String saveDirectory;

    @Autowired
    public BoardService boardService;

    @GetMapping("/main")
    public String Community(@RequestParam(name = "page", required = false, defaultValue = "1") int page
            , @RequestParam(name = "rows", required = false, defaultValue = "10") int rows
            , @RequestParam(name = "sort", required = false, defaultValue = "date") String sort
            , @RequestParam(name = "opt", required = false) String opt
            , @RequestParam(name = "value", required = false) String value
            , Model model) {

        Map<String, Object> condition = new HashMap<>();
        condition.put("page", page);
        condition.put("rows", rows);
        condition.put("sort", sort);
        if (StringUtils.hasText(value)){
            condition.put("opt", opt);
            condition.put("value", value);
        }

        ListDto<Board> dto = boardService.getAllBoards(condition);
        model.addAttribute("boards", dto.getData());
        model.addAttribute("paging", dto.getPaging());
        return "community/main";
    }

    @GetMapping("/form")
    public String list() {
        return "community/form";
    }

    @GetMapping("/detail")
    public String detail(int no, Model model) {
        Board board = boardService.getBoardByNo(no);
        model.addAttribute("board", board);

        return "community/detail";
    }

    @GetMapping("/write")
    public String write() {
        return "community/write";
    }

    @PostMapping("/register")
//    @PreAuthorize("isAuthenticated()")
    public String register(BoardForm boardForm){
//                          , @AuthenticationPrincipal LoginUser loginUser) {
        // Board 객체를 생성하여 사용자가 입력한 제목과 내용을 저장한다.
        Board board = new Board();
        board.setTitle(boardForm.getTitle());
        board.setContent(boardForm.getContent());

//        MultipartFile multipartFile = boardForm.getFilename();
//
//        if(!multipartFile.isEmpty()) {
//            String originalFilename = multipartFile.getOriginalFilename();
//            String filename = System.currentTimeMillis() + originalFilename;
//            FileUtils.saveMultipartFile(multipartFile, saveDirectory, filename);
//            board.setFilename(filename);
//        }

        boardService.insertBoard(board);

        return "redirect:main";
    }
}
