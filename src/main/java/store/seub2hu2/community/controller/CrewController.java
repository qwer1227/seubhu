package store.seub2hu2.community.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/community/inviting")
public class CrewController {

    @GetMapping("/main")
    public String Community() {
        return "community/inviting/main";
    }

    @GetMapping("/form")
    public String list() {
        return "community/inviting/form";
    }

    @GetMapping("/detail")
    public String detail() {
        return "community/inviting/detail";
    }

}
