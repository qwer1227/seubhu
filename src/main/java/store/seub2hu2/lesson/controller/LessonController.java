package store.seub2hu2.lesson.controller;

import lombok.RequiredArgsConstructor;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.lesson.dto.LessonDto;
import store.seub2hu2.lesson.dto.LessonRegisterForm;
import store.seub2hu2.lesson.dto.ReservationSearchCondition;
import store.seub2hu2.lesson.service.LessonFileService;
import store.seub2hu2.lesson.service.LessonService;
import store.seub2hu2.lesson.vo.*;
import store.seub2hu2.user.vo.User;

import java.io.IOException;
import java.text.SimpleDateFormat;
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

            log.info("lesson start = {}", lesson);
            return "lesson/lesson-detail";
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Invalid lessonNo: " + lessonNo);
        }
    }

    // 레슨 작성 폼
    @GetMapping("/form")
    public String form() {
        return "lesson/lesson-register-form";
    }

    @PostMapping("/form")
    public String registerForm(@ModelAttribute("form") LessonRegisterForm form, Model model) throws IOException {
        // Lesson 객체 생성
        int lessonNo = lessonService.getMostLatelyLessonNo();

        Lesson lesson = new Lesson();
        lesson.setLessonNo(lessonNo);
        lesson.setTitle(form.getTitle());
        lesson.setPrice(form.getPrice());
        User user = new User();
        user.setNo(5); // Or dynamically assign user ID
        user.setId(form.getLecturerName());
        lesson.setLecturer(user);
        lesson.setSubject(form.getSubject());
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
    public List<Lesson> lesson(@RequestParam("start") String start,
                               @RequestParam("end") String end,
                               @RequestParam(value = "subject", required = false, defaultValue = "전체") String subject) {
        Map<String, Object> param = new HashMap<>();
        param.put("start", start);
        param.put("end", end);
        log.info("subject = {}", subject);
        log.info("Start: {}, End: {}, Subject: {}", start, end, subject);
        List<Lesson> lessons = lessonService.getAllLessons(param, subject);

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


    // 결제용 임시 컨트롤러
    @GetMapping("/payment")
    public String pay(@ModelAttribute LessonDto lessonDto, Model model) {
        log.info("lessonDto = {}", lessonDto);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        model.addAttribute("lessonDto", lessonDto);
        return "lesson/lesson-payment";
    }
}
