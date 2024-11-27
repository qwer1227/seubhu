package store.seub2hu2.mypage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.cart.dto.CartRegisterForm;
import store.seub2hu2.cart.vo.Cart;

import java.util.List;

@Mapper
public interface CartMapper {

    // 장바구니 추가 기능
    void addCart(@Param("carts") List<CartRegisterForm> cartRegisterForm);
}
