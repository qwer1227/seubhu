package store.seub2hu2.user.controller;

import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.user.dto.UserJoinForm;
import store.seub2hu2.user.service.UserService;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    // 회원가입 폼 페이지
    @GetMapping("/join")
    public String joinForm(Model model) {
        model.addAttribute("joinForm", new UserJoinForm());
        return "user/join-form";
    }

    // 회원가입 처리
    @PostMapping("/join")
    public String join(@Valid @ModelAttribute("joinForm") UserJoinForm form, BindingResult errors) {
        // 유효성 검증을 통과하지 못하면 join-form.jsp로 이동
        if (errors.hasErrors()) {
            return "user/join-form";
        }

        // 비밀번호 확인
        if (!form.getPassword().equals(form.getPasswordConfirm())) {
            errors.rejectValue("passwordConfirm", null, "비밀번호가 일치하지 않습니다.");
            return "user/join-form";
        }

        // 아이디 중복 확인
        if (userService.isIdExists(form.getId())) {
            errors.rejectValue("id", null, "이미 사용중인 아이디입니다.");
            return "user/join-form";
        }

        // 닉네임 중복 확인
        if (userService.isNicknameExists(form.getNickname())) {
            errors.rejectValue("nickname", null, "이미 사용중인 닉네임입니다.");
            return "user/join-form";
        }

        // 이메일 중복 확인
        if (userService.isEmailExists(form.getEmail())) {
            errors.rejectValue("email", null, "이미 사용중인 이메일입니다.");
            return "user/join-form";
        }

        // 중복 검사를 모두 통과한 후 회원가입 처리
        userService.insertUser(form);


        return "user/join-success-form";
    }

    // 로그인 폼 페이지
    @GetMapping("/login")
    public String loginForm() {
        return "user/login-form";  // 로그인 폼 뷰 반환
    }

    // 로그아웃 처리
    @GetMapping("/logout")
    public String logout() {  // 세션 무효화
        return "redirect:/main";  // 로그아웃 후 메인 페이지로 리다이렉트
    }
}
