package store.seub2hu2.payment.dto;

import lombok.*;
import store.seub2hu2.delivery.vo.Delivery;
import store.seub2hu2.order.vo.Order;
import store.seub2hu2.order.vo.OrderItem;
import store.seub2hu2.payment.vo.Payment;
import store.seub2hu2.user.vo.Addr;

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
    // 상품 파트
    // 주문상품정보
    private List<OrderItem> orderItems;
    // 배송지 정보
    Addr addr;
    // 배송상태
    Delivery delivery;
    // 주문정보
    Order order;
    
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
