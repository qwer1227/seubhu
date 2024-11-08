package store.seub2hu2.community.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/community/marathon")
public class MarathonController {

    @GetMapping("/main")
    public String Community() {
        return "community/marathon/main";
    }

    @GetMapping("/form")
    public String list() {
        return "community/marathon/form";
    }

    @GetMapping("/detail")
    public String detail() {
        return "community/marathon/detail";
    }

}
