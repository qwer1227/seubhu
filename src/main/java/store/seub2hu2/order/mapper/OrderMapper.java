package store.seub2hu2.order.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.cart.dto.CartItemDto;
import store.seub2hu2.mypage.dto.OrderResponse;
import store.seub2hu2.mypage.dto.ResponseDTO;
import store.seub2hu2.order.vo.Order;
import store.seub2hu2.order.vo.OrderItem;

import java.util.List;

@Mapper
public interface OrderMapper {

    // 주문 정보 저장
    void insertOrders(@Param("order") Order order);

    // 주문 상품 저장
    void insertOrderItems(@Param("orderItems") List<OrderItem> orderItems);

    // 장바구니에서 넘어간 상품들 조회
    List<CartItemDto> getOrderItemBySizeNo(@Param("sizeNoList") List<Integer> sizeNoList);

    List<OrderResponse> getOrders(@Param("userNo") int userNo);

    ResponseDTO getOrderDetails(@Param("orderNo") int orderNo);
}
