package store.seub2hu2.product.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.product.dto.ProdReviewDto;
import store.seub2hu2.product.dto.ProdReviewForm;
import store.seub2hu2.product.mapper.ProdReviewMapper;
import store.seub2hu2.product.vo.ProdReview;
import store.seub2hu2.product.vo.ProdReviewImg;

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

    public ProdReviewDto addProdReview(ProdReviewForm form, int userNo) {

        ProdReviewDto dto = new ProdReviewDto();

        ProdReview prodReview = new ProdReview();
        prodReview.setProdNo(form.getProdNo());
        prodReview.setTitle(form.getTitle());
        prodReview.setContent(form.getContent());
        prodReview.setUserNo(userNo);
        prodReview.setRating(form.getRating());

        prodReviewMapper.insertProdReview(prodReview);

        ProdReviewImg img = new ProdReviewImg();
        img.setReviewNo(prodReview.getNo());

        return dto;
    }


}
