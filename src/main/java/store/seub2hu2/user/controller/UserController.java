package store.seub2hu2.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.security.CustomUserDetails;
import store.seub2hu2.user.vo.User;
import store.seub2hu2.user.dto.UserUpdateRequest;
import store.seub2hu2.user.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    // 회원 가입 화면 표시
    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("user", new User()); // 'user' 객체를 모델에 추가
        return "register-form"; // 회원 가입 JSP 페이지로 이동
    }

    // 회원 가입 처리
    @PostMapping("/register")
    public String registerUser(@ModelAttribute("user") User user) {
        try {
            userService.save(user); // 회원가입 처리
            return "redirect:/success"; // 성공 시 리디렉션
        } catch (Exception e) {
            return "redirect:/register?error=" + e.getMessage(); // 실패 시 에러 메시지와 함께 다시 리디렉션
        }
    }

    // 사용자 정보 업데이트 엔드포인트
    @PutMapping("/update")
    public ResponseEntity<?> updateUser(
            @AuthenticationPrincipal CustomUserDetails userDetails, // JWT에서 인증된 사용자 정보
            @RequestBody UserUpdateRequest request) {

        String userId = userDetails.getId(); // JWT에서 가져온 사용자 ID

        try {
            // 사용자 정보 업데이트 서비스 호출
            userService.updateUserInfo(userId, request);

            // 업데이트 성공 시 200 OK 응답
            return ResponseEntity.ok("User information updated successfully");

        } catch (Exception e) {
            // 예외 발생 시 400 Bad Request 응답
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Failed to update user information: " + e.getMessage());
        }
    }
/*
    // 이메일 중복 체크 AJAX 요청 처리
    @RequestMapping("/ajax/check-email")
    @ResponseBody
    public Map<String, String> checkEmail(@RequestParam String email) {
        Map<String, String> response = new HashMap<>();
        boolean exists = userService.checkEmailExists(email);
        response.put("data", exists ? "exists" : "none");
        return response;
    }

    // 닉네임 중복 체크 AJAX 요청 처리
    @RequestMapping("/ajax/check-nickname")
    @ResponseBody
    public Map<String, Boolean> checkNickname(@RequestParam String nickname) {
        Map<String, Boolean> response = new HashMap<>();
        boolean exists = userService.checkNicknameExists(nickname);
        response.put("exists", exists);
        return response;
    }
 */
}
