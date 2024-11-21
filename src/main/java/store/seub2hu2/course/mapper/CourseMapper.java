package store.seub2hu2.course.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.course.vo.Course;
import store.seub2hu2.course.vo.Review;
import store.seub2hu2.course.vo.ReviewImage;

import java.util.List;
import java.util.Map;

@Mapper
public interface CourseMapper {
    int getTotalRows(@Param("condition") Map<String, Object> condition); // 전체 데이터 갯수
    List<Course> getCourses(@Param("condition") Map<String, Object> condition); // 코스 목록 가져오기
    Course getCourseByNo(@Param("no") int no); // 코스의 상세 정보 가져오기
}
