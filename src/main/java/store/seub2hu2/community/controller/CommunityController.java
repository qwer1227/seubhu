package store.seub2hu2.community.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/community")
public class CommunityController {

    @GetMapping("/main")
    public String Community() {
        return "community/main";
    }

    @GetMapping("/form")
    public String list() {
        return "community/form";
    }

    @GetMapping("/detail")
    public String detail() {
        return "community/detail";
    }

}
