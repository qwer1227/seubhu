package store.seub2hu2.product.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.product.dto.ProdListDto;
import store.seub2hu2.product.vo.Product;

import java.util.List;
import java.util.Map;

@Mapper
public interface ProductMapper {

    // 옵션에 따른 데이터 전체 개수를 조회하기
    int getTotalRows(@Param("condition")Map<String, Object> condition);

    // 상품 전체 목록 조회하기
    List<ProdListDto> getProducts(@Param("condition") Map<String, Object> condition);

    // 카테고리별 상품 목록 조회하기
    List<Product> getProductByCatNo(int catNo);
}
