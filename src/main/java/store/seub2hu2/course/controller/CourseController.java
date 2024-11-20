package store.seub2hu2.course.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.course.dto.AddReviewForm;
import store.seub2hu2.course.service.CourseService;
import store.seub2hu2.course.vo.Course;
import store.seub2hu2.course.vo.Review;
import store.seub2hu2.course.vo.ReviewImage;
import store.seub2hu2.security.LoginUser;
import store.seub2hu2.user.vo.User;
import store.seub2hu2.util.FileUtils;
import store.seub2hu2.util.ListDto;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/course")
public class CourseController {
    @Autowired
    private CourseService courseService;

    @GetMapping("/list")
    public String list(@RequestParam(name = "page", required = false, defaultValue = "1") int page,
                       @RequestParam(name = "distance", required = false, defaultValue = "10") Double distance,
                       @RequestParam(name = "level", required = false) Integer level,
                       @RequestParam(name = "keyword", required = false) String keyword,
                       Model model){
        // 1. 요청 파라미터 정보를 Map 객체에 담는다.
        Map<String, Object> condition = new HashMap<>();
        condition.put("page", page);
        if (distance != null) {
            condition.put("distance", distance);
        }
        if (level != null) {
            condition.put("level", level);
        }
        if (StringUtils.hasText(keyword)) {
            condition.put("keyword", keyword);
        }

        System.out.println("페이지:" + condition.get("page"));
        System.out.println("거리:" + condition.get("distance"));
        System.out.println("난이도:" + condition.get("level"));
        System.out.println("검색어:" + condition.get("keyword"));

        // 3. 검색에 해당하는 코스 목록을 가져온다.
        ListDto<Course> dto = courseService.getAllCourses(condition);

        // 4. Model 객체에 화면에 표시할 데이터를 저장해서 보낸다.
        model.addAttribute("courses", dto.getData());
        model.addAttribute("pagination", dto.getPaging());
        model.addAttribute("searchNo", condition.get("searchNo"));

        // 5. 뷰 이름을 반환한다.
        return "course/list";
    }

    @GetMapping("/detail")
    public String detail(@RequestParam(name = "no") int no, Model model) {
        // 1. 코스의 상세 정보를 가져온다.
        Course course = courseService.getCourseDetail(no);

        // 2. Model 객체에 코스의 상세 정보를 저장한다.
        model.addAttribute("course", course);

        // 3. 뷰이름을 반환한다.
        return "course/detail";
    }

    @PostMapping("/addReview")
    @ResponseBody
    public Review addReview(AddReviewForm form, @AuthenticationPrincipal LoginUser loginUser) {
        // 1. 등록할 리뷰 정보를 테이블에 저장한다.
        Review review = courseService.addNewReview(form, loginUser.getNo());

        // 2. 등록한 리뷰 정보를 반환한다.
        return review;
    }
}
