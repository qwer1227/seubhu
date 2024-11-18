package store.seub2hu2.lesson.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;
import store.seub2hu2.user.vo.User;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class LessonReservation {
    private int no;
    private User user;
    private Lesson lesson;
    private String lessonReservationStatus;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date reservationCreatedDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date reservationUpdatedDate;

}
