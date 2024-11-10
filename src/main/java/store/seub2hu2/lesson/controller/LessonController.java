package store.seub2hu2.lesson.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.lesson.dto.LessonDateDto;
import store.seub2hu2.lesson.service.LessonService;
import store.seub2hu2.lesson.vo.Lesson;
import store.seub2hu2.lesson.vo.LessonRegisterForm;
import store.seub2hu2.lesson.vo.LessonReservation;

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

//    @GetMapping("/detail")
//    public String lessonDetail(@RequestParam("lessonNo") int lessonNo
//                                , Model model) {
//        Lesson lesson = lessonService.getLessonByNo(lessonNo);
//        model.addAttribute("lesson", lesson);
//
//        return "lesson/lesson-detail";
//    }

    @GetMapping("/detail")
    public String lessonDetail(@RequestParam("lessonNo") int lessonNo, Model model) {
        try {
//            int lessonNo = Integer.parseInt(lessonNoStr);
            Lesson lesson = lessonService.getLessonByNo(lessonNo);
            if (lesson == null) {
                throw new IllegalArgumentException("Invalid lessonNo: " + lessonNo);
            }
            model.addAttribute("lesson", lesson);
            return "lesson/lesson-detail";
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Invalid lessonNo: " + lessonNo);
        }
    }

    @GetMapping("/payment")
    public String payment() {

        return "lesson/payment";
    }

    @GetMapping("/form")
    public String form() {
        return "lesson/lesson-form";
    }

    @PostMapping("/form")
    public String form(@ModelAttribute("form") LessonRegisterForm form, Model model) {
        Lesson lesson = new Lesson();
        lesson.setTitle(form.getTitle());
        lesson.setPrice(form.getPrice());
        lesson.setLecturer(form.getLecturer());
        lesson.setPlan(form.getPlan());
        lesson.setStart(form.getStart());
        lesson.setEnd(form.getEnd());

        lessonService.addNewLesson(lesson);

        return "redirect:/lesson";
    }


    //    @GetMapping("/list")
//    @ResponseBody
//    public List<Lesson> lesson(
//            @RequestParam("start") String start,
//            @RequestParam("end") String end) {
//        Map<String, Object> param = new HashMap<>();
//        param.put("start", start);
//        param.put("end", end);
//
//        return lessonService.getAllLessons(param);
//    }
    @GetMapping("/list")
    @ResponseBody
    public List<Lesson> lesson(@RequestParam("start") String start, @RequestParam("end") String end) {
        Map<String, Object> param = new HashMap<>();
        param.put("start", start);
        param.put("end", end);
        List<Lesson> lessons = lessonService.getAllLessons(param);
        lessons.forEach(lesson -> {
            if (lesson.getLessonNo() == 0) {
                throw new IllegalArgumentException("Invalid lessonNo: " + lesson.getLessonNo());
            }
            System.out.println("LessonNo: " + lesson.getLessonNo());
        });
        return lessons;
    }

    @GetMapping("/reservation")
    public String reservation(@RequestParam("userNo") int userNo,
                              Model model) {
        List<LessonReservation> lessons = lessonService.getLessonsByUserNo(userNo);
        model.addAttribute("lessons", lessons);
        return "lesson/lesson-reservation";
    }


}
