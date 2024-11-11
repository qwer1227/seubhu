package store.seub2hu2.admin.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.xmlbeans.impl.xb.xsdschema.ListDocument;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import store.seub2hu2.admin.service.AdminService;
import store.seub2hu2.course.vo.Course;
import store.seub2hu2.product.vo.Product;
import store.seub2hu2.user.vo.User;
import store.seub2hu2.util.ListDto;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
@Slf4j
public class AdminController {

    private final AdminService adminService;

    @GetMapping("/home")
    public String home() {

        return "admin/home";
    }

    @GetMapping("/course")
    public String course(
        @RequestParam(name = "page", required = false, defaultValue = "1") int page,
        @RequestParam(name = "rows", required = false, defaultValue = "10") int rows,
                Model model) {
        Map<String, Object> condition = new HashMap<>();
        condition.put("page", page);
        condition.put("rows", rows);

        ListDto<Course> dto = adminService.getAllCourse(condition);
        model.addAttribute("courses", dto.getData());
        model.addAttribute("paging", dto.getPaging());

        return "admin/courselist";
    }

    @GetMapping("/user/preview")
    @ResponseBody
    public User preview(int no) {
        User user = adminService.getUser(no);

        return user;
    }

    @GetMapping("/user-form")
    public String userForm() {

        return "admin/user-form";
    }

    @GetMapping("/user-register-form")
    public String userRegisterForm() {

        return "admin/user-register-form";
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
