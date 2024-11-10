package store.seub2hu2.lesson.service;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;
import store.seub2hu2.lesson.mapper.LessonMapper;
import store.seub2hu2.lesson.vo.Lesson;
import store.seub2hu2.lesson.vo.LessonReservation;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class LessonService {

    private final LessonMapper lessonMapper;

    public List<Lesson> getAllLessons(Map<String, Object> param) {
        return lessonMapper.getAllLessons(param) ;
    }

    public Lesson getLessonByNo(int lessonNo) {
        return lessonMapper.getLessonByNo(lessonNo);
    }

    public List<LessonReservation> getLessonsByUserNo(int userNo) {
        return lessonMapper.getLessonsByUserNo(userNo);
    }

    public void addNewLesson(Lesson lesson) {
        lessonMapper.insertLesson(lesson);
    }

}
