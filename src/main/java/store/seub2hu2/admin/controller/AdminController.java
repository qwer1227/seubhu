package store.seub2hu2.admin.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import store.seub2hu2.admin.dto.ColorThumbnailForm;
import store.seub2hu2.admin.dto.CourseRegisterForm;
import store.seub2hu2.admin.dto.ImageUrlDto;
import store.seub2hu2.admin.dto.ProductRegisterForm;
import store.seub2hu2.admin.service.AdminService;
import store.seub2hu2.course.service.CourseService;
import store.seub2hu2.course.vo.Course;
import store.seub2hu2.lesson.dto.LessonRegisterForm;
import store.seub2hu2.lesson.dto.LessonUpdateDto;
import store.seub2hu2.lesson.service.LessonFileService;
import store.seub2hu2.lesson.service.LessonService;
import store.seub2hu2.lesson.vo.Lesson;
import store.seub2hu2.product.dto.*;
import store.seub2hu2.product.service.ProductService;
import store.seub2hu2.product.vo.*;
import store.seub2hu2.product.vo.Category;
import store.seub2hu2.product.vo.Color;
import store.seub2hu2.product.vo.Image;
import store.seub2hu2.product.vo.Product;
import store.seub2hu2.user.service.UserService;
import store.seub2hu2.user.vo.User;
import store.seub2hu2.util.ListDto;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;


@Controller
@RequestMapping("/admin")
@RequiredArgsConstructor
@Slf4j
public class AdminController {



    private final CourseService courseService;

    private final AdminService adminService;
    private final LessonService lessonService;
    private final LessonFileService lessonFileService;
    private final ProductService productService;
    private final UserService userService;

    @GetMapping("/home")
    public String home() {

        return "admin/home";
    }

    @GetMapping("/lesson-edit-form")
    public String lessonEditForm(@RequestParam("lessonNo")Integer lessonNo, Model model) {

        try {

            // 강사 정보 가져오기
            List<User> lecturers =  userService.findUsersByUserRoleNo(3);

            // Lesson 정보 가져오기
            Lesson lesson = lessonService.getLessonByNo(lessonNo);

            // 이미지 파일 정보 가져오기
            Map<String, String> images = lessonFileService.getImagesByLessonNo(lessonNo);

            // 모델에 레슨, 이미지, 강사 정보 추가
            model.addAttribute("lecturers", lecturers);
            model.addAttribute("lesson", lesson);
            model.addAttribute("lessonNo", lessonNo);
            model.addAttribute("images", images);

            log.info("lesson start = {}", lesson);

            return "admin/lesson-edit-form";
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Invalid lessonNo: " + lessonNo);
        }
    }

    @PostMapping("/lesson-edit-form")
    public String lessonEditForm(@ModelAttribute("dto") LessonUpdateDto dto) {

        log.info("레슨 수정 정보 {} ", dto);
        lessonService.updateLesson(dto);

        return "redirect:/admin/lesson";
    }

    @GetMapping("/lesson-register-form")
    public String lessonRegisterForm(Model model) {

        // 사용자 권한이 강사인 사용자 목록을 조회한다.
        List<User> lecturers =  userService.findUsersByUserRoleNo(3);
        model.addAttribute("lecturers", lecturers);

        return "admin/lesson-register-form";
    }

