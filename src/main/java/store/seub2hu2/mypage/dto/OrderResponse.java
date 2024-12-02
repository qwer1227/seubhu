package store.seub2hu2.mypage.dto;

import lombok.*;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@ToString
@Getter
@Setter
public class OrderResponse {
    private int orderNo;
    private Date orderDate;
    private String productName;
    private String productImage;
    private double productPrice;
    private int quantity;
    private String orderStatus;
    private String deliveryStatus;
    private int deliveryNo;

}
