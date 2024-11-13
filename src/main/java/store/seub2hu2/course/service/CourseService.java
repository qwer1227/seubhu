package store.seub2hu2.course.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.course.mapper.CourseMapper;
import store.seub2hu2.course.vo.Course;
import store.seub2hu2.util.ListDto;
import store.seub2hu2.util.Pagination;

import java.util.List;
import java.util.Map;

@Service
@Transactional
public class CourseService {
    @Autowired
    private CourseMapper courseMapper;

    public ListDto<Course> getAllCourses(Map<String, Object> condition) {
        // 1. 전체 데이터 갯수를 조회한다.
        int totalRows = courseMapper.getTotalRows(condition);

        // 2. 페이징 처리 정보를 가져온다.
        int page = (Integer) condition.get("page");
        Pagination pagination = new Pagination(page, totalRows);

        // 3. 데이터 검색 범위를 조회해서 Map에 저장한다.
        condition.put("begin", pagination.getBegin());
        condition.put("end", pagination.getEnd());

        // 4. 조회범위에 맞는 데이터를 조회한다.
        List<Course> courses = courseMapper.getCourses(condition);

        // 5. ListDto 객체에 화면에 표시할 데이터(코스 목록, 페이징처리정보)를 담고, 반환한다.
        ListDto<Course> dto = new ListDto<>(courses, pagination);
        return dto;
    }
}
