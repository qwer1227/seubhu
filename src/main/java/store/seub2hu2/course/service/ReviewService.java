package store.seub2hu2.course.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.admin.mapper.AdminMapper;
import store.seub2hu2.course.dto.AddReviewForm;
import store.seub2hu2.course.mapper.ReviewMapper;
import store.seub2hu2.course.vo.Course;
import store.seub2hu2.course.vo.Review;
import store.seub2hu2.course.vo.ReviewImage;
import store.seub2hu2.user.vo.User;
import store.seub2hu2.util.FileUtils;

import java.util.Date;
import java.util.List;

@Service
@Transactional
public class ReviewService {
    @Value("${upload.directory.course}")
    private String saveDirectory;

    private ReviewMapper reviewMapper;

    private AdminMapper adminMapper;

    /**
     * 코스에 등록된 리뷰 목록을 가져온다.
     * @param courseNo 코스번호
     * @return 리뷰 목록
     */
    public List<Review> getReviews(int courseNo) {
        // 코스에 등록된 리뷰 목록을 가져온다.
        return reviewMapper.getReviewsByNo(courseNo);
    }

    /**
     * 입력한 리뷰 정보를 등록한다.
     * @param form 입력한 리뷰 정보
     * @param userNo 사용자 번호
     * @return 입력한 리뷰 정보
     */
    public Review addNewReview(AddReviewForm form, int userNo) {
        // 1. 등록할 리뷰 정보를 리뷰 객체에 저장한다.
        Review review = new Review();
        review.setTitle(form.getTitle());
        review.setContent(form.getContent());
        review.setCreatedDate(new Date());

        Course course = new Course();
        course.setNo(form.getCourseNo());
        review.setCourse(course);

        User user = adminMapper.getUserByNo(userNo);
        review.setUser(user);

        // 2. 입력한 리뷰를 테이블에 저장한다.
        reviewMapper.insertReview(review);

        // 3. 첨부 파일을 지정된 경로에 저장하고, 테이블에 저장한다.
        List<MultipartFile> multipartFiles = form.getUpfiles();
        ReviewImage reviewImage = new ReviewImage();
        if (multipartFiles != null && !multipartFiles.isEmpty()) {
            for (MultipartFile multipartFile : multipartFiles) {
                String originalFilename = FileUtils.saveMultipartFile(multipartFile, saveDirectory);
                String filename = System.currentTimeMillis() + originalFilename;
                reviewImage.setName(filename);
                reviewMapper.insertReviewImage(reviewImage);
                review.getReviewImage().add(reviewImage);
            }
        }

        // 4. 등록한 리뷰 정보를 반환한다.
        return review;
    }
}
