package store.seub2hu2.lesson.vo;

import lombok.*;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Payment {
    private String no;
    private int userNo;
    private String payMethod;
    private int price;
    private int amount;
    private String payType;
    private String payStatus;
    private Date payCreatedDate;
    private Date payUpdatedDate;
}
