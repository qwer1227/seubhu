package store.seub2hu2.community.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import store.seub2hu2.community.dto.RegisterBoardForm;
import store.seub2hu2.community.dto.ModifyBoardForm;
import store.seub2hu2.community.dto.ReplyForm;
import store.seub2hu2.community.service.BoardService;
import store.seub2hu2.community.service.ReplyService;
import store.seub2hu2.community.view.FileDownloadView;
import store.seub2hu2.community.vo.Board;
import store.seub2hu2.community.vo.BoardCategory;
import store.seub2hu2.community.vo.Reply;
import store.seub2hu2.community.vo.UploadFile;
import store.seub2hu2.security.LoginUser;
import store.seub2hu2.util.FileUtils;
import store.seub2hu2.util.ListDto;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller("communityController")
@RequestMapping("/community")
public class BoardController {

    @Value("${upload.directory.community}")
    private String saveDirectory;

    @Autowired
    public BoardService boardService;

    @Autowired
    public ReplyService replyService;

    @Autowired
    public FileDownloadView fileDownloadView;

    @GetMapping("write")
    public String write(){
        return "community/write";
    }

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
    public String detail(@RequestParam("no") Integer no, Model model) {
        Board board = boardService.getBoardDetail(no);
        List<Reply> replyList = replyService.getReplies(no);
        board.setReply(replyList);
        model.addAttribute("board", board);
        model.addAttribute("replies", replyList);

        return "community/detail";
    }

    @GetMapping("/register")
    public String form() {
        return "community/form";
    }

    @PostMapping("/register")
//    @PreAuthorize("isAuthenticated()")
    public String register(RegisterBoardForm boardForm){
//                          , @AuthenticationPrincipal LoginUser loginUser) {

        boardService.addNewBoard(boardForm);
        return "redirect:main";
//        return "redirect:detail?no=" + board.getNo();
    }

    @GetMapping("/modify")
    public String modifyForm(@RequestParam("no") Integer boardNo, Model model) {
        Board board = boardService.getBoardDetail(boardNo);
        model.addAttribute("board", board);

        return "community/modify";
    }

    @PostMapping("/modify")
    public String update(ModifyBoardForm form) {
        boardService.updateBoard(form);
        return "redirect:detail?no=" + form.getNo();
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("no") int boardNo) {
        ModifyBoardForm form = new ModifyBoardForm();
        form.setNo(boardNo);
        boardService.deleteBoard(boardNo);
        return "redirect:main";
    }

//    @GetMapping("/deleteUploadFile")
//    public String deleteUploadFile(@RequestParam("no") int boardNo) {
//        boardService.deleteBoardFile(boardNo);
//
//        return "redirect:modify?no=" + boardNo;
//    }

    // 요청 URL : comm/filedown?no=xxx
    @GetMapping("/filedown")
    public ModelAndView download(@RequestParam("no") int boardNo) {
        Board board = boardService.getBoardDetail(boardNo);

        ModelAndView mav = new ModelAndView();

        mav.setView(fileDownloadView);
        mav.addObject("directory", saveDirectory);
        mav.addObject("filename", board.getUploadFile().getSaveName());
        mav.addObject("originalFilename", board.getOriginalFileName());

        return mav;
    }

    @GetMapping("download")
    public ResponseEntity<Resource> downloadFile(int boardNo) throws Exception{
        Board board = boardService.getBoardDetail(boardNo);

        String fileName = board.getUploadFile().getSaveName();
        String originalFileName = board.getOriginalFileName();
        originalFileName = URLEncoder.encode(originalFileName, "UTF-8");

        File file = new File(new File(saveDirectory), fileName);
        FileSystemResource resource = new FileSystemResource(file);

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + originalFileName)
                .body(resource);
    }

    @GetMapping("add-reply")
//    @PreAuthorize("isAuthenticated()")
    public String addReply(ReplyForm form){
//            , @AuthenticationPrincipal LoginUser loginUser) {
        replyService.addNewReply(form, 11);

        return "redirect:detail?no=" + form.getBoardNo();
    }

    @PostMapping("add-comment")
    public String addComment(ReplyForm form){
        replyService.addNewComment(form, 11);

        return "redirect:detail?no=" + form.getBoardNo();
    }

    @GetMapping("delete-reply")
    public String deleteReply(@RequestParam("no") int replyNo){
        ReplyForm form = new ReplyForm();
        form.setNo(replyNo);
        replyService.deleteReply(replyNo);

        return "redirect:detail?no=" + form.getBoardNo();
    }
}
