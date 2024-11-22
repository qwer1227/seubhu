package store.seub2hu2.lesson.dto;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class LessonReservationPay {
    private String title;
    private int price;
    private String type;
    private int lessonNo;
    private int userNo;
    // tid
    private String payNo;
}
