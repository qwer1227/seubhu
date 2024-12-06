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
import store.seub2hu2.community.dto.CrewForm;
import store.seub2hu2.community.dto.ReplyForm;
import store.seub2hu2.community.dto.ReportForm;
import store.seub2hu2.community.service.CrewReplyService;
import store.seub2hu2.community.service.CrewService;
import store.seub2hu2.community.service.BoardReplyService;
import store.seub2hu2.community.service.ReportService;
import store.seub2hu2.community.view.FileDownloadView;
import store.seub2hu2.community.vo.Crew;
import store.seub2hu2.community.vo.CrewMember;
import store.seub2hu2.community.vo.Reply;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.util.ListDto;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/community/crew")
public class CrewController {

    @Value("C:/files/crew")
    private String saveFileDirectory;

    @Autowired
    public CrewService crewService;

    @Autowired
    public FileDownloadView fileDownloadView;

    @Autowired
    private CrewReplyService crewReplyService;

    @Autowired
    private ReportService reportService;

    @GetMapping("/main")
    public String list(@RequestParam(name = "page", required = false, defaultValue = "1") int page
            , @RequestParam(name = "rows", required = false, defaultValue = "15") int rows
            , @RequestParam(name = "category", required = false) String category
            , @RequestParam(name = "keyword", required = false) String keyword
            , Model model) {

        Map<String, Object> condition = new HashMap<>();
        condition.put("page", page);
        condition.put("rows", rows);

        // 카테고리 필터링 처리
        if (StringUtils.hasText(category)) {
            condition.put("category", category);
        }

        // 검색
        if (StringUtils.hasText(keyword)) {
            condition.put("keyword", keyword);
        }

        ListDto<Crew> dto = crewService.getCrews(condition);

        model.addAttribute("crews", dto.getData());
        model.addAttribute("paging", dto.getPaging());

        return "community/crew/main";
    }

    @GetMapping("/form")
    public String form() {
        return "community/crew/form";
    }
    @GetMapping("/example")
    public String ex() {
        return "community/crew/example";
    }

    @GetMapping("/detail")
    public String detail(@RequestParam("no") int crewNo
                        , @AuthenticationPrincipal LoginUser loginUser
                        , Model model) {
        Crew crew = crewService.getCrewDetail(crewNo);

        List<Reply> replyList = crewReplyService.getReplies(crewNo);
        crew.setReply(replyList);
        int replyCnt = crewReplyService.getReplyCnt(crewNo);

        List<CrewMember> members = crewService.getCrewMembers(crewNo);
        crew.setMember(members);
        int memberCnt = crewService.getEnterMemberCnt(crewNo);

        model.addAttribute("crew", crew);
        model.addAttribute("replies", replyList);
        model.addAttribute("replyCnt", replyCnt);
        model.addAttribute("members", members);
        model.addAttribute("memberCnt", memberCnt);

        for (Reply reply : replyList) {
            int replyResult = crewReplyService.getCheckLike(reply.getNo(), loginUser);
            model.addAttribute("replyLiked", replyResult);
        }

        if (loginUser != null) {
            boolean isExists = false;
            for (CrewMember member : members) {
                if (member.getUser().getNo()== loginUser.getNo()) {
                    isExists = true;
                    break;
                }
            }
            model.addAttribute("isExists", isExists);
        }

        if (memberCnt < 5){
            crewService.updateCrewCondition(crewNo, "Y");
        } else {
            crewService.updateCrewCondition(crewNo, "N");
        }

        return "community/crew/detail";
    }

    @GetMapping("/hit")
    public String hit(@RequestParam("no") int crewNo){
        crewService.updateCrewViewCnt(crewNo);
        return "redirect:detail?no=" + crewNo;
    }

    @PostMapping("/register")
    public String register(CrewForm form
            , @AuthenticationPrincipal LoginUser loginUser) {

        Crew crew = crewService.addNewCrew(form, loginUser);
        return "redirect:detail?no=" + crew.getNo();
    }

    @GetMapping("/modify")
    public String modifyForm(@RequestParam("no") int crewNo
                            , @AuthenticationPrincipal LoginUser loginUser
                            , Model model) {
        Crew crew = crewService.getCrewDetail(crewNo);
        model.addAttribute("crew", crew);

        return "community/crew/modify";
    }

    @PostMapping("/modify")
    public String update(CrewForm form){

        crewService.updateCrew(form);
        return "redirect:detail?no=" + form.getNo();
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("no") int crewNo){
        CrewForm form = new CrewForm();
        form.setNo(crewNo);
        crewService.deleteCrew(crewNo);

        return "redirect:main";
    }

