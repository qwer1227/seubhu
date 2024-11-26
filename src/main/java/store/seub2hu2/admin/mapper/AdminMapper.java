package store.seub2hu2.admin.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.course.vo.Course;
import store.seub2hu2.course.vo.Region;
import store.seub2hu2.lesson.vo.Lesson;
import store.seub2hu2.product.vo.Category;
import store.seub2hu2.product.vo.Color;
import store.seub2hu2.product.vo.Product;
import store.seub2hu2.user.vo.User;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Mapper
public interface AdminMapper {


    /*
     * 회원
     */
    int getTotalRows(@Param("condition") Map<String, Object> condition);
    List<User> getUsers(@Param("condition") Map<String, Object> condition);
    User getUserByNo(@Param("no") int no);

    /*
     * 코스 등록
     */
    void insertCourse(@Param("course") Course course);

    void insertRegion(@Param("region")Region region);

    Region getRegions(@Param("region")Region region);

    Region checkRegion(@Param("region")Region region);

    /*
     * 상품
     */
    // 상품 번호와 색상에 해당하는 colorNo 값 조회
    Integer getColorNo(HashMap<String, Object> condition);

    // 색상이 없는 상품만 등록
    void insertProduct(@Param("condition") HashMap<String, Object> condition);

    // 색상 등록
    void insertColor(@Param("condition") HashMap<String, Object> condition);

    //

    /*
     * 재고
     */

    /*
     * 레슨
     */
    List<Lesson> getAllLessons(@Param("condition") Map<String, Object> condition);
    

    Category getTopCategoryNo(@Param("categoryNo") int categoryNo);
}
