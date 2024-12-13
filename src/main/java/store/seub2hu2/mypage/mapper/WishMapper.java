package store.seub2hu2.mypage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.wish.dto.WishItemDto;

import java.util.List;

@Mapper
public interface WishMapper {
    
    // 특정 사용자의 위시리스트 가져오기
    List<WishItemDto> getWishListByUserNo(@Param("userNo") int userNo);

}
