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
import store.seub2hu2.community.dto.CrewForm;
import store.seub2hu2.community.service.CrewService;
import store.seub2hu2.community.vo.Board;
import store.seub2hu2.community.vo.Crew;
import store.seub2hu2.community.vo.Notice;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.util.ListDto;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/community/crew")
public class CrewController {

    @Autowired
    public CrewService crewService;

    @GetMapping("/main")
    public String list(@RequestParam(name = "page", required = false, defaultValue = "1") int page
            , @RequestParam(name = "rows", required = false, defaultValue = "15") int rows
            , @RequestParam(name = "category", required = false) String category
            , Model model) {

        Map<String, Object> condition = new HashMap<>();
        condition.put("page", page);
        condition.put("rows", rows);

        // 카테고리 필터링 처리
        if (StringUtils.hasText(category)) {
            condition.put("category", category);
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

    @GetMapping("/detail")
    public String detail() {
        return "community/crew/detail";
    }

    @PostMapping("/register")
    public String register(CrewForm form
            , @AuthenticationPrincipal LoginUser loginUser) {

        crewService.addNewCrew(form, loginUser);
        return "redirect:main";
    }
}
