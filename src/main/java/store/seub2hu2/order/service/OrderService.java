package store.seub2hu2.order.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.cart.dto.CartItemDto;
import store.seub2hu2.order.mapper.OrderMapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class OrderService {

    @Autowired
    OrderMapper orderMapper;

    public List<CartItemDto> getOrderItemBySizeNo(List<Integer> sizeNoList, List<Integer> stocks) {

        Map <Integer, Integer> map = new HashMap<>();
        for(int i = 0; i < sizeNoList.size(); i++){
            map.put(sizeNoList.get(i), stocks.get(i));
        }

        System.out.println("----------------------------------------------" + map);

        List<CartItemDto> orderDto = orderMapper.getOrderItemBySizeNo(sizeNoList);
        for(CartItemDto cartItemDto : orderDto){
            System.out.println("++++++++++++++++++++++++++++++" + cartItemDto.getSize().getNo());

            cartItemDto.setStock(map.get(cartItemDto.getSize().getNo()));
        }

        return orderDto;
    }
}
