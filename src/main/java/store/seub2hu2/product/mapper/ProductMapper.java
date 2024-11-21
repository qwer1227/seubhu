package store.seub2hu2.product.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.product.dto.*;
import store.seub2hu2.product.vo.Product;

import java.util.List;
import java.util.Map;

@Mapper
public interface ProductMapper {

    // 옵션에 따른 데이터 전체 개수를 조회하기
    int getTotalRows(@Param("condition")Map<String, Object> condition);

    // 상품 전체 목록 조회하기
    List<ProdListDto> getProducts(@Param("condition") Map<String, Object> condition);
    
    // 상품 번호에 따른 상품 상세 정보 조회하기
    ProdDetailDto getProductByNo(@Param("no") int no);

    // 상품번호에 따른 색상과 이미지 조회하기
    List<ColorProdImgDto> getProdImgByColorNo(@Param("no") int no);

    // 색상번호에 따른 사이즈와 재고수량 조회하기
    SizeAmountDto getSizeAmountByColorNo(@Param("colorNo") int colorNo);

    // 색상 번호에 따른 이미지들 조회하기
    ProdImagesDto getProdImagesByColorNo(@Param("colorNo") int colorNo);

    // 상품 등록(임시: 관리자가 하기)
    void insertProduct(Product product);
}
