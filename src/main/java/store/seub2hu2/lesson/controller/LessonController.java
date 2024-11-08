package store.seub2hu2.lesson.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.lesson.dto.LessonDateDto;
import store.seub2hu2.lesson.service.LessonService;
import store.seub2hu2.lesson.vo.Lesson;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/lesson")
public class LessonController {

    private final LessonService lessonService;

    @GetMapping("")
    public String lessonList() {
        return "lesson/lesson";
    }

    @GetMapping("/detail")
    public String lessonDetail() {
        return "lesson/lesson-detail";
    }

    @GetMapping("/payment")
    public String payment() {

        return "lesson/payment";
    }

    @GetMapping("/form")
    public String form() {
        return "lesson/lesson-form";
    }


    @GetMapping("/list")
    @ResponseBody
    public List<Lesson> lesson(
                         @RequestParam("start") String start,
                         @RequestParam("end") String end) {
        Map<String, Object> param = new HashMap<>();
        param.put("start", start);
        param.put("end", end);

        return lessonService.getAllLessons(param);
    }
}
