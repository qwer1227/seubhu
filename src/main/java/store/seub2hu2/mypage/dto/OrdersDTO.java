package store.seub2hu2.mypage.dto;

import lombok.*;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@ToString
@Getter
@Setter
public class OrdersDTO {
    private int orderNo;
    private Date orderDate;
    private String orderStatus;
    private double orderPrice;
}
