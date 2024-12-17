package store.seub2hu2.product.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.product.service.ProdReviewService;
import store.seub2hu2.product.vo.ProdReview;

import java.io.IOException;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/reviews")
public class ProdReviewController {

    private final ProdReviewService prodReviewService;

    @PostMapping("/review-write")
    public String writeReview(@RequestParam("prodNo") int prodNo
                            , @RequestParam("reviewNo") int reviewNo
                            , @RequestParam("content") String content
                              ,@RequestParam("rating") int rating
                            ,@RequestParam("files") List<MultipartFile> files) throws IOException {


        ProdReview prodReview = new ProdReview();
        prodReview.setProdNo(prodNo);
        prodReview.setContent(content);

        return "리뷰 작성이 완료되었습니다";
    }
}
