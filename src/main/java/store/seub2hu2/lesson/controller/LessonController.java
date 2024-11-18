package store.seub2hu2.lesson.controller;

import lombok.RequiredArgsConstructor;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.lesson.dto.LessonRegisterForm;
import store.seub2hu2.lesson.dto.ReservationSearchCondition;
import store.seub2hu2.lesson.service.LessonFileService;
import store.seub2hu2.lesson.service.LessonService;
import store.seub2hu2.lesson.vo.*;
import store.seub2hu2.user.vo.User;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/lesson")
@Slf4j
public class LessonController {

    @Value("${file.upload-dir}")
    private String saveDirectory;

    private final LessonService lessonService;
    private final LessonFileService lessonFileService;

    @GetMapping(value = {"/", "lessons", ""})
    public String lessonList() {
        return "lesson/lesson";
    }


    @GetMapping("/detail")
    public String lessonDetail(@RequestParam("lessonNo") Integer lessonNo, Model model) {
        try {
            // Lesson 정보 가져오기
            Lesson lesson = lessonService.getLessonByNo(lessonNo);

            // 이미지 파일 정보 가져오기
            Map<String, String> images = lessonService.getImagesByLessonNo(lessonNo);

            // 모델에 lesson과 images 정보 추가
            model.addAttribute("lesson", lesson);
            model.addAttribute("lessonNo", lessonNo);
            model.addAttribute("images", images);

            return "lesson/lesson-detail";
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Invalid lessonNo: " + lessonNo);
        }
    }


    @GetMapping("/payment")
    public String payment() {

        return "lesson/payment";
    }

    // 레슨 작성 폼
    @GetMapping("/form")
    public String form() {
        return "lesson/lesson-form";
    }

    // 레슨 번호를 lessonFile 객체에 어떻게 전달?
    @PostMapping("/form")
    public String form(@ModelAttribute("form") LessonRegisterForm form, Model model) throws IOException {
        // Lesson 객체 생성
        int lessonNo = lessonService.getMostLatelyLessonNo();

        Lesson lesson = new Lesson();
        lesson.setLessonNo(lessonNo);
        lesson.setTitle(form.getTitle());
        lesson.setPrice(form.getPrice());
        User user = new User();
        user.setNo(5); // Or dynamically assign user ID
        user.setUsername(form.getLecturerName());
        lesson.setLecturer(user);
        lesson.setCategory(form.getCategory());
        lesson.setPlan(form.getPlan());
        lesson.setStart(form.getDate());
        lesson.setEnd(form.getDate());

        // Get the uploaded file
        MultipartFile thumbnail = form.getThumbnail();
        MultipartFile mainImage = form.getMainImage();

        lessonService.registerLesson(lesson, form);

        // Redirect after successful form submission
        return "redirect:lessons";
    }

    // 레슨 수정 폼
    @GetMapping("/editForm")
    public String editForm(@RequestParam("lessonNo") int lessonNo, Model model) {
        Lesson lesson = lessonService.getLessonByNo(lessonNo);
        Map<String, String> lessonFileMap = lessonService.getImagesByLessonNo(lessonNo);
        model.addAttribute("lesson", lesson);
        model.addAttribute("lessonFileMap", lessonFileMap);
        return "lesson/lesson-edit-form";
    }


    @GetMapping("/list")
    @ResponseBody
    public List<Lesson> lesson(@RequestParam("start") String start, @RequestParam("end") String end) {
        Map<String, Object> param = new HashMap<>();
        param.put("start", start);
        param.put("end", end);
        List<Lesson> lessons = lessonService.getAllLessons(param);

        return lessons;
    }

    @GetMapping("/reservation")
    public String reservation(@RequestParam("userNo") int userNo,
                              @ModelAttribute("condition") ReservationSearchCondition condition,
                              Model model) {

        log.info("Start Date: {}", condition.getStartDate());
        log.info("End Date: {}", condition.getEndDate());

        List<LessonReservation> lessons = lessonService.searchLessonReservationList(condition, userNo);
        model.addAttribute("lessons", lessons);
        return "lesson/lesson-reservation";
    }
}
