package store.seub2hu2.home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import store.seub2hu2.community.vo.Board;
import store.seub2hu2.community.vo.Marathon;
import store.seub2hu2.course.vo.Course;
import store.seub2hu2.lesson.vo.Lesson;
import store.seub2hu2.product.dto.ProdListDto;

import java.util.List;

@Service
public class HomeService {

    @Autowired
    private HomeMapper homeMapper;


    // 최신 게시글 5개 조회
    public List<Board> getTopViewedBoards() {
        return homeMapper.getTopViewedBoards(); // 최신 글 5개 반환
    }

    // 접수 마감일순 마라톤 정보 5개 조회
    public List<Marathon> getLatestMarathons() {
        return homeMapper.getLatestMarathons();
    }

    // 최신 글 5개 조회
    public List<Lesson> getOngoingLessons() {
        return homeMapper.getOngoingLessons ();
    }

    // 주간 베스트 상품 - 별점 순으로 조회
    public List<ProdListDto> getWeeklyBestProductsByRating() {
        return homeMapper.getWeeklyBestProductsByRating();
    }

    // 주간 베스트 상품 - 조회수 순으로 조회 (러닝화 기준)
    public List<ProdListDto> getWeeklyBestProductsByViewCount() {
        return homeMapper.getWeeklyBestProductsByViewCount();
    }

    public List<Course> getTopLikedCourses() {
        return homeMapper.getTopLikedCourses();
    }

}

