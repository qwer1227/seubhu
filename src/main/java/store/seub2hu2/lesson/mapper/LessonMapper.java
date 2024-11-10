package store.seub2hu2.lesson.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.lesson.vo.Lesson;
import store.seub2hu2.lesson.vo.LessonReservation;

import java.util.List;
import java.util.Map;

@Mapper
public interface LessonMapper {

    // 전체 레슨 조회하기
    public List<Lesson> getAllLessons(@Param("param") Map<String, Object> param);
    // 레슨 번호로 조회
    public Lesson getLessonByNo(@Param("no") int no);
    // 회원 번호로 회원이 예약한 레슨 조회
    public List<LessonReservation> getLessonsByUserNo (@Param("userNo") int userNo);
    // 레슨 추가
    public void insertLesson(@Param("lesson") Lesson lesson);
    // 레슨 삭제
    public void deleteLessonByNo(@Param("lesson") Lesson lesson);
    // 레슨 수정
    public void updateLessonByNo(@Param("lesson") Lesson lesson);



}
