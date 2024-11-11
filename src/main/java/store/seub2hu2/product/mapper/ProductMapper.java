package store.seub2hu2.product.mapper;

import org.apache.ibatis.annotations.Mapper;
import store.seub2hu2.product.dto.ProdListDto;
import store.seub2hu2.product.vo.Product;

import java.util.List;

@Mapper
public interface ProductMapper {

    // 상품 전체 목록 조회하기
    List<ProdListDto> getProducts();

    // 카테고리별 상품 목록 조회하기
    List<Product> getProductByCatNo(int catNo);
}
