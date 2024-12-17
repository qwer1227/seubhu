package store.seub2hu2.community.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import store.seub2hu2.community.dto.NoticeForm;
import store.seub2hu2.community.service.NoticeService;
import store.seub2hu2.community.vo.Board;
import store.seub2hu2.community.vo.Notice;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.util.ListDto;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/community/notice")
public class NoticeController {

    @Value("C:/files/notice")
    private String saveDirectory;

    @Autowired
    public NoticeService noticeService;


    @GetMapping("/main")
    public String list(@RequestParam(name = "page", required = false, defaultValue = "1") int page
            , @RequestParam(name = "rows", required = false, defaultValue = "10") int rows
            , @RequestParam(name = "sort", required = false, defaultValue = "import") String sort
            , @RequestParam(name = "opt", required = false) String opt
            , @RequestParam(name = "keyword", required = false) String keyword
            , Model model) {

        Map<String, Object> condition = new HashMap<>();
        condition.put("page", page);
        condition.put("rows", rows);
        condition.put("sort", sort);

        if (StringUtils.hasText(keyword)) {
            condition.put("opt", opt);
            condition.put("keyword", keyword);
        }

        ListDto<Notice> dto = noticeService.getNotices(condition);

        model.addAttribute("notices", dto.getData());
        model.addAttribute("paging", dto.getPaging());

        return "community/notice/main";
    }

    @GetMapping("/form")
    public String form() {
        return "community/notice/form";
    }

    @PostMapping("/register")
    @ResponseBody
    public Notice register(NoticeForm form) {
        Notice notice = noticeService.addNewNotice(form);
        return notice;
    }

    @GetMapping("/hit")
    public String hit(@RequestParam("no") int noticeNo) {
        noticeService.updateNoticeViewCnt(noticeNo);
        return "redirect:detail?no=" + noticeNo;
    }

    @GetMapping("/detail")
    public String detail(@RequestParam("no") int noticeNo
            , Model model) {

        Notice notice = noticeService.getNoticeDetail(noticeNo);
        model.addAttribute("notice", notice);

        return "community/notice/detail";
    }

//    @GetMapping("/filedown")
//    public ModelAndView download(@RequestParam("no") int noticeNo) {
//
//        Notice notice = noticeService.getNoticeDetail(noticeNo);
//
//        ModelAndView mav = new ModelAndView();
//
//        mav.setView(fileDownloadView);
//        mav.addObject("directory", saveDirectory);
//        mav.addObject("filename", notice.getUploadFile().getSaveName());
//        mav.addObject("originalFilename", notice.getOriginalFileName());
//
//        return mav;
//    }

    @GetMapping("/download")
    public ResponseEntity<Resource> downloadFile(int noticeNo) throws Exception {

        Notice notice = noticeService.getNoticeDetail(noticeNo);

        String fileName = notice.getUploadFile().getSaveName();
        String originalFileName = notice.getOriginalFileName();
        originalFileName = URLEncoder.encode(originalFileName, "UTF-8");

        File file = new File(new File(saveDirectory), fileName);
        FileSystemResource resource = new FileSystemResource(file);

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + originalFileName)
                .body(resource);
    }

    @GetMapping("/modify")
    public String modifyForm(@RequestParam("no") int noticeNo, Model model) {
        Notice notice = noticeService.getNoticeDetail(noticeNo);
        model.addAttribute("notice", notice);
        return "community/notice/modify";
    }

    @PostMapping("/modify")
    @ResponseBody
    public Notice update(NoticeForm form) {
        Notice notice = noticeService.updateNotice(form);
        return notice;
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("no") int noticeNo) {
        noticeService.deleteNotice(noticeNo);
        return "redirect:main";
    }

    @GetMapping("/delete-file")
    public String deleteUploadFile(@RequestParam("no") int noticeNo
            , @RequestParam("fileNo") int fileNo){
        noticeService.deleteNoticeFile(noticeNo, fileNo);

        return "redirect:modify?no=" + noticeNo;
    }
}

