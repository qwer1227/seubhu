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
    public String detail(@RequestParam("no") int crewNo
                        , Model model) {
        Crew crew = crewService.getCrewDetail(crewNo);

        model.addAttribute("crew", crew);
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
}
