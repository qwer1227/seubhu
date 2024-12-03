package store.seub2hu2.delivery.vo;

import lombok.*;
import store.seub2hu2.order.vo.Order;
import store.seub2hu2.user.vo.Addr;

@ToString
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class Delivery {

    private int no; // 배송 번호
    private String name; // 배송 업체
    private String memo; // 배송 메모
    private Order order; // 주문 객체
    private Addr addr; // 주소 객체
}
