package store.seub2hu2.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import store.seub2hu2.user.service.EmailService;
import store.seub2hu2.user.service.UserService;

public class FindController {

    @Autowired
    private UserService userService;

    // 아이디 찾기 폼
    @GetMapping("/find-id")
    public String findIdForm() {
        return "user/find-id"; // 아이디 찾기 페이지로 이동
    }

    // 이메일로 아이디 찾기 처리
    @PostMapping("/find-id")

    // 비밀번호 찾기 폼
    @GetMapping("/find-password")
    public String findPasswordForm() {
        return "user/find-password";
    }

    // 비밀번호 찾기 요청 처리
    @PostMapping("/find-password")
    public String findPassword(@RequestParam String id, @RequestParam String email, Model model) {


        // 임시 비밀번호 생성
        String temporaryPassword = userService.generateTemporaryPassword();


        // 이메일 발송
        String subject = "임시 비밀번호 발급 안내";
        String text = "임시 비밀번호: " + temporaryPassword + "\n" +
                "로그인 후 반드시 비밀번호를 변경해 주세요.";
        try {
            EmailService emailService;
            model.addAttribute("message", "임시 비밀번호가 이메일로 발송되었습니다.");
        } catch (IllegalStateException e) {
            model.addAttribute("error", "이메일 발송에 실패했습니다. 잠시 후 다시 시도해주세요.");
            return "user/find-password";
        }

        // 성공 시 로그인 페이지로 리다이렉트
        return "redirect:/login";
    }
}
