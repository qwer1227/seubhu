package store.seub2hu2.mypage.dto;

import lombok.*;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@ToString
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class OrderResultDto {
    // 결제 관련
    private int payNo; // 결제 번호
    private String payId; // 결제 아이디(tid)
    private String userId; // 유저 아이디
    private Date payDate; // 결제일
    private Date payCancelDate; // 결제 취소일
    private String payMethod; // 결제 방법
    private int payPrice;
    private int payAmount; // 결제건수
    private String payType; // 결제 타입
    private String refund; // 취소 유무

   // 주문 관련
    private int orderNo; // 주문 번호
    private String orderId; // 주문 아이디
    private Date orderDate; // 주문 날짜
    private String orderStatus; //주문 상태
    private int orderPrice; // 상품 가격들
    private double delPayment; // 배송비
    private int disPrice; // 할인 가격
    private int realPrice; // 총 가격

   // 배송 관련
    private int delNo; // 배송 번호
    private String delCom; // 배송업체
    private String delStatus; // 배송 상태
    private String delMemo; // 배송 메모
    private String delPhoneNumber; // 받는 사람 전화번호


    // 배송주소 관련
    private int addrNo; // 배송주소 번호
    private int userNo; // 유저 번호
    private String addrName; // 받는 사람 이름
    private String postcode; // 우편 번호
    private String addr; // 주소1
    private String addrDetail; // 주소 상세
    private String isHome; // 자기 집 유무

    // 주문상품
    private List<OrderResultItemDto> items; // 주문 상품들

    public String getOrderDescription() {
        OrderResultItemDto orderResultItemDto = items.get(0);

        if (items.size() > 1) {
            return orderResultItemDto.getProdName() + " 외 " + (items.size() - 1) + "개";
        } else {
            return orderResultItemDto.getProdName();
        }
    }

    public int getTotalItemAmount() {
        int total = 0;

        for (OrderResultItemDto orderResultItemDto : items) {
            total += orderResultItemDto.getOrderProdAmount();
        }

        return total;
    }

    // 주문 아이디 생성
    public String generateOrderId() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String datePart = sdf.format(payDate);
        int sequence = 0;
        sequence += sequence;

        return "ORD-" +datePart + "-" + String.format("%03d", sequence);
    }

}
