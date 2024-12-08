package store.seub2hu2.community.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import store.seub2hu2.community.dto.MarathonForm;
import store.seub2hu2.community.service.MarathonService;
import store.seub2hu2.community.vo.Crew;
import store.seub2hu2.community.vo.Marathon;
import store.seub2hu2.util.ListDto;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/community/marathon")
public class MarathonController {

    @Autowired
    public MarathonService marathonService;

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

        ListDto<Marathon> dto = marathonService.getMarathons(condition);

        model.addAttribute("marathons", dto.getData());
        model.addAttribute("paging", dto.getPaging());

        return "community/marathon/main";
    }

    @GetMapping("/detail")
    public String detail() {
        return "community/marathon/detail";
    }

    @GetMapping("/form")
    public String form() {
        return "community/marathon/form";
    }

    @PostMapping("/register")
    public String register(MarathonForm form) {
        Marathon marathon = marathonService.addNewMarathon(form);
        return "community/marathon/main";
    }
}
