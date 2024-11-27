package store.seub2hu2.payment.dto;

import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class CancelResponse {
    private String aid; // 요청 고유 번호
    private String tid; // 결제 고유 번호
    private String cid; // 가맹점 코드
    private String status; // 결제 상태
    private String partner_order_id; // 가맹점 주문 번호
    private String partner_user_id; // 가맹점 회원 ID
    private String payment_method_type; // 결제 수단
    private Amount amount; // 결제 금액 정보, 결제 요청 구현할때 이미 구현해놓음
    private ApprovedCancelAmount approved_cancel_amount; // 이번 요청으로 취소된 금액
    private CanceledAmount canceled_amount; // 누계 취소 금액
    private CancelAvailableAmount cancel_available_amount; // 남은 취소 금액
    private String item_name; // 상품 이름
    private String item_code; // 상품 코드
    private int quantity; // 상품 수량
    private String created_at; // 결제 준비 요청 시각
    private String approved_at; // 결제 승인 시각
    private String canceled_at; // 결제 취소 시각
    private String payload; // 취소 요청 시 전달한 값
}
