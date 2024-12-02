package store.seub2hu2.lesson.service;

import lombok.RequiredArgsConstructor;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import store.seub2hu2.lesson.dto.LessonRegisterForm;
import store.seub2hu2.lesson.dto.ReservationSearchCondition;
import store.seub2hu2.lesson.mapper.LessonFileMapper;
import store.seub2hu2.lesson.mapper.LessonMapper;
import store.seub2hu2.lesson.mapper.LessonReservationMapper;
import store.seub2hu2.lesson.vo.*;
import store.seub2hu2.user.mapper.UserMapper;
import store.seub2hu2.user.service.UserService;
import store.seub2hu2.user.vo.User;

import java.text.SimpleDateFormat;
import java.util.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class LessonService {

    private final LessonMapper lessonMapper;
    private final LessonFileMapper lessonFileMapper;
    private final LessonFileService lessonFileService;
    private final LessonReservationMapper lessonReservationMapper;
    private final UserMapper userMapper;
    private final UserService userService;

    public List<Lesson> getAllLessons(Map<String, Object> param, String subject) {
        return lessonMapper.getAllLessons(param, subject);
    }

    public Lesson getLessonByNo(int lessonNo) {
        return lessonMapper.getLessonByNo(lessonNo);
    }

    public List<LessonReservation> getLessonsByUserId(String userId) {
        return lessonReservationMapper.getLessonReservationByUserId(userId);
    }

    public void addNewLesson(Lesson lesson) {
        lessonMapper.insertLesson(lesson);
    }

    public void registerLesson(LessonRegisterForm form) {
        // Convert LessonRegisterForm to Lesson
        Lesson lesson = new Lesson();
        lesson.setTitle(form.getTitle());
        lesson.setPrice(form.getPrice());
        User user = userMapper.getUserById(form.getLecturerId());
        lesson.setLecturer(user);
        lesson.setPlace(form.getPlace());
        lesson.setSubject(form.getSubject());
        lesson.setPlan(form.getPlan());
        lesson.setStart(form.getStart());
        lesson.setEnd(form.getEnd());

        lessonMapper.insertLesson(lesson); // Save lesson details and generate lessonNo

        // Save thumbnail and main images
        lessonFileService.saveLessonImages(getMostLatelyLessonNo(), form.getThumbnail(), form.getMainImage());

    }

    public int getMostLatelyLessonNo() {
        return lessonFileMapper.lastInsertedLessonNo();
    }

    public void updateLesson(Lesson lesson) {
        lessonMapper.updateLesson(lesson);
    }


}
