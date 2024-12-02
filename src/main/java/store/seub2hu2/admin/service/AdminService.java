package store.seub2hu2.admin.service;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.admin.dto.*;
import store.seub2hu2.admin.mapper.AdminMapper;
import store.seub2hu2.course.mapper.CourseMapper;
import store.seub2hu2.course.vo.Course;
import store.seub2hu2.course.vo.Region;
import store.seub2hu2.lesson.mapper.LessonMapper;
import store.seub2hu2.lesson.vo.Lesson;
import store.seub2hu2.product.vo.*;
import store.seub2hu2.user.mapper.UserMapper;
import store.seub2hu2.user.vo.User;
import store.seub2hu2.util.FileUtils;
import store.seub2hu2.util.ListDto;
import store.seub2hu2.util.Pagination;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@Transactional
public class AdminService {

    @Value("${project.upload.path}")
    private String saveDirectory;
    @Value("${upload.directory.product}")
    private String saveProductDirectory;
//
//    private final CommunityMapper communityMapper;
//
//    private final CourseMapper courseMapper;
//
//    private final OrderMapper orderMapper;
//
//    private final ProductMapper productMapper;
//
    @Autowired
    private LessonMapper lessonMapper;

    @Autowired
    private AdminMapper adminMapper;

    @Autowired
    private CourseMapper courseMapper;


    public List<Lesson> getLessons(Map<String, Object> condition) {

        List<Lesson> lessons = adminMapper.getAllLessons(condition);

        return lessons;

    }


    // 코스 등록 전 새로운지역인지 기존지역인지 확인 후 등록
    public void checkNewRegion (CourseRegisterForm form) {
        Region region = new Region();
        region.setSi(form.getSi());
        region.setGu(form.getGu());
        region.setDong(form.getDong());

        Region savedRegion = adminMapper.checkRegion(region);

        Course course = new Course();

        if (savedRegion == null) {
            adminMapper.insertRegion(region);
            course.setRegion(adminMapper.getRegions(region));

            System.out.println(course.getRegion().getNo());


            course.setName(form.getName());
            course.setTime(form.getTime());
            course.setLevel(form.getLevel());
            Double distance = form.getDistance();

            if (distance == null) {
                distance = 0.0; // 기본값 설정 (필요에 따라 변경)
            }
            course.setDistance(distance);

            MultipartFile multipartFile = form.getImage();
            if (multipartFile != null) {
                String originalFilename = multipartFile.getOriginalFilename();
                String filename = System.currentTimeMillis() + originalFilename;

                FileUtils.saveMultipartFile(multipartFile, saveDirectory, filename);

                course.setFilename(filename);
            }

            adminMapper.insertCourse(course);
        } else {


        course.setRegion(savedRegion);
        course.setName(form.getName());
        course.setTime(form.getTime());
        course.setLevel(form.getLevel());
        Double distance = form.getDistance();

        if (distance == null) {
            distance = 0.0; // 기본값 설정 (필요에 따라 변경)
        }
        course.setDistance(distance);

        MultipartFile multipartFile = form.getImage();
        if (multipartFile != null) {
            String originalFilename = multipartFile.getOriginalFilename();
            String filename = System.currentTimeMillis() + originalFilename;

            FileUtils.saveMultipartFile(multipartFile, saveDirectory, filename);

            course.setFilename(filename);
        }

        adminMapper.insertCourse(course);
    }

    }

    public ListDto<Course> getAllCourse(Map<String, Object> condition) {

        int totalRows = courseMapper.getTotalRows(condition);

        int page = (Integer) condition.get("page");
        int rows = (Integer) condition.get("rows");
        Pagination pagination = new Pagination(page, totalRows, rows);
        int begin = pagination.getBegin();
        int end = pagination.getEnd();
        condition.put("begin", begin);
        condition.put("end", end);


        List<Course> courses = courseMapper.getCourses(condition);

        ListDto<Course> dto = new ListDto<>(courses, pagination);
        return dto;
    }

    @Autowired
    private UserMapper userMapper;

    public ListDto<User> getAllUsers(Map<String, Object> condition) {

            int totalRows = adminMapper.getTotalRows(condition);

            int page = (Integer) condition.get("page");
            int rows = (Integer) condition.get("rows");
            Pagination pagination = new Pagination(page, totalRows, rows);

            int begin = pagination.getBegin();
            int end = pagination.getEnd();
            condition.put("begin", begin);
            condition.put("end", end);



            List<User> users = adminMapper.getUsers(condition);

            System.out.println("users: " + users);
            ListDto<User> dto = new ListDto<>(users, pagination);

            return dto;
        }

