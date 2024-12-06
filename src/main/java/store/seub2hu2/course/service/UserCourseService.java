package store.seub2hu2.course.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.course.mapper.CourseMapper;
import store.seub2hu2.course.mapper.UserCourseMapper;
import store.seub2hu2.course.vo.*;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.util.ListDto;
import store.seub2hu2.util.Pagination;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class UserCourseService {
    @Autowired
    private UserCourseMapper userCourseMapper;

    @Autowired
    private CourseMapper courseMapper;

    /**
     * 로그인한 사용자의 현재 배지 정보를 가져온다.
     * @param userNo 사용자 번호
     * @return 현재 배지 정보
     */
    public List<UserBadge> getUserBadge(int userNo) {
        // 1. 로그인한 사용자의 현재 배지 정보를 가져온다.
        List<UserBadge> userBadge = userCourseMapper.getUserBadge(userNo);

        // 2. 로그인한 사용자의 배지 정보를 반환한다.
        return userBadge;
    }

    /**
     * 로그인한 사용자의 현재 도전 가능한 단계를 가져온다.
     * @param userNo 사용자 번호
     * @return 현재 도전 가능한 단계
     */
    public UserLevel getUserLevel(int userNo) {
        // 1. 로그인한 사용자의 현재 도전 가능한 단계(난이도)를 가져온다.
        UserLevel userLevel = userCourseMapper.getUserLevel(userNo);

        // 2. 로그인한 사용자의 현재 도전 가능한 단계(난이도)를 반환한다.
        return userLevel;
    }

    /**
     * 로그인한 사용자가 도전 등록한 코스 목록을 가져온다.
     * @param condition 페이지, 사용자 번호
     * @return 도전 등록한 코스 목록, 페이징 처리 정보
     */
    public ListDto<Course> getCoursesToChallenge(Map<String, Object> condition) {
        // 1. 로그인한 사용자가 도전 등록한 코스의 갯수를 가져온다.
        int totalRows = userCourseMapper.getTotalRegisterRows(condition);

        // 2. 페이징 처리 정보를 가져오고, Pagination 객체에 저장한다.
        int page = (Integer) condition.get("page");
        Pagination pagination = new Pagination(page, totalRows, 5);

        // 3. 데이터 검색 범위를 조회해서 Map에 저장한다.
        condition.put("begin", pagination.getBegin());
        condition.put("end", pagination.getEnd());

        // 4. 조회 범위 내에서 로그인한 사용자가 도전 등록한 코스 목록을 모두 가져온다.
        List<Course> courses = userCourseMapper.getCoursesToChallenge(condition);

        // 5. ListDto 객체에 저장하고 반환한다.
        ListDto<Course> dto = new ListDto<>(courses, pagination);
        return dto;
    }

    /**
     * 로그인한 사용자의 코스 도전 등록 여부를 가져온다.
     * @param courseNo 코스 번호
     * @param userNo 사용자 번호
     * @return 코스 도전 등록 여부
     */
    public boolean checkChallenge(int courseNo, int userNo) {
        // 1. 코스 도전 등록 여부를 가져온다.
        ChallengeWhether challengeWhether = userCourseMapper.checkChallenge(courseNo, userNo);

        // 2. 코스 도전 등록 여부를 반환한다.
        return challengeWhether != null;
    }

    /**
     * 로그인한 사용자가 코스 도전 등록 여부를 변환한다.
     * @param courseNo 코스 번호
     * @param userNo 사용자 번호
     */
    public void changeChallenge(int courseNo, int userNo) {
        // 1. 코스 도전 등록 여부를 가져온다.
        ChallengeWhether challengeWhether = userCourseMapper.checkChallenge(courseNo, userNo);

        // 2. 코스 도전 등록 여부를 변환한다.
        if (challengeWhether == null) {
            // 등록하기 버튼을 클릭하면, 코스 도전 등록을 한 것으로 변환한다.
            userCourseMapper.insertChallenger(courseNo, userNo);
        } else {
            // 등록 취소 버튼을 클릭하면, 코스 도전 등록을 취소한 것으로 변환한다.
            userCourseMapper.deleteChallenger(courseNo, userNo);
        }
    }

    /**
     * 로그인한 사용자가 코스를 성공했는지 확인한다.
     * @param userNo 사용자 번호
     * @param courseNo 코스 번호
     * @return 코스 성공 여부
     */
    public boolean checkSuccess(int userNo, int courseNo) {
        // 1. 로그인한 사용자가 코스를 성공했는지 확인한다.
        SuccessWhether successWhether = userCourseMapper.checkSuccess(userNo, courseNo);

        // 2. 코스 성공 여부를 반환한다.
        return successWhether != null;
    }

    /**
     * 사용자가 좋아요를 클릭했는지 확인한다.
     * @param userNo 사용자 번호
     * @param courseNo 코스 번호
     * @return 좋아요 클릭 여부
     */
    public boolean checkLike(int userNo, int courseNo) {
        // 1. 로그인한 사용자가 좋아요를 클릭했는지 확인한다.
        CourseLike courseLike = userCourseMapper.getCourseLike(userNo, courseNo);

        // 2. 좋아요 클릭 여부를 반환한다.
        return courseLike != null;
    }

    /**
     * 좋아요 버튼을 클릭하면, 좋아요 수가 수정되고 사용자 정보가 저장 혹은 삭제된다.
     * @param courseNo 코스 번호
     * @param userNo 사용자 번호
     */
    @PreAuthorize("isAuthenticated()")
    public void addOrReduceLikeCount(int courseNo, int userNo) {
        // 1. 코스의 좋아요 수를 가져온다.
        Course course = courseMapper.getCourseByNo(courseNo);
        CourseLike courseLike = userCourseMapper.getCourseLike(userNo, courseNo);

        // 2. 코스의 좋아요 수를 수정한다.
        if (courseLike == null) {
            // 좋아요 버튼을 처음 클릭하면, 좋아요 수가 증가하고 클릭한 사용자 정보가 저장된다.
            course.setLikeCnt(course.getLikeCnt() + 1);
            userCourseMapper.updateLikeCount(courseNo, course.getLikeCnt());
            userCourseMapper.insertLikeUser(userNo, courseNo);
        } else {
            // 좋아요 버튼을 다시 클릭하면, 좋아요 수가 감소하고 클릭한 사용자 정보가 삭제된다.
            course.setLikeCnt(course.getLikeCnt() - 1);
            userCourseMapper.updateLikeCount(courseNo, course.getLikeCnt());
            userCourseMapper.deleteLikeUser(userNo, courseNo);
        }
    }

    /**
     * 로그인한 사용자의 모든 완주 기록을 가져온다.
     * @param condition 페이지
     * @param loginUser 로그인한 사용자 정보
     * @return 완주 기록 목록, 페이징 처리 정보
     */
    public ListDto<Records> getMyAllRecords(Map<String, Object> condition, @AuthenticationPrincipal LoginUser loginUser) {
        // 1. 사용자 번호를 Map 객체에 저장한다.
        condition.put("userNo", loginUser.getNo());

        // 2. 코스에 해당하는 전체 완주 기록의 갯수를 조회한다.
        int totalRows = userCourseMapper.getTotalRows(condition);

        // 3. 페이징 처리 정보를 가져오고, Pagination 객체에 저장한다.
        int page = (Integer) condition.get("page");
        Pagination pagination = new Pagination(page, totalRows, 10);

        // 4. 데이터 검색 범위를 조회해서 Map 객체에 저장한다.
        condition.put("begin", pagination.getBegin());
        condition.put("end", pagination.getEnd());

        // 5. 조회 범위에 맞는 완주 기록 목록을 가져온다.
        List<Records> records = userCourseMapper.getRecords(condition);

        // 6. ListDto 객체에 화면에 표시할 데이터(완주 기록 목록, 페이징 처리 정보)를 담고, 반환한다.
        ListDto<Records> dto = new ListDto<>(records, pagination);
        return dto;
    }

    /**
     * 코스에 해당하는 모든 완주 기록을 시간이 낮은 순으로 가져온다.
     * @param condition 페이지, 코스 번호
     * @return 완주 기록 목록
     */
    public ListDto<Records> getAllRecords(Map<String, Object> condition) { //
        // 1. 코스에 해당하는 전체 완주 기록의 갯수를 조회한다.
        int totalRows = userCourseMapper.getTotalRows(condition);

        // 2. 페이징 처리 정보를 가져오고, Pagination 객체에 저장한다.
        int page = (Integer) condition.get("page");
        Pagination pagination = new Pagination(page, totalRows, 10);

        // 3. 데이터 검색 범위를 조회해서 Map 객체에 저장한다.
        condition.put("begin", pagination.getBegin());
        condition.put("end", pagination.getEnd());

        // 4. 조회 범위에 맞는 완주 기록 목록을 가져온다.
        List<Records> records = userCourseMapper.getRecords(condition);

        // 5. ListDto 객체에 화면에 표시할 데이터(완주 기록 목록, 페이징 처리 정보)를 담고, 반환한다.
        ListDto<Records> dto = new ListDto<>(records, pagination);
        return dto;
    }

    public ListDto<Records> getMyRecords(Map<String, Object> condition) {
        // 코스에 해당하는 나의 전체 완주 기록의 갯수를 가져온다.
        int totalRows = userCourseMapper.getTotalRows(condition);

        // 페이징 처리 정보를 가져오고, Pagination 객체에 저장한다.
        int page = (Integer) condition.get("page");
        Pagination pagination = new Pagination(page, totalRows, 5);

        // 데이터 검색 범위를 조회해서 Map 객체에 저장한다.
        condition.put("myBegin", pagination.getBegin());
        condition.put("myEnd", pagination.getEnd());

        // 조회 범위 내에서 나의 완주 기록 목록만 가져온다.
        List<Records> records = userCourseMapper.getMyRecords(condition);

        // ListDto 객체에 화면에 표시할 데이터(완주 기록 목록, 페이징 처리 정보)를 담고, 반환한다.
        ListDto<Records> dto = new ListDto<>(records, pagination);
        return dto;
    }
}
