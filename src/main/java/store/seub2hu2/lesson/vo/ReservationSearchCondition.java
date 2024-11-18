package store.seub2hu2.lesson.vo;

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class ReservationSearchCondition {

    private String searchKeyword;
    private String searchCondition;
    private String lessonStatus;
    private String lessonCategory;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date startDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date endDate;


}
