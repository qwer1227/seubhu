package store.seub2hu2.order.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.cart.dto.CartItemDto;
import store.seub2hu2.delivery.vo.Delivery;
import store.seub2hu2.mypage.dto.OrderResponse;
import store.seub2hu2.mypage.dto.OrdersDTO;
import store.seub2hu2.mypage.dto.ResponseDTO;
import store.seub2hu2.order.dto.OrderForm;
import store.seub2hu2.order.mapper.OrderMapper;
import store.seub2hu2.order.vo.Order;
import store.seub2hu2.order.vo.OrderItem;
import store.seub2hu2.user.vo.Addr;
import store.seub2hu2.user.vo.User;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class OrderService {

    @Autowired
    OrderMapper orderMapper;


    /**
     * 장바구니에서 선택한 주문 상품을 조회한다.
     * @param sizeNoList 상품 사이즈 번호(고유번호)
     * @param stocks 수량들
     * @return
     */
    public List<CartItemDto> getOrderItemBySizeNo(List<Integer> sizeNoList, List<Integer> stocks) {

        Map <Integer, Integer> map = new HashMap<>();
        for(int i = 0; i < sizeNoList.size(); i++){
            map.put(sizeNoList.get(i), stocks.get(i));
        }


        List<CartItemDto> orderDto = orderMapper.getOrderItemBySizeNo(sizeNoList);
        for(CartItemDto cartItemDto : orderDto){
            cartItemDto.setStock(map.get(cartItemDto.getSize().getNo()));
        }

        return orderDto;
    }

    public List<OrderResponse> getAllOrders(int userNo) {
        System.out.println(orderMapper.getOrders(userNo));
        return orderMapper.getOrders(userNo);
    }

    public ResponseDTO getOrderDetails(int orderNo){
        System.out.println("테스트"+orderMapper.getOrderDetails(orderNo));
        return orderMapper.getOrderDetails(orderNo);
    }

    public int updateOrderPayNo(int orderNo, int payNo){
        OrdersDTO ordersDTO = new OrdersDTO();
        ordersDTO.setOrderNo(orderNo);
        ordersDTO.setPayNo(payNo);

        return orderMapper.updateOrder(ordersDTO);
    }
}
