package store.seub2hu2.community.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import store.seub2hu2.community.dto.NoticeForm;
import store.seub2hu2.community.service.NoticeService;
import store.seub2hu2.community.vo.Notice;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.util.ListDto;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/community/notice")
public class NoticeController {

    @Autowired
    public NoticeService noticeService;

    @GetMapping("/main")
    public String list(@RequestParam(name = "page", required = false, defaultValue = "1") int page
            , @RequestParam(name = "rows", required = false, defaultValue = "10") int rows
            , @RequestParam(name = "opt", required = false) String opt
            , @RequestParam(name = "keyword", required = false) String keyword
            , Model model) {

        Map<String, Object> condition = new HashMap<String, Object>();
        condition.put("page", page);
        condition.put("rows", rows);

        if(StringUtils.hasText(keyword)) {
            condition.put("opt", opt);
            condition.put("keyword", keyword);
        }

        ListDto<Notice> dto = noticeService.getNotices(condition);

        model.addAttribute("notices", dto.getData());
        model.addAttribute("paging", page);

        return "community/notice/main";
    }

    @GetMapping("/form")
    public String form() {
        return "community/notice/form";
    }

    @PostMapping("/register")
    public String register(NoticeForm form
                        , @AuthenticationPrincipal LoginUser loginUser) {

        noticeService.addNewNotice(form, loginUser);
        return "community/notice/main";
    }

    @GetMapping("/detail")
    public String detail() {
        return "community/notice/detail";
    }

}
