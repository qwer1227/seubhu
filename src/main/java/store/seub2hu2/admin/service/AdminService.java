package store.seub2hu2.admin.service;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.admin.mapper.AdminMapper;
import store.seub2hu2.course.mapper.CourseMapper;
import store.seub2hu2.course.vo.Course;
import store.seub2hu2.course.vo.Region;
import store.seub2hu2.product.vo.Product;
import store.seub2hu2.user.mapper.UserMapper;
import store.seub2hu2.user.vo.User;
import store.seub2hu2.util.ListDto;
import store.seub2hu2.util.Pagination;

import java.util.List;
import java.util.Map;

@Service
@Transactional
public class AdminService {

//    private final LessonMapper lessonMapper;
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
    private AdminMapper adminMapper;

    @Autowired
    private CourseMapper courseMapper;

    public void addNewCourse (Course course) {
        adminMapper.insertCourse(course);
    }
    public void addNewRegion (Region region) {
        adminMapper.insertRegion(region);
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

            ListDto<User> dto = new ListDto<>(users, pagination);
            return dto;
        }

    public User getUser(@Param("no") int no) {

            return adminMapper.getUserByNo(no);
    }

/*    public ListDto<Product> getAllProduct(Map<String, Object> condition) {

    }*/
}