    @GetMapping("/delete-file")
    public String deleteFile(@RequestParam("no") int crewNo
                            , @RequestParam("fileNo") int fileNo){

        crewService.deleteCrewFile(fileNo);
        return "redirect:modify?no=" + crewNo;
    }

    @GetMapping("/filedown")
    public ModelAndView download(@RequestParam("no") int crewNo) {

        Crew crew = crewService.getCrewDetail(crewNo);

        ModelAndView mav = new ModelAndView();

        mav.setView(fileDownloadView);
        mav.addObject("directory", saveFileDirectory);
        mav.addObject("filename", crew.getUploadFile().getSaveName());
        mav.addObject("originalFilename", crew.getUploadFile().getOriginalName());

        return mav;
    }

    @GetMapping("/download")
    public ResponseEntity<Resource> downloadFile(int crewNo) throws Exception{

        Crew crew = crewService.getCrewDetail(crewNo);

        String fileName = crew.getUploadFile().getSaveName();
        String originalFileName = crew.getUploadFile().getOriginalName();
        originalFileName = URLEncoder.encode(originalFileName, "UTF-8");

        File file = new File(new File(saveFileDirectory), fileName);
        FileSystemResource resource = new FileSystemResource(file);

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + originalFileName)
                .body(resource);
    }

    @GetMapping("/login")
    public String login(){
        return "redirect:../user/login";
    }

    @GetMapping("/add-reply")
    @PreAuthorize("isAuthenticated()")
    public String addReply(ReplyForm form
            , @AuthenticationPrincipal LoginUser loginUser) {

        crewReplyService.addNewReply(form, loginUser);
        return "redirect:detail?no=" + form.getCrewNo();
    }

    @PostMapping("/add-comment")
    @PreAuthorize("isAuthenticated()")
    public String addComment(ReplyForm form
            , @AuthenticationPrincipal LoginUser loginUser){

        crewReplyService.addNewComment(form, loginUser);
        return "redirect:detail?no=" + form.getCrewNo();
    }

    @PostMapping("/modify-reply")
    @PreAuthorize("isAuthenticated()")
    public String modifyReply(@RequestParam("replyNo") int replyNo
            , @RequestParam("crewNo") int crewNo
            , @RequestParam("content") String replyContent
            , @AuthenticationPrincipal LoginUser loginUser){

        ReplyForm form = new ReplyForm();
        form.setNo(replyNo);
        form.setCrewNo(crewNo);
        form.setContent(replyContent);
        form.setUserNo(loginUser.getNo());

        crewReplyService.updateReply(form);

        return "redirect:detail?no=" + form.getCrewNo();
    }

    @GetMapping("/delete-reply")
    @PreAuthorize("isAuthenticated()")
    public String deleteReply(@RequestParam("rno") int replyNo,
                              @RequestParam("cno") int crewNo){

        ReplyForm form = new ReplyForm();
        form.setNo(replyNo);
        form.setCrewNo(crewNo);
        crewReplyService.deleteReply(replyNo);

        return "redirect:detail?no=" + form.getCrewNo();
    }

    @GetMapping("/update-reply-like")
    public String updateReplyLke(@RequestParam("no") int crewNo
            , @RequestParam("rno") int replyNo
            , @AuthenticationPrincipal LoginUser loginUser){

        crewReplyService.updateReplyLike(replyNo, loginUser);
        return "redirect:detail?no=" + crewNo;
    }

    @GetMapping("/delete-reply-like")
    public String updateReplyUnlike(@RequestParam("no") int crewNo
            , @RequestParam("rno") int replyNo
            , @AuthenticationPrincipal LoginUser loginUser){

        crewReplyService.deleteReplyLike(replyNo, loginUser);
        return "redirect:detail?no=" + crewNo;
    }

    @PostMapping("/report-crew")
    public String reportCrew(ReportForm form
            , @AuthenticationPrincipal LoginUser loginUser){

        reportService.registerReportToCrew(form, loginUser);
        return "redirect:detail?no=" + form.getNo();
    }

    @PostMapping("report-reply")
    public String reportReply(ReportForm form
            , @RequestParam("cno") int crewNo
            , @AuthenticationPrincipal LoginUser loginUser){

        reportService.registerReportToCrew(form, loginUser);
        return "redirect:detail?no=" + crewNo;
    }

    @GetMapping("/enter-crew")
    public String enterCrew(@RequestParam("no") int crewNo
            , @AuthenticationPrincipal LoginUser loginUser){
        crewService.enterCrew(crewNo, loginUser);
        return "redirect:detail?no=" + crewNo;
    }

    @GetMapping("/leave-crew")
    public String leaveCrew(@RequestParam("no") int crewNo
            , @AuthenticationPrincipal LoginUser loginUser){
        crewService.leaveCrew(crewNo, loginUser);
        return "redirect:detail?no=" + crewNo;
    }
}
