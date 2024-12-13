package store.seub2hu2.wish.dto;

import lombok.*;
import store.seub2hu2.product.vo.Color;
import store.seub2hu2.product.vo.Product;
import store.seub2hu2.product.vo.Size;
import store.seub2hu2.user.vo.User;

@ToString
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class WishItemDto {
    
    private int no; // 위시리스트 고유 번호
    private Color color;
    private Size size;
    private Product product; // 상품 객체
    private User user; // 유저 객체
}