    @PostMapping("/lesson-register-form")
    public String form(@ModelAttribute("form") LessonRegisterForm form, Model model) throws IOException {



        lessonService.registerLesson(form);

        // Redirect after successful form submission
        return "redirect:/admin/lesson";

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
        model.addAttribute("day", day); // 선택한 날짜를 다시 전달

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
    public User preview(@RequestParam("no") int no) {
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

    @GetMapping("/register-editform")
    public String registerEditForm(@RequestParam("no") int no,
                                   @RequestParam(value = "colorNo", required = false) Integer colorNo,
                                   Model model) {

        Product product = adminService.getProductNo(no);

        List<Color> colors = adminService.getColorName(no);

        model.addAttribute("colors", colors);
        model.addAttribute("product", product);


        return "admin/product-edit-form";
    }

    @PostMapping("/register-editform")
    public String registerEditTitle(Product product,
                                    Model model) {

        adminService.getUpdateProduct(product);

        System.out.println("---------------------------------------product:"+ product);

        return "redirect:/admin/product-detail?no=" + product.getNo() + "&colorNo=" + product.getColorNum();
    }

    @GetMapping("/delete-size")
    public String getDeleteSize(@RequestParam("no") int no,
                                @RequestParam("colorNo") Integer colorNo,
                                Model model) {

        // 상품 정보 가져오기
        Product product = adminService.getProductNo(no);
        List<Color> colors = adminService.getColorName(no);
        Color color = adminService.getColorNo(colorNo);
        List<Size> sizes = adminService.getAllSizeByColorNo(colorNo);

        model.addAttribute("product", product);
        model.addAttribute("colors", colors);
        model.addAttribute("color", color);
        model.addAttribute("sizes", sizes);

        if (sizes == null || sizes.isEmpty()) {
            model.addAttribute("sizeMessage", "등록된 사이즈가 없습니다.");
            sizes = Collections.emptyList(); // 비어 있는 리스트 전달
        }

        return "admin/product-size-delete-form";
    }

    @PostMapping("/delete-size")
    public String deleteSize(@RequestParam("no") int no,
                             @RequestParam("colorNo") Integer colorNo,
                             @RequestParam("sizeNo") int sizeNo,
                             Model model) {

        adminService.getDeletedSize(sizeNo);

        return "redirect:/admin/delete-size?no=" + no + "&colorNo=" + colorNo;
    }

    @GetMapping("/register-size")
    public String registerSize(@RequestParam("no") int no,
                               @RequestParam("colorNo") Integer colorNo,
                               Model model) {

        // 상품 정보 가져오기
        Product product = adminService.getProductNo(no);
        List<Color> colors = adminService.getColorName(no);
        Color color = adminService.getColorNo(colorNo);
        List<Size> sizes = adminService.getAllSizeByColorNo(colorNo);

        if (sizes == null || sizes.isEmpty()) {
            model.addAttribute("sizeMessage", "등록된 사이즈가 없습니다.");
            sizes = Collections.emptyList(); // 비어 있는 리스트 전달
        }
        // 모델에 데이터 추가
        model.addAttribute("product", product);
        model.addAttribute("colors", colors);
        model.addAttribute("color", color);
        model.addAttribute("sizes", sizes);

        return "admin/product-size-register-form";
    }
    @PostMapping("/register-size")
    public String registerSize(@RequestParam("no") int no,
                               @RequestParam("colorNo") Integer colorNo,
                               @RequestParam("size") String size,
                               RedirectAttributes redirectAttributes) {

        Map<String, Object> condition = new HashMap<>();
        condition.put("colorNo", colorNo);
        condition.put("size", size);

        try {

            adminService.getCheckSize(condition);
        } catch (IllegalArgumentException e) {

            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }



        return "redirect:/admin/register-size?no=" + no + "&colorNo=" + colorNo;


    }


    @GetMapping("/image-editform")
    public String getImageEditForm(@RequestParam("no") int no,
                                   @RequestParam("colorNo") Integer colorNo,
                                   Model model) {

        Product product = adminService.getProductNo(no);

        Color color = adminService.getColorNo(colorNo);

        List<Color> colors = adminService.getColorName(no);
        List<Image> images = adminService.getImageByColorNo(colorNo);

        model.addAttribute("product", product);
        model.addAttribute("color", color);
        model.addAttribute("colors", colors);
        model.addAttribute("images", images);

        return "admin/product-image-edit-form";
    }

    @PostMapping("/image-editform")
    public String imageEditForm(@RequestParam("no") int no,
                                @RequestParam("colorNo") Integer colorNo,
                                @RequestParam("imgNo") List<Integer> imgNoList,
                                @RequestParam("url") List<String> urlList) {

        List<Image> images = adminService.getImageByColorNo(colorNo);

        adminService.getEditUrl(imgNoList, urlList);

        return "redirect:/admin/product-detail?no=" + no + "&colorNo=" + colorNo;
    }

    @GetMapping("/image-changeThumb")
    public String getImageChangeForm(@RequestParam("no") int no,
                                   @RequestParam("colorNo") Integer colorNo,
                                Model model) {

        Product product = adminService.getProductNo(no);

        List<Color> colors = adminService.getColorName(no);

        Color color = adminService.getColorNo(colorNo);

        List<Image> images = adminService.getImageByColorNo(colorNo);
        model.addAttribute("images", images);

        model.addAttribute("color", color);
        model.addAttribute("colors", colors);
        model.addAttribute("product", product);

        return "admin/product-image-title-form";
    }

    @PostMapping("/image-changeThumb")
    public String imageChangeForm(@RequestParam("no") int no,
                                @RequestParam("colorNo") Integer colorNo,
                                @RequestParam("imgNo") Integer imgNo,
                                @RequestParam("url") String url,
                                Model model) {

        List<Image> images = adminService.getImageByColorNo(colorNo);

        model.addAttribute("images", images);

        adminService.getNullImageThumbyimgNo(imgNo);

        adminService.getThumbnailByNo(imgNo);

        return "redirect:/admin/product-detail?no=" + no + "&colorNo=" + colorNo;
    }

    @GetMapping("/register-image")
    public String getRegisterImage(@RequestParam("no") int no,
                                Model model) {


        Product product = adminService.getProductNo(no);
        List<Color> colors = adminService.getColorName(no);

        model.addAttribute("colors", colors);
        model.addAttribute("product", product);

        return "admin/product-image-register-form";
    }

    @PostMapping("/register-image")
    public String registerImage(@ModelAttribute ColorThumbnailForm form,
                                @RequestParam("image[]") List<String> links,  // 이미지 URL 배열로 받기
                                Model model) {

        adminService.addThumb(form, links);

        return "redirect:/admin/product-detail?no=" + form.getProdNo() + "&colorNo=" + form.getColorNo();
    }

    @GetMapping("/register-color")
    public String getRegisterColor(@RequestParam("no") int no,
                                Model model) {

        ProdDetailDto prodDetailDto = productService.getProductByNo(no);
        model.addAttribute("prodDetailDto", prodDetailDto);

        return "admin/product-color-register-form";
    }

    @PostMapping("/register-color")
    public String registerColor(@RequestParam(name="no", required = false) Integer no,
                                @RequestParam(name="name", required = false) String name,
                                Model model) {

        if (no == null || name == null || name.isEmpty()) {
            throw new IllegalArgumentException("상품 번호와 색상은 필수 입력 값입니다.");
        }

        Map<String, Object> condition = new HashMap<>();
        condition.put("no", no);
        condition.put("name", name);

        System.out.println("condition:" + condition);

        model.addAttribute("condition", condition);
        adminService.addColor(condition);

        int colorNo = adminService.getColor(condition);

        System.out.println("colorNo: " + colorNo);
        return "redirect:/admin/product-detail?no=" + condition.get("no") + "&colorNo=" + colorNo;
    }

    @GetMapping("/product-detail")
    public String productAdminDetail(@RequestParam("no") int no,
                                     @RequestParam("colorNo") int colorNo,
                                     Model model) {


        ProdDetailDto prodDetailDto = productService.getProductByNo(no);
        model.addAttribute("prodDetailDto", prodDetailDto);

        List<ColorProdImgDto> colorProdImgDto = productService.getProdImgByColorNo(no);
        model.addAttribute("colorProdImgDto", colorProdImgDto);

        SizeAmountDto sizeAmountDto = productService.getSizeAmountByColorNo(colorNo);
        model.addAttribute("sizeAmountDto", sizeAmountDto);

        ProdImagesDto prodImagesDto = productService.getProdImagesByColorNo(colorNo);
        model.addAttribute("prodImagesDto", prodImagesDto);

        Color color = adminService.getColorNo(colorNo);

        model.addAttribute("color", color);

        return "admin/product-admin-detail";
    }


    @GetMapping("/product-register-form")
    public String productRegisterForm() {

        return "admin/product-register-form";
    }

    @PostMapping("/product-register-form")
    public String productRegisterForm(ProductRegisterForm form, Model model) {

        adminService.addProduct(form);

        Category category = adminService.getCategory(form.getCategoryNo());

         return "redirect:/admin/product?topNo="+ category.getTopNo();
    }

    @GetMapping("/product-stock-detail")
    public String getProductStockDetail(@RequestParam("no") int no,
                                        @RequestParam("colorNo") Integer colorNo,
                                     Model model) {

        Product product = adminService.getProductNo(no);
        List<Color> colors = adminService.getColorName(no);

        model.addAttribute("product", product);
        model.addAttribute("colors", colors);

        return "admin/product-stock-detail";
    }
    @PostMapping("/product-stock-detail")
    public String productStockDetail(@RequestParam("no") int no,
                                     Model model) {

        return "admin/product-stock-detail";
    }

    @GetMapping("/product-stock")
    public String getProductStock(@RequestParam(name= "topNo") int topNo,
                                  @RequestParam(name = "catNo", required = false, defaultValue = "0") int catNo,
                                  @RequestParam(name = "page", required = false, defaultValue = "1") int page,
                                  @RequestParam(name = "rows", required = false, defaultValue = "5") int rows,
                                  @RequestParam(name = "sort" , required = false, defaultValue = "date") String sort,
                                  @RequestParam(name = "opt", required = false) String opt,
                                  @RequestParam(name = "value", required = false) String value,
                                  Model model) {

        Map<String, Object> condition = new HashMap<>();
        condition.put("topNo", topNo);
        if(catNo != 0) {
            condition.put("catNo", catNo);
        }

        condition.put("page", page);
        condition.put("rows", rows);
        condition.put("sort", sort);
        if(StringUtils.hasText(opt)) {
            condition.put("opt", opt);
            condition.put("value", value);
        }

        ListDto<ProdListDto> dto = productService.getProducts(condition);
        model.addAttribute("topNo", topNo);
        model.addAttribute("catNo", catNo);
        model.addAttribute("products", dto.getData());
        model.addAttribute("paging", dto.getPaging());

        return "admin/product-stock";
    }

    @GetMapping("/product")
    public String list(@RequestParam(name= "topNo") int topNo,
                       @RequestParam(name = "catNo", required = false, defaultValue = "0") int catNo,
                       @RequestParam(name = "page", required = false, defaultValue = "1") int page,
                       @RequestParam(name = "rows", required = false, defaultValue = "6") int rows,
                       @RequestParam(name = "sort" , required = false, defaultValue = "date") String sort,
                       @RequestParam(name = "opt", required = false) String opt,
                       @RequestParam(name = "value", required = false) String value,
                       Model model) {

        Map<String, Object> condition = new HashMap<>();
        condition.put("topNo", topNo);
        if(catNo != 0) {
            condition.put("catNo", catNo);
        }

        condition.put("page", page);
        condition.put("rows", rows);
        condition.put("sort", sort);
        if(StringUtils.hasText(opt)) {
            condition.put("opt", opt);
            condition.put("value", value);
        }

        ListDto<ProdListDto> dto = productService.getProducts(condition);
        model.addAttribute("topNo", topNo);
        model.addAttribute("catNo", catNo);
        model.addAttribute("products", dto.getData());
        model.addAttribute("paging", dto.getPaging());

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
