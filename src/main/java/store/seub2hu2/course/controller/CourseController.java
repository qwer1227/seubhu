package store.seub2hu2.course.controller;

import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
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
import store.seub2hu2.course.vo.UserBadge;
import store.seub2hu2.course.vo.UserLevel;
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
                       @AuthenticationPrincipal LoginUser loginUser,
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

        // 3. 로그인한 사용자의 코스 관련 정보(현재 배지, 현재 도전 가능한 단계)를 가져오고, Model 객체에 저장한다.
        if (loginUser != null) {
            List<UserBadge> userBadges = userCourseService.getUserBadge(loginUser.getNo());
            UserLevel userLevel = userCourseService.getUserLevel(loginUser.getNo());

            model.addAttribute("userBadges", userBadges);
            model.addAttribute("userLevel", userLevel);
        }

        // 4. Model 객체에 코스 목록, 페이징 처리 정보를 저장한다.
        model.addAttribute("courses", dto.getData());
        model.addAttribute("pagination", dto.getPaging());

        // 5. 뷰 이름을 반환한다.
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
                             @RequestParam(name = "courseNo", required = false) Integer courseNo,
                             @AuthenticationPrincipal LoginUser loginUser,
                             Model model) {
        // 1. 모든 코스 목록을 가져온다.
        List<Course> courses = courseService.getCourses();
        model.addAttribute("courses", courses);

        // 2. Map 객체를 생성하고, page(페이지)를 Map 객체에 저장한다.
        Map<String, Object> condition = new HashMap<>();
        condition.put("page", page);

        // 3. 코스 번호가 존재하는 경우에만 해당 코스의 완주 기록을 가져온다.
        if (courseNo != null) {
            // 4. 요청 파라미터 정보를 Map 객체에 저장한다.
            condition.put("courseNo", courseNo);

            // 5. 해당 코스의 모든 완주 기록을 가져온다.
            ListDto<Records> dto = userCourseService.getAllRecords(condition);

            // 6. 해당 코스의 로그인한 사용자의 완주 기록을 가져온다.
            if (loginUser != null) {
                condition.put("userNo", loginUser.getNo());
                List<Records> records = userCourseService.getMyRecords(condition);
                model.addAttribute("myRecord", records);
            }

            // 7. Model 객체에 코스 완주 기록, 페이징 처리 정보를 저장한다.
            model.addAttribute("records", dto.getData());
            model.addAttribute("pagination", dto.getPaging());
        }

        // 8. 뷰이름을 반환한다.
        return "course/best-runner";
    }
}
