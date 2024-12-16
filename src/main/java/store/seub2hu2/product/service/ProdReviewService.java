package store.seub2hu2.product.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.product.dto.ProdReviewDto;
import store.seub2hu2.product.mapper.ProdReviewMapper;

import java.util.ArrayList;
import java.util.List;

@RequiredArgsConstructor
@Service
@Transactional
public class ProdReviewService {

    private final ProdReviewMapper prodReviewMapper;


    public List<ProdReviewDto> getProdReviews(int prodNo) {

        List<ProdReviewDto> reviews = prodReviewMapper.prodReviewDto(prodNo);

        return reviews;
    }


}
