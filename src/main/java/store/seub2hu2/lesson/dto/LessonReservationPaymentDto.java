package store.seub2hu2.lesson.dto;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class LessonReservationPaymentDto {
    private int price;
    private String type;
    private int productNo;
    private String title;
    private int lessonNo;
    private int userNo;
    private String payNo;
    private int quantity;
}
