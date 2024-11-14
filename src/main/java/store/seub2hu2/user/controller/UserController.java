package store.seub2hu2.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.user.dto.UserJoinForm;
import store.seub2hu2.user.service.UserService;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/user")
public class UserController {

    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/auth/kakao/callback")
    public String kakaoCallback(String code) { // Data 리턴 해 주는 컨트롤러 함수
        return "카카오 인증 완료; 코드값: " + code;
    }

    @GetMapping("/auth/naver/callback")
    public String naverCallback(String code) { // Data 리턴 해 주는 컨트롤러 함수
        return "네이버 인증 완료; 코드값: " + code;
    }

    @GetMapping("/auth/google/callback")
    public String googleCallback(String code) { // Data 리턴 해 주는 컨트롤러 함수
        return "구글 인증 완료; 코드값: " + code;
    }
}
