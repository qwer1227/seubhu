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
import org.springframework.web.servlet.ModelAndView;
import store.seub2hu2.community.dto.BoardForm;
import store.seub2hu2.community.dto.ReplyForm;
import store.seub2hu2.community.service.BoardService;
import store.seub2hu2.community.service.ReplyService;
import store.seub2hu2.community.view.FileDownloadView;
import store.seub2hu2.community.vo.Board;
import store.seub2hu2.community.vo.Reply;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.user.service.UserService;
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
    public FileDownloadView fileDownloadView;

    @Autowired
    private ReplyService replyService;

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


    @GetMapping("/detail")
    public String detail(@RequestParam("no") int boardNo
                         , @AuthenticationPrincipal LoginUser loginUser
                         , Model model) {
        Board board = boardService.getBoardDetail(boardNo);
        List<Reply> replyList = replyService.getReplies(boardNo);
        board.setReply(replyList);

        if (loginUser != null) {
            int boardResult = boardService.getCheckLike(boardNo, loginUser);
            model.addAttribute("boardLiked", boardResult);

            for (Reply reply : replyList) {
                int replyResult = replyService.getCheckLike(reply.getNo(), loginUser);
                model.addAttribute("replyLiked", replyResult);
            }
        }

        model.addAttribute("board", board);
        model.addAttribute("replies", replyList);

        return "community/detail";
    }

    @GetMapping("/form")
    public String form() {
        return "community/form";
    }

    @PostMapping("/register")
//    @PreAuthorize("isAuthenticated()")
    public String register(BoardForm form
            , @AuthenticationPrincipal LoginUser loginUser) {
        boardService.addNewBoard(form, loginUser);

        return "redirect:main";
    }

    @GetMapping("/modify")
    public String modifyForm(@RequestParam("no") Integer boardNo
            , @AuthenticationPrincipal LoginUser loginUser
            , Model model) {
        Board board = boardService.getBoardDetail(boardNo);

        model.addAttribute("board", board);

        return "community/modify";
    }

    @PostMapping("/modify")
    public String update(BoardForm form) {
        boardService.updateBoard(form);
        return "redirect:detail?no=" + form.getNo();
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("no") int boardNo) {
        BoardForm form = new BoardForm();
        form.setNo(boardNo);
        boardService.deleteBoard(boardNo);
        return "redirect:main";
    }

    @GetMapping("/delete-file")
    public String deleteUploadFile(@RequestParam("no") int boardNo
                                   , @RequestParam("fileNo") int fileNo) {
        boardService.deleteBoardFile(boardNo, fileNo);

        return "redirect:modify?no=" + boardNo;
    }

    // 요청 URL : comm/filedown?no=xxx
    @GetMapping("/filedown")
    public ModelAndView download(@RequestParam("no") int boardNo
                                , @AuthenticationPrincipal LoginUser loginUser) {
        Board board = boardService.getBoardDetail(boardNo);

        ModelAndView mav = new ModelAndView();

        mav.setView(fileDownloadView);
        mav.addObject("directory", saveDirectory);
        mav.addObject("filename", board.getUploadFile().getSaveName());
        mav.addObject("originalFilename", board.getOriginalFileName());

        return mav;
    }

    @GetMapping("/download")
    public ResponseEntity<Resource> downloadFile(int boardNo
                                        , @AuthenticationPrincipal LoginUser loginUser) throws Exception{
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

    @GetMapping("/login")
    public String login(){
        return "redirect:/user/login";
    }
    @GetMapping("/add-reply")
    @PreAuthorize("isAuthenticated()")
    public String addReply(ReplyForm form
            , @AuthenticationPrincipal LoginUser loginUser) {

        replyService.addNewReply(form, loginUser);

        return "redirect:detail?no=" + form.getBoardNo();
    }

    @PostMapping("/add-comment")
    @PreAuthorize("isAuthenticated()")
    public String addComment(ReplyForm form
            , @AuthenticationPrincipal LoginUser loginUser){
        replyService.addNewComment(form, loginUser);

        return "redirect:detail?no=" + form.getBoardNo();
    }

    @PostMapping("/modify-reply")
    @PreAuthorize("isAuthenticated()")
    public String modifyReply(@RequestParam("replyNo") int replyNo
                              , @RequestParam("boardNo") int boardNo
                              , @RequestParam("content") String replyContent
                              , @AuthenticationPrincipal LoginUser loginUser){
        ReplyForm form = new ReplyForm();
        form.setNo(replyNo);
        form.setBoardNo(boardNo);
        form.setContent(replyContent);
        form.setUserNo(loginUser.getNo());

        replyService.updateReply(form);

        return "redirect:detail?no=" + form.getBoardNo();
    }

    @GetMapping("/delete-reply")
    @PreAuthorize("isAuthenticated()")
    public String deleteReply(@RequestParam("rno") int replyNo,
                              @RequestParam("bno") int boardNo){
        ReplyForm form = new ReplyForm();
        form.setNo(replyNo);
        form.setBoardNo(boardNo);
        replyService.deleteReply(replyNo);

        return "redirect:detail?no=" + form.getBoardNo();
    }

    @GetMapping("/update-board-like")
    public String updateBoardLike(@RequestParam("no") int boardNo
            , @AuthenticationPrincipal LoginUser loginUser){
        boardService.updateBoardLike(boardNo, loginUser);
        return "redirect:detail?no=" + boardNo;
    }

    @GetMapping("/update-board-unlike")
    public String updateBoardUnlike(@RequestParam("no") int boardNo
            , @AuthenticationPrincipal LoginUser loginUser){
        boardService.updateBoardUnlike(boardNo, loginUser);
        return "redirect:detail?no=" + boardNo;
    }

    @GetMapping("/update-reply-like")
    public String updateReplyLke(@RequestParam("no") int boardNo
                                , @RequestParam("rno") int replyNo
                                , @AuthenticationPrincipal LoginUser loginUser){

        System.out.println("===================reply 번호 : " + replyNo);
        System.out.println("===================user 번호 : " + loginUser.getNo());

        replyService.updateReplyLike(replyNo, loginUser);
        return "redirect:detail?no=" + boardNo;
    }

    @GetMapping("/update-reply-unlike")
    public String updateReplyUnlike(@RequestParam("no") int boardNo
                                    , @RequestParam("rno") int replyNo
                                    , @AuthenticationPrincipal LoginUser loginUser){
        replyService.updateReplyUnlike(replyNo, loginUser);
        return "redirect:detail?no=" + boardNo;
    }
}
