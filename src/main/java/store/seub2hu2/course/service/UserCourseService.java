package store.seub2hu2.course.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.course.mapper.UserCourseMapper;
import store.seub2hu2.course.vo.CourseWhether;

@Service
@Transactional
public class UserCourseService {
    @Autowired
    private UserCourseMapper userCourseMapper;

    /**
     * 로그인한 사용자가 코스를 성공했는지 확인한다.
     * @param userNo 사용자 번호
     * @return 코스 성공 여부
     */
    public boolean checkSuccess(int userNo) {
        // 1. 로그인한 사용자가 코스를 성공했는지 확인한다.
        CourseWhether user = userCourseMapper.checkSuccess(userNo);

        // 2. 사실 여부를 반환한다.
        return user != null;
    }
}
