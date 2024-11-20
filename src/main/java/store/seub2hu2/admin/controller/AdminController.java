package store.seub2hu2.admin.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.admin.dto.CourseRegisterForm;
import store.seub2hu2.admin.dto.LessonRegisterForm;
import store.seub2hu2.admin.service.AdminService;
import store.seub2hu2.course.service.CourseService;
import store.seub2hu2.course.vo.Course;
import store.seub2hu2.lesson.service.LessonService;
import store.seub2hu2.lesson.vo.Lesson;
import store.seub2hu2.user.vo.User;
import store.seub2hu2.util.ListDto;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
@Slf4j
public class AdminController {



    private final CourseService courseService;

    private final AdminService adminService;
    private final LessonService lessonService;

    @GetMapping("/home")
    public String home() {

        return "admin/home";
    }

    @GetMapping("/lesson-register-form")
    public String lessonRegisterForm() {
        return "admin/lesson-register-form";
    }

    @PostMapping("/lesson-register-form")
    public String lessonRegisterForm(LessonRegisterForm form) {

        return "redirect:/admin/lessonlist";
    }

    @GetMapping("/lesson")
    public String lesson(@RequestParam(name = "opt", required = false) String opt,
                         @RequestParam(name = "day", required = false)
                         @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate day,
                               @RequestParam(name = "value", required = false) String value,
                               Model model) {

        if (day == null) {
            day = LocalDate.now();
        }

        String formattedDay = day.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        Map<String, Object> condition = new HashMap<>();
        condition.put("day", formattedDay);
        if (StringUtils.hasText(value)) {
            condition.put("opt", opt);
            condition.put("value", value);
        }

        System.out.println("condition: " + condition);

        List<Lesson> lessons = adminService.getLessons(condition);
        model.addAttribute("lessons", lessons);

        return "admin/lessonlist";
    }

    @GetMapping("/course-register-form")
    public String courseRegisterForm() {
        return "admin/course-register-form";
    }

    @PostMapping("/course-register-form")
    public String courseRegisterForm(CourseRegisterForm form) {


        adminService.checkNewRegion(form);

        return "redirect:/admin/course";
    }

    /*코스 목록*/
    @GetMapping("/course")
    public String course(@RequestParam(name = "page", required = false, defaultValue = "1") int page,
                       @RequestParam(name = "distance", required = false) Double distance,
                       @RequestParam(name = "level", required = false) Integer level,
                       @RequestParam(name = "keyword", required = false) String keyword,
                       Model model){
        // 1. 요청 파라미터 정보를 Map 객체에 담는다.
        Map<String, Object> condition = new HashMap<>();
        condition.put("page", page);
        condition.put("distance", distance);
        condition.put("level", level);
        if (StringUtils.hasText(keyword)) {
            condition.put("keyword", keyword);
        }
        // 2. 검색에 해당하는 코스 목록을 가져온다.
        ListDto<Course> dto = courseService.getAllCourses(condition);

        // 3. Model 객체에 화면에 표시할 데이터를 저장해서 보낸다.
        model.addAttribute("courses", dto.getData());
        model.addAttribute("pagination", dto.getPaging());

        return "admin/courselist";
    }

    @GetMapping("/user/preview")
    @ResponseBody
    public User preview(int no) {
        User user = adminService.getUser(no);

        return user;
    }

    @GetMapping("/blacklist")
    public String blacklist() {
        return "admin/blacklist";
    }

    @GetMapping("/user")
    public String user(
            @RequestParam(name = "page", required = false, defaultValue = "1") int page,
            @RequestParam(name = "rows", required = false, defaultValue = "10") int rows,
            @RequestParam(name = "opt", required = false) String opt,
            @RequestParam(name= "value", required = false) String value,
            Model model) {

        Map<String, Object> condition = new HashMap<>();
        condition.put("page", page);
        condition.put("rows", rows);
        if (StringUtils.hasText(value)) {
            condition.put("opt", opt);
            condition.put("value", value);
        }

        // 검색조건을 전달해서 게시글 목록 조회
        ListDto<User> dto = adminService.getAllUsers(condition);
        // List<User>를 "users"로 모델에 저장
        model.addAttribute("users", dto.getData());
        // Pagination을 "paging"로 모델에 저장
        model.addAttribute("paging", dto.getPaging());

        return "admin/userlist";
    }

    @GetMapping("/product")
    public String product() {
        /*@RequestParam(name="page", required = false, defaultValue = "1") int page,
        @RequestParam(name="rows", required = false, defaultValue = "10") int rows,
        @RequestParam(name = "opt", required = false) String opt,
        @RequestParam(name= "value", required = false) String value,
        Model model) {
        Map<String, Object> condition = new HashMap<>();
        condition.put("page", page);
        condition.put("rows", rows);
        if (StringUtils.hasText(value)) {
            condition.put("opt", opt);
            condition.put("value", value);
        }
        // 검색조건을 전달해서 게시글 목록 조회
        ListDto<Product> dto = adminService.getAllProduct(condition);
        // List<Product>를 "products"로 모델에 저장
        model.addAttribute("products", dto.getData());
        // Pagination을 "paging"로 모델에 저장
        model.addAttribute("paging", dto.getPaging());*/
        return "admin/productlist";
    }

    @GetMapping("/stock")
    public String stock() {

        return "admin/stocklist";
    }

    @GetMapping("/community")
    public String community() {

        return "admin/community";
    }
}
