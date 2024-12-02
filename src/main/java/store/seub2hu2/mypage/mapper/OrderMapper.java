package store.seub2hu2.mypage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.mypage.dto.OrderResponse;
import store.seub2hu2.mypage.dto.ResponseDTO;

import java.util.List;

@Mapper
public interface OrderMapper {
    List<OrderResponse> getOrders(@Param("userNo") int userNo);
    ResponseDTO getOrderDetails(@Param("orderNo") int orderNo);
}
