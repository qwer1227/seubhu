package store.seub2hu2.product.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.product.dto.ProdReviewDto;
import store.seub2hu2.product.vo.ProdReview;
import store.seub2hu2.product.vo.ProdReviewImg;

import java.util.List;

@Mapper
public interface ProdReviewMapper {

    List<ProdReviewDto> prodReviewDto(@Param("prodNo") int prodNo);

    void insertProdReview(ProdReview prodReview);

    void insertProdReviewsImg(ProdReviewImg prodReviewImg);
}
