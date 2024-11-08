package store.seub2hu2.lesson.service;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;
import store.seub2hu2.lesson.mapper.LessonMapper;
import store.seub2hu2.lesson.vo.Lesson;

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

}
