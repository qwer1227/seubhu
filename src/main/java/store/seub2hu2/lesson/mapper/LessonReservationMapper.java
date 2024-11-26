package store.seub2hu2.lesson.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.lesson.dto.LessonReservationPaymentDto;
import store.seub2hu2.lesson.vo.Lesson;

@Mapper
public interface LessonReservationMapper {

    public void insertLessonReservation(@Param("lessonReservationPaymentDto") LessonReservationPaymentDto lessonReservationPaymentDto);

    public Lesson getLessonReservationByPayNo (@Param("payNo") String payNo);
}
