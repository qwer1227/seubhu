package store.seub2hu2.course.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.course.dto.AddReviewForm;
import store.seub2hu2.course.service.ReviewService;
import store.seub2hu2.course.vo.Review;
import store.seub2hu2.security.LoginUser;
import store.seub2hu2.security.dto.RestResponseDto;

import java.util.List;

@RestController
@RequestMapping("/course")
public class ReviewController {
    @Autowired
    private ReviewService reviewService;

    @GetMapping("/reviews/{no}")
    public ResponseEntity<RestResponseDto<List<Review>>> reviews(@PathVariable("no") int courseNo) {
        // 코스에 등록된 모든 리뷰를 가져온다.
        List<Review> reviews = reviewService.getReviews(courseNo);

        return ResponseEntity.ok(RestResponseDto.success(reviews));
    }

    //    @PreAuthorize("isAuthenticated()")
    @PostMapping("/addReview")
    @ResponseBody
    public Review addReview(AddReviewForm form, @AuthenticationPrincipal LoginUser loginUser) {
        // 1. 등록할 리뷰 정보를 테이블에 저장한다.
        Review review = reviewService.addNewReview(form, 24); // loginUser.getNo()

        // 2. 등록한 리뷰 정보를 반환한다.
        return review;
    }
}
