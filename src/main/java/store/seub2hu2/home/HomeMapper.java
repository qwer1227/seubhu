package store.seub2hu2.home;

import org.apache.ibatis.annotations.Mapper;
import store.seub2hu2.community.vo.Board;
import store.seub2hu2.product.dto.ProdListDto;

import java.util.List;

@Mapper
public interface HomeMapper {

    // 주간 베스트 상품 - 별점 순으로 조회
   List<ProdListDto> getWeeklyBestProductsByRating();

    // 주간 베스트 상품 - 조회수 순으로 조회 (러닝화 기준)
   List<ProdListDto> getWeeklyBestProductsByViewCount();

    // 최신 글 5개 조회
    List<Board> getTopViewedBoards();
}
