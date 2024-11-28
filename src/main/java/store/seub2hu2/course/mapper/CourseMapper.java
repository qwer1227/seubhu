package store.seub2hu2.course.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.course.vo.*;

import java.util.List;
import java.util.Map;

@Mapper
public interface CourseMapper {
    int getTotalRows(@Param("condition") Map<String, Object> condition); // 전체 데이터 갯수를 가져온다.
    List<Course> getCourses(@Param("condition") Map<String, Object> condition); // 모든 코스 목록을 가져온다.
    Course getCourseByNo(@Param("no") int no); // 코스의 상세 정보를 가져온다.
}
