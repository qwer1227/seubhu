package store.seub2hu2.course.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.course.mapper.CourseMapper;
import store.seub2hu2.course.mapper.UserCourseMapper;
import store.seub2hu2.course.vo.Course;
import store.seub2hu2.course.vo.CourseLike;
import store.seub2hu2.course.vo.CourseWhether;
import store.seub2hu2.course.vo.Records;
import store.seub2hu2.util.ListDto;
import store.seub2hu2.util.Pagination;

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
     * 로그인한 사용자가 코스를 성공했는지 확인한다.
     * @param userNo 사용자 번호
     * @param courseNo 코스 번호
     * @return 코스 성공 여부
     */
    public boolean checkSuccess(int userNo, int courseNo) {
        // 1. 로그인한 사용자가 코스를 성공했는지 확인한다.
        CourseWhether courseWhether = userCourseMapper.checkSuccess(userNo, courseNo);
        System.out.println("코스 성공 여부:" + courseWhether);

        // 2. 코스 성공 여부를 반환한다.
        return courseWhether != null;
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
        System.out.println("좋아요 클릭 여부:" + courseLike);

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
     * 코스에 해당하는 모든 사용자의 완주 기록을 시간이 낮은 순으로 가져온다.
     * @param condition 페이지, 코스 번호
     * @return 완주 기록 목록
     */
    public ListDto<Records> getAllRecords(Map<String, Object> condition) {
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

    /**
     * 코스에 해당하는 로그인한 사용자의 완주 기록을 시간이 낮은 순으로 가져온다.
     * @param condition 코스 번호, 사용자 번호
     * @return 완주 기록 목록
     */
    public List<Records> getMyRecords(Map<String, Object> condition) {
        // 1. 나의 완주 기록 목록을 가져온다.
        List<Records> records = userCourseMapper.getRecords(condition);

        // 2. 나의 완주 기록 목록을 반환한다.
        return records;
    }
}
