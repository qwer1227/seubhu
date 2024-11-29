package store.seub2hu2.order.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.cart.dto.CartItemDto;

import java.util.List;

@Mapper
public interface OrderMapper {

    List<CartItemDto> getOrderItemBySizeNo(@Param("sizeNoList") List<Integer> sizeNoList);
}
