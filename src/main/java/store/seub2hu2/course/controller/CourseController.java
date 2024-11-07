package store.seub2hu2.course.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/course")
public class CourseController {

    @GetMapping("/list")
    public String list(){ // 페이징 처리 정보를 브라우저에 보낸다.
        // 1. 페이징 처리 정보를 Map 객체에 담는다.


        // 2. 검색에 해당하는 코스 목록을 가져온다.

        // 3. Model 객체에 코스 목록을 저장해서 보낸다.

        // 4. 뷰 이름을 반환한다.
        return "course/list";
    }
}
