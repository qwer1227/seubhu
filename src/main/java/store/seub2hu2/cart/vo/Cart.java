package store.seub2hu2.cart.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Service;
import store.seub2hu2.product.vo.Product;
import store.seub2hu2.product.vo.Size;
import store.seub2hu2.user.vo.User;

@NoArgsConstructor
@AllArgsConstructor
@ToString
@Service
@Getter
public class Cart {

    private int no;
    private int amount;
    private Size size;
    private Product product;
    private User user;
}