    public User getUser(@Param("no") int no) {

            return adminMapper.getUserByNo(no);
    }
    // 상품 수정


    // 상품번호로 그 상품에 관련된 모든 정보 조회
    public Product getProductNo(int no) {

        Product product = adminMapper.getProductByNo(no);

        return product;

    }

    // 상품등록
    public void addProduct(ProductRegisterForm form) {

        HashMap<String, Object> condition = new HashMap<String, Object>();

        condition.put("name", form.getName());
        condition.put("price", form.getPrice());
        condition.put("brandNo", form.getBrandNo());
        condition.put("categoryNo", form.getCategoryNo());
        condition.put("content", form.getContent());
        condition.put("thumbnail", form.getThumbnail());

        System.out.println("condition: " + condition);
        adminMapper.insertProduct(condition);
    }

    // 카테고리 조회
    public Category getCategory(int categoryNo) {
        return adminMapper.getTopCategoryNo(categoryNo);
    }

    // 컬러 번호 조회
    public int getColor(Map<String, Object> condition) {

        Integer colorNo = adminMapper.getColorNo((HashMap<String, Object>) condition);
        return Optional.ofNullable(colorNo).orElse(0); // 결과가 없으면 0 반환
    }

    // 상품 컬러 추가
    public void addColor(Map<String, Object> condition) {

        adminMapper.insertColor((HashMap<String, Object>) condition);
    }

    public void getUpdateProduct(Product product) {

        adminMapper.updateProduct(product);
    }

    public List<Color> getColorName(int no) {
        return adminMapper.colorNames(no);
    }

    public void addThumb(ColorThumbnailForm form, List<String> links) {


        int index = 0;
        for (String link: links) {

            Image img = new Image();
            img.setProdNo(form.getProdNo());
            img.setColorNo(form.getColorNo());
            img.setUrl(link);

            System.out.println(img);

            adminMapper.insertImage(img);
        }

    }

    public List<Image> getImageByColorNo(Integer colorNo) {

        return adminMapper.getImageByColorNum(colorNo);
    }

    public Color getColorNo(int colorNo) {
        return adminMapper.getColorNoByNo(colorNo);
    }

    public void getThumbnailByNo(Integer imgNo) {
        adminMapper.getIsThumByNo(imgNo);
    }

    public void getNullImageThumbyimgNo(Integer imgNo) {
        adminMapper.getNullImageThum(imgNo);
    }

    public void getEditUrl(List<Integer> imgNos, List<String> urls) {

        for (int i = 0; i < imgNos.size(); i++) {
            Image img = new Image();
            img.setNo(imgNos.get(i));
            img.setUrl(urls.get(i));

            adminMapper.editUrl(img);
        }
    }

    public List<Size> getAllSizeByColorNo(Integer colorNo) {

        List<Size> sizeList = adminMapper.getAllSizesByColorNo(colorNo);

        return sizeList;

    }

    public void getCheckSize(Map<String, Object> condition) {
        Size size = new Size();
        size.setSize((String) condition.get("size"));

        Color color = new Color();
        color.setNo((Integer) condition.get("colorNo"));
        size.setColor(color);

        Size existingSize = adminMapper.getCheckSizeByCon(size);

        System.out.println("-------------------------------------------------existingSize"+ existingSize);

        System.out.println("------------------------------------------------conditionSizeNo: " + condition.get("sizeNo"));

        if (existingSize != null && existingSize.getIsDeleted().equals("N")) {
            throw new IllegalArgumentException("이미 등록된 사이즈입니다.");

        } else if (existingSize != null && existingSize.getIsDeleted().equals("Y")) {
            adminMapper.getChangeIsDeleted(size);
        } else {
            adminMapper.getInsertSize(size);
        }
    }

    public void getDeletedSize(int sizeNo) {

        adminMapper.getDeleteSize(sizeNo);
    }

    public List<Color> getStockByColorNum(Map<String, Object> condition) {

        List<Color> dto = adminMapper.getStockByColorNumber(condition);

        return dto;
    }

    public List<Color> getInsertStock(Map<String, Object> condition) {

        List<Color> dto = adminMapper.insertStock(condition);

        return dto;
    }

//    public Color getProductByColorNo(Integer colorNo) {
//
//        return adminMapper.getCallProductByColorNo(colorNo);
//    }
}
