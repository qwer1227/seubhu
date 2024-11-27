package store.seub2hu2.course.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.course.vo.CourseWhether;

@Mapper
public interface UserCourseMapper {
    CourseWhether checkSuccess(@Param("userNo") int userNo); // 로그인한 사용자가 코스를 성공했는지 확인한다.
}
