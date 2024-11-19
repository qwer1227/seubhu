package store.seub2hu2.wish.vo;

import lombok.*;
import store.seub2hu2.product.vo.Product;
import store.seub2hu2.user.vo.User;

@NoArgsConstructor
@AllArgsConstructor
@ToString
@Setter
@Getter
public class WishList {

    private int no;
    private Product product;
    private User user;
}
