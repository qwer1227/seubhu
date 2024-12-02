package store.seub2hu2.lesson.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.lesson.dto.LessonUpdateDto;
import store.seub2hu2.lesson.vo.Lesson;


import java.util.List;
import java.util.Map;

@Mapper
public interface LessonMapper {

    // 전체 레슨 조회하기
    public List<Lesson> getAllLessons(@Param("param") Map<String, Object> param, @Param("subject") String subject);

    // 레슨 번호로 조회
    public Lesson getLessonByNo(@Param("no") int no);

    // 레슨 추가
    public void insertLesson(@Param("lesson") Lesson lesson);

    // 레슨 삭제
    public void deleteLessonByNo(@Param("lesson") Lesson lesson);

    // 레슨 수정
    public void updateLesson(@Param("dto") LessonUpdateDto dto);

    // 레슨 수강생 수 수정
    public void updateLessonParticipant(@Param("dto") LessonUpdateDto dto);

}
