package store.seub2hu2.product.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
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


    /**
     * 모든 상품의 목록을 제공하는 서비스 메서드다.
     * @param condition 조회조건이 포함된 Map 객체다.
     * @return 모든 상품 목록
     */
    public ListDto<ProdListDto> getProducts(Map<String, Object> condition) {

        // 검색 조건에 맞는 전체 데이터 갯수를 조회한다.
        int totalRows = productMapper.getTotalRows(condition);

        // 현재 페이지
        int page = (Integer) condition.get("page");
        // 데이터 개수
        int rows = (Integer) condition.get("rows");

        // Pagination 객체를 생성한다.
        Pagination pagination = new Pagination(page, totalRows , rows);

        // 데이터 검색 범위를 조회해서 Map에 저장한다.
        // 페이지의 시작 과 페이지의 끝을 담는다.
        int begin = pagination.getBegin();
        int end = pagination.getEnd();

        // map 객체에 저장한다.
        condition.put("begin", begin);
        condition.put("end", end);
        List<ProdListDto> products = productMapper.getProducts(condition);

        ListDto<ProdListDto> dto = new ListDto<>(products, pagination);

        return dto;
    }
}
