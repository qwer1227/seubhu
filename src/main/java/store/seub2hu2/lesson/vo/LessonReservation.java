package store.seub2hu2.lesson.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.apache.ibatis.type.Alias;
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
    private Date reservationCreatedDate;
    private Date reservationUpdatedDate;

}
