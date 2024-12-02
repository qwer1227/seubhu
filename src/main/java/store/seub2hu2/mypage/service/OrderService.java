package store.seub2hu2.mypage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import store.seub2hu2.mypage.dto.OrderResponse;
import store.seub2hu2.mypage.dto.ResponseDTO;
import store.seub2hu2.mypage.mapper.OrderMapper;

import java.util.List;

@Service
public class OrderService {

    @Autowired
    OrderMapper orderMapper;

    public List<OrderResponse> getAllOrders(int userNo) {
        System.out.println(orderMapper.getOrders(userNo));
        return orderMapper.getOrders(userNo);
    }

    public ResponseDTO getOrderDetails(int orderNo){
        System.out.println("테스트"+orderMapper.getOrderDetails(orderNo));
        return orderMapper.getOrderDetails(orderNo);
    }

}
