package store.seub2hu2.course.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.course.service.UserCourseService;
import store.seub2hu2.security.dto.RestResponseDto;

@RestController
@RequestMapping("/course")
public class RestCourseController {
    @Autowired
    private UserCourseService userCourseService;

    @GetMapping("/check-success/{userNo}/{courseNo}")
    public ResponseEntity<RestResponseDto<String>> checkSuccess(@PathVariable("userNo") int userNo
                                                                , @PathVariable("courseNo") int courseNo) {
        // 1. 로그인한 사용자가 코스를 성공했는지 확인한다.
        boolean isSuccess = userCourseService.checkSuccess(userNo, courseNo);
        String data = isSuccess ? "success" : "fail";

        // 2. 응답 데이터를 반환한다.
        return ResponseEntity.ok(RestResponseDto.success(data));
    }
}
