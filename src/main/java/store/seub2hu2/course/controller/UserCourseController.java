package store.seub2hu2.course.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import store.seub2hu2.course.service.UserCourseService;
import store.seub2hu2.security.dto.RestResponseDto;

@RestController
@RequestMapping("/course")
public class UserCourseController {
    @Autowired
    private UserCourseService userCourseService;

    @GetMapping("/check-success/{no}")
    public ResponseEntity<RestResponseDto<String>> checkSuccess(@PathVariable("no") int userNo) {
        // 1. 로그인한 사용자가 코스를 성공했는지 확인한다.
        boolean isSuccess = userCourseService.checkSuccess(userNo);
        String data = isSuccess ? "success" : "fail";

        // 2. 응답 데이터를 반환한다.
        return ResponseEntity.ok(RestResponseDto.success(data));
    }
}
