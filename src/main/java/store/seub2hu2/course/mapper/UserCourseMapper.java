package store.seub2hu2.course.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.course.vo.CourseLike;
import store.seub2hu2.course.vo.CourseWhether;

@Mapper
public interface UserCourseMapper {
    CourseWhether checkSuccess(@Param("userNo") int userNo, @Param("courseNo") int courseNo); // 로그인한 사용자가 코스를 성공했는지 확인한다.
    CourseLike getCourseLike(@Param("userNo") int userNo, @Param("courseNo") int courseNo); // 코스 완주자의 좋아요 클릭 여부 정보를 가져온다.
    void updateLikeCount(@Param("courseNo") int courseNo, @Param("likeCount") int likeCount); // 좋아요 버튼을 클릭하면, 좋아요 수가 증가하거나 감소한다.
    void insertLikeUser(@Param("userNo") int userNo, @Param("courseNo") int courseNo); // 좋아요를 클릭한 사용자의 정보를 추가한다.
    void deleteLikeUser(@Param("userNo") int userNo, @Param("courseNo") int courseNo); // 좋아요을 클릭한 사용자의 정보를 삭제한다.
}
