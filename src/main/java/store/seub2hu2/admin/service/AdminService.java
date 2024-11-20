package store.seub2hu2.admin.service;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.admin.dto.CourseRegisterForm;
import store.seub2hu2.admin.mapper.AdminMapper;
import store.seub2hu2.course.mapper.CourseMapper;
import store.seub2hu2.course.vo.Course;
import store.seub2hu2.course.vo.Region;
import store.seub2hu2.lesson.mapper.LessonMapper;
import store.seub2hu2.lesson.vo.Lesson;
import store.seub2hu2.user.mapper.UserMapper;
import store.seub2hu2.user.vo.User;
import store.seub2hu2.util.FileUtils;
import store.seub2hu2.util.ListDto;
import store.seub2hu2.util.Pagination;

import java.util.List;
import java.util.Map;

@Service
@Transactional
public class AdminService {

    @Value("${project.upload.path}")
    private String saveDirectory;
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

/*    public ListDto<Product> getAllProduct(Map<String, Object> condition) {

    }*/
}
