package store.seub2hu2.mypage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.cart.dto.CartItemDto;
import store.seub2hu2.cart.dto.CartRegisterForm;
import store.seub2hu2.mypage.mapper.CartMapper;


import java.util.List;

@Service
@Transactional
public class CartService {

    @Autowired
    CartMapper cartMapper;

    public List<CartItemDto> getCartItemsByUserNo(int userNo){

        List<CartItemDto> cartItems = cartMapper.getCartItemsByUserNo(userNo);

        return cartItems;
    }

    /**
     * 카트 정보를 입력하는 기능
     * @param cartRegisterForm 카트 DB에 넣을 정보
     */
    public void addCart(List<CartRegisterForm> cartRegisterForm) {

        cartMapper.addCart(cartRegisterForm);
    }
}
