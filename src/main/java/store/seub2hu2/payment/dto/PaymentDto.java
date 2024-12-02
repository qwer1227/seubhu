package store.seub2hu2.payment.dto;

import lombok.*;
import store.seub2hu2.payment.vo.Payment;

import java.util.List;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class PaymentDto {
    private String paymentId;       // tid
    private String userId;         // 유저 ID
    private int totalAmount;    // 총 상품가격
    private int quantity;       // 수량
    private String method;      // 결제 방식
    // 상품
    private List<Integer> sizeNo; // 상품 번호(사이즈 번호)
    private List<Integer> stock;  // 수량
    // 레슨
    private String title;       // 레슨명
    private int lessonNo;       // 레슨번호
    private String type;       // 레슨 or 상품


    public PaymentDto(Payment payment) {
        this.paymentId = payment.getId();
        this.totalAmount = payment.getAmount();
        this.type = payment.getType();
        this.userId = payment.getUserId();
    }

}
