package store.seub2hu2.lesson.controller;

import lombok.RequiredArgsConstructor;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
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
            String startDate = lesson.getStartDate();
            String startTime = lesson.getStartTime();

            // 이미지 파일 정보 가져오기
            Map<String, String> images = lessonService.getImagesByLessonNo(lessonNo);

            // 모델에 lesson과 images 정보 추가
            model.addAttribute("lesson", lesson);
            model.addAttribute("startDate", startDate);
            model.addAttribute("startTime", startTime);
            model.addAttribute("lessonNo", lessonNo);
            model.addAttribute("images", images);

            log.info("lesson start = {}", lesson);
            return "lesson/lesson-detail";
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Invalid lessonNo: " + lessonNo);
        }
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
        log.info("searchCondition: {}", condition.getSearchCondition());
        List<LessonReservation> lessonReservations = lessonService.searchLessonReservationList(condition, userNo);
        model.addAttribute("lessonReservations", lessonReservations);
        return "lesson/lesson-reservation";
    }


    // 결제용 임시 컨트롤러

}
