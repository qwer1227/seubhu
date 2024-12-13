package store.seub2hu2.mypage.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import store.seub2hu2.mypage.mapper.WishMapper;
import store.seub2hu2.wish.dto.WishItemDto;

import java.util.List;

@Service
@RequiredArgsConstructor
public class WishListService {

    private final WishMapper wishMapper;

    public List<WishItemDto> getWishListByUserNo(int userNo) {

        List<WishItemDto> wishList = wishMapper.getWishListByUserNo(userNo);

        return wishList;
    }

}
