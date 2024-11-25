package store.seub2hu2.course.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.course.vo.Review;
import store.seub2hu2.course.vo.ReviewImage;

import java.util.List;

@Mapper
public interface ReviewMapper {
    List<Review> getReviewsByNo(@Param("no") int no); // 코스 리뷰 목록 가져오기
    List<ReviewImage> getReviewImagesByNo(@Param("no") int no); // 코스 리뷰 첨부파일 목록 가져오기
    void insertReview(@Param("review") Review review); // 코스 리뷰 등록하기
    void insertReviewImage(@Param("reviewImage") ReviewImage reviewImage); // 첨부 파일 등록하기
}
