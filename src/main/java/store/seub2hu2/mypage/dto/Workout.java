package store.seub2hu2.mypage.dto;

import lombok.*;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@ToString
@Getter
@Setter
public class Workout {
    private int workNo;
    private String workTitle;
    private String workContent;
    private Date workDate;
    private int userNo;
}
