package store.seub2hu2.payment.dto;

import lombok.*;
import store.seub2hu2.payment.vo.Payment;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class PaymentDto {
    private String payId;       // tid
    private int userNo;         // 유저 번호
    private int totalAmount;    // 총 상품가격
    private int quantity;       // 수량
    private String method;      // 결제 방식
    // 상품
    private String productName; // 상품명
    private int productNo;      // 상품번호
    // 레슨
    private String title;       // 레슨명
    private int lessonNo;       // 레슨번호
    private String type;       // 레슨 or 상품


    public PaymentDto(Payment payment) {
        this.payId = payment.getId();
        this.totalAmount = payment.getAmount();
        this.type = payment.getType();
        this.userNo = payment.getUserNo();
    }

}
