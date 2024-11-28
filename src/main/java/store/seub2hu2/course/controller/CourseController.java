package store.seub2hu2.course.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.course.service.CourseService;
import store.seub2hu2.course.service.UserCourseService;
import store.seub2hu2.course.vo.Course;
import store.seub2hu2.course.vo.Records;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.util.ListDto;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/course")
public class CourseController {
    @Autowired
    private CourseService courseService;

    @Autowired
    private UserCourseService userCourseService;

    @GetMapping("/list")
    public String list(@RequestParam(name = "page", required = false, defaultValue = "1") int page,
                       @RequestParam(name = "sort", required = false) String sort,
                       @RequestParam(name = "distance", required = false, defaultValue = "10") Double distance,
                       @RequestParam(name = "level", required = false) Integer level,
                       @RequestParam(name = "keyword", required = false) String keyword,
                       Model model){
        // 1. 요청 파라미터 정보를 Map 객체에 저장한다.
        Map<String, Object> condition = new HashMap<>();
        condition.put("page", page);
        if (StringUtils.hasText(sort)) {
            condition.put("sort", sort);
        }
        if (distance != null) {
            condition.put("distance", distance);
        }
        if (level != null) {
            condition.put("level", level);
        }
        if (StringUtils.hasText(keyword)) {
            condition.put("keyword", keyword);
        }

        // 2. 검색에 해당하는 코스 목록을 가져온다.
        ListDto<Course> dto = courseService.getAllCourses(condition);

        // 3. Model 객체에 화면에 표시할 데이터(코스 목록, 페이징 처리 정보)를 저장한다.
        model.addAttribute("courses", dto.getData());
        model.addAttribute("pagination", dto.getPaging());

        // 4. 뷰 이름을 반환한다.
        return "course/list";
    }

    @GetMapping("/detail")
    public String detail(@RequestParam(name = "no") int courseNo, @AuthenticationPrincipal LoginUser loginUser, Model model) {
        // 1. 코스의 상세 정보를 가져온다.
        Course course = courseService.getCourseDetail(courseNo);

        // 2. 로그인한 경우, 코스 완주 여부와 좋아요 클릭 여부를 확인한다.
        if (loginUser != null) {
            boolean isSuccess = userCourseService.checkSuccess(loginUser.getNo(), courseNo); // 코스 완주 여부
            boolean isLike = userCourseService.checkLike(loginUser.getNo(), courseNo); // 좋아요 클릭 여부

            model.addAttribute("isSuccess", isSuccess);
            model.addAttribute("isLike", isLike);
        }

        // 3. Model 객체에 코스의 상세 정보를 저장한다.
        model.addAttribute("course", course);

        // 4. 뷰이름을 반환한다.
        return "course/detail";
    }

    @PreAuthorize("isAuthenticated()")
    @GetMapping("/controlLikeCount")
    public String controlLikeCount(@RequestParam(name = "courseNo") int courseNo, @AuthenticationPrincipal LoginUser loginUser) {
        // 1. 코스의 좋아요 수를 증가시키거나 감소시킨다.
        userCourseService.addOrReduceLikeCount(courseNo, loginUser.getNo());

        // 2. detail.jsp를 재요청한다.
        return "redirect:detail?no=" + courseNo;
    }

    @GetMapping("/best-runner")
    public String bestRunner(@RequestParam(name = "page", required = false, defaultValue = "1") int page,
                             @RequestParam(name = "courseNo", required = false) Integer courseNo, Model model) {
        // 1. 모든 코스 목록을 가져온다.
        List<Course> courses = courseService.getCourses();

        // 2. 요청 파라미터 정보를 Map 객체에 저장한다.
        Map<String, Object> condition = new HashMap<>();
        condition.put("page", page);
        if (courseNo != null) {
            condition.put("courseNo", courseNo);
        }

        // 3. 코스 완주 기록을 가져온다.
        ListDto<Records> dto = userCourseService.getAllRecords(condition);

        // 4. Model 객체에 저장한다.
        model.addAttribute("courses", courses);
        model.addAttribute("records", dto.getData());
        model.addAttribute("pagination", dto.getPaging());

        // 5. 뷰이름을 반환한다.
        return "course/best-runner";
    }
}
