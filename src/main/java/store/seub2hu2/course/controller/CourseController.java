package store.seub2hu2.course.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import store.seub2hu2.course.service.CourseService;
import store.seub2hu2.course.vo.Course;
import store.seub2hu2.util.ListDto;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/course")
public class CourseController {
    @Autowired
    private CourseService courseService;

    @GetMapping("/list")
    public String list(){
//        // 1. 페이징 처리 정보를 Map 객체에 담는다.
//        Map<String, Object> condition = new HashMap<>();
//        condition.put("page", page);
//
//        // 2. 검색에 해당하는 코스 목록을 가져온다.
//        ListDto<Course> dto = courseService.getCourses(condition);


        // 3. Model 객체에 코스 목록을 저장해서 보낸다.

        // 4. 뷰 이름을 반환한다.
        return "course/list";
    }
}
