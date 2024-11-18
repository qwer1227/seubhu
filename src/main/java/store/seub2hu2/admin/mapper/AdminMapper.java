package store.seub2hu2.admin.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.course.vo.Course;
import store.seub2hu2.course.vo.Region;
import store.seub2hu2.user.vo.User;
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
     * 코스
     */
    void insertCourse(@Param("course") Course course);

    void insertRegion(@Param("region")Region region);

    Region getRegions(@Param("region")Region region);

    Region checkRegion(@Param("region")Region region);

    /*
     * 상품
     */

    /*
     * 재고
     */

    /*
     * 커뮤니티
     */
}
