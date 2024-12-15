package store.seub2hu2.product.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.product.dto.ProdReviewDto;

import java.util.List;

@Mapper
public interface ProdReviewMapper {

    List<ProdReviewDto> prodReviewDto(@Param("userNo") int userNo);
}
