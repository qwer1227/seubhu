package store.seub2hu2.lesson.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/board")
public class boardController {

    @GetMapping("/")
    public String board() {
        return "board/board";
    }

    @GetMapping("/form")
    public String boardForm() {
        return "board/board-form";
    }

    @GetMapping("/detail")
    public String detail() {
        return "board/detail";
    }

}
