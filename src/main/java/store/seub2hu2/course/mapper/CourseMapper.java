package store.seub2hu2.course.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.course.vo.Course;

import java.util.List;
import java.util.Map;

@Mapper
public interface CourseMapper {

    List<Course> getCourses(@Param("condition") Map<String, Object> condition);

    int getTotalRows(@Param("condition") Map<String, Object> condition);
}
