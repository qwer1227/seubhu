package store.seub2hu2.course.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.course.dto.SuccessCountRankForm;
import store.seub2hu2.course.vo.*;

import java.util.List;
import java.util.Map;

@Mapper
public interface UserCourseMapper {
    List<UserBadge> getUserBadge(@Param("userNo") int userNo); // 로그인한 사용자의 현재 배지 정보를 가져온다.
    UserLevel getUserLevel(@Param("userNo") int userNo); // 로그인한 사용자의 현재 도전 가능한 단계를 가져온다.

    int getTotalRows(@Param("condition") Map<String, Object> condition); // 코스에 해당하는 완주 기록의 갯수를 가져온다.
    int getTotalRegisterRows(@Param("condition") Map<String, Object> condition); // 로그인한 사용자가 도전 등록한 코스의 갯수를 가져온다.
    int getTotalAllSuccessCountRanks(@Param("condition") Map<String, Object> condition); // 모든 사용자의 코스 달성 수 순위 목록의 갯수를 가져온다.

    List<Records> getRecords(@Param("condition") Map<String, Object> condition); // 조회 범위 내에서 완주 기록 목록을 가져온다.
    List<Course> getCoursesToChallenge(@Param("condition") Map<String, Object> condition); // 조회 범위 내에서 로그인한 사용자가 도전 등록한 코스 목록을 가져온다.
    List<Records> getMyRecords(@Param("condition") Map<String, Object> condition); // 조회 범위 내에서 로그인한 사용자의 코스에 해당하는 완주 기록 목록을 가져온다.

    SuccessCountRankForm getMySuccessCountRank(@Param("userNo") int userNo); // 로그인한 사용자의 코스 달성 수 순위를 가져온다.
    List<SuccessCountRankForm> getAllSuccessCountRanks(@Param("condition") Map<String, Object> condition); // 조회 범위 내에서 모든 사용자의 코스 달성 수 순위 목록을 가져온다.

    SuccessWhether checkSuccess(@Param("userNo") int userNo, @Param("courseNo") int courseNo); // 로그인한 사용자가 코스를 성공했는지 확인한다.
    ChallengeWhether checkChallenge(@Param("courseNo") int courseNo, @Param("userNo") int userNo); // 로그인한 사용자가 코스 도전 등록을 했는지 확인한다.
    CourseLike getCourseLike(@Param("userNo") int userNo, @Param("courseNo") int courseNo); // 코스 완주자의 좋아요 클릭 여부 정보를 가져온다.

    void insertChallenger(@Param("courseNo") int courseNo, @Param("userNo") int userNo); // 도전할 코스 등록하기 버튼을 클릭한 사용자의 정보를 추가한다.
    void deleteChallenger(@Param("courseNo") int courseNo, @Param("userNo") int userNo); // 도전할 코스 등록 취소 버튼을 클릭한 사용자의 정보를 삭제한다.
    void updateLikeCount(@Param("courseNo") int courseNo, @Param("likeCount") int likeCount); // 좋아요 버튼을 클릭하면, 좋아요 수가 증가하거나 감소한다.
    void insertLikeUser(@Param("userNo") int userNo, @Param("courseNo") int courseNo); // 좋아요를 클릭한 사용자의 정보를 추가한다.
    void deleteLikeUser(@Param("userNo") int userNo, @Param("courseNo") int courseNo); // 좋아요을 클릭한 사용자의 정보를 삭제한다.
}
