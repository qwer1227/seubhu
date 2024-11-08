package store.seub2hu2.community.board;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/community/notice")
public class NoticeController {

    @GetMapping("/main")
    public String Community() {
        return "community/notice/main";
    }

    @GetMapping("/form")
    public String list() {
        return "community/notice/form";
    }

    @GetMapping("/detail")
    public String detail() {
        return "community/notice/detail";
    }

}
