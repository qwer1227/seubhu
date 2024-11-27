package store.seub2hu2.lesson.vo;

import lombok.*;
import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;
import store.seub2hu2.payment.vo.Payment;
import store.seub2hu2.user.vo.User;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class LessonReservation {
    private int no;
    private User user;
    private Payment payment;
    private Lesson lesson;
    private String status;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date reservationCreatedDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date reservationUpdatedDate;



}
