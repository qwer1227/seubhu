package store.seub2hu2.community.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import store.seub2hu2.community.dto.CrewForm;
import store.seub2hu2.community.service.CrewService;
import store.seub2hu2.community.vo.Crew;
import store.seub2hu2.security.user.LoginUser;

@Controller
@RequestMapping("/community/crew")
public class CrewController {

    @Autowired
    private CrewService crewService;

    @GetMapping("/main")
    public String list() {
        return "community/crew/main";
    }

    @GetMapping("/form")
    public String form() {
        return "community/crew/form";
    }

    @GetMapping("/detail")
    public String detail() {
        return "community/crew/detail";
    }

    @PostMapping("/register")
    public String register(CrewForm form, @AuthenticationPrincipal LoginUser loginUser) {
        Crew crew = crewService.addNewCrew(form, loginUser);
        return "redirect:main";
    }
}
