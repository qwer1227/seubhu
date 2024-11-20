package store.seub2hu2.product.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.product.dto.ProdDetailDto;
import store.seub2hu2.product.dto.ProdListDto;
import store.seub2hu2.product.mapper.ProductMapper;
import store.seub2hu2.util.ListDto;
import store.seub2hu2.util.Pagination;

import java.util.List;
import java.util.Map;

@Slf4j
@Service
@Transactional
public class ProductService {

    @Autowired
    ProductMapper productMapper;


    public ProdDetailDto getProductByNo(int no) {
        ProdDetailDto prodDetailDto = productMapper.getProductByNo(no);

        return prodDetailDto;
    }

    /**
     * 모든 상품정보 목록을 제공하는 서비스 메서드입니다.
     * @param condition 조회조건이 포함된 MAP 객체입니다.
     * @return 모든 상품 목록
     */
    public ListDto<ProdListDto> getProducts(Map<String, Object> condition) {

        // 검색 조건에 맞는 전체 데이터 갯수를 조회하는 기능
        int totalRows = productMapper.getTotalRows(condition);

        // Pagination 객체를 생성한다.
        int page = (Integer) condition.get("page");
        int rows = (Integer) condition.get("rows");

        Pagination pagination = new Pagination(page, totalRows, rows);

        // 데이터 검색 범위를 조회해서 Map에 저장한다.
        condition.put("begin", pagination.getBegin());
        condition.put("end", pagination.getEnd());

        // ProdListDto 타입의 데이터를 담는 ListDto 객체를 생성한다.
        // 상품 목록 ListDto(ProdListDto), 페이정처리 정보(Pagination)을 담는다.
        List<ProdListDto> products = productMapper.getProducts(condition);
        System.out.println(products.toString());
        ListDto<ProdListDto> dto = new ListDto<>(products, pagination);

        return dto;
    }

}
