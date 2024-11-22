package store.seub2hu2.lesson.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.lesson.dto.LessonReservationPay;

@Mapper
public interface LessonReservationMapper {

    public void insertLessonReservation(@Param("lessonReservationPay")LessonReservationPay lessonReservationPay);

}
