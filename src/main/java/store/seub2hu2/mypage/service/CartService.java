package store.seub2hu2.mypage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.cart.dto.CartRegisterForm;
import store.seub2hu2.cart.vo.Cart;
import store.seub2hu2.mypage.mapper.CartMapper;
import store.seub2hu2.security.user.LoginUser;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class CartService {

    @Autowired
    CartMapper cartMapper;

    public void addCart(List<CartRegisterForm> cartRegisterForm) {

        cartMapper.addCart(cartRegisterForm);
    }
}
