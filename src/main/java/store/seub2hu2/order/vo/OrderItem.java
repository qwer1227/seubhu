package store.seub2hu2.order.vo;

import lombok.*;
import store.seub2hu2.product.vo.Product;
import store.seub2hu2.product.vo.Size;

@ToString
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class OrderItem {

    private int no; // 주문 상품 번호
    private int quantity; // 담은 주문 수량
    private int price; // 개별 상품 가격
    private int eachTotalPrice; // 건당 상품 가격(담은 주문 수량 * 개별 상품 가격)
    private Product product; // 상품 번호
    private Size size; // 사이즈 번호(이게 필요할듯)
    private Order order; // 주문 번호
}
