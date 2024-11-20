package store.seub2hu2.user.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.user.service.UserEmailService;

@RestController
@RequestMapping("/auth") // 공통 경로 지정
public class AuthController {

    private final UserEmailService userEmailService;

    public AuthController(UserEmailService userEmailService) {
        this.userEmailService = userEmailService;
    }

    // 이메일 인증번호 발송
    @PostMapping("/send-email")
    @ResponseBody
    public ResponseEntity<String> sendEmail(@RequestParam String email) {
        String authCode = userEmailService.generateAuthCode();
        userEmailService.sendEmail(email, "인증번호 발송", "인증번호: " + authCode);
        return ResponseEntity.ok(authCode);
    }

    // 인증번호 검증
    @PostMapping("/verify-email")
    @ResponseBody
    public ResponseEntity<Boolean> verifyEmail(@RequestParam String inputCode, @RequestParam String sentCode) {
        return ResponseEntity.ok(inputCode.equals(sentCode));
    }
}
