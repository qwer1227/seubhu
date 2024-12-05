package store.seub2hu2.user.controller;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.user.dto.UserJoinForm;
import store.seub2hu2.user.service.UserService;
import store.seub2hu2.user.vo.User;

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
        // 유효성 검증 실패 시 다시 가입 폼으로
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

        // 회원가입 처리
        userService.insertUser(form);

        // 가입 성공 시 success 페이지로 리다이렉트
        return "user/join-success-form";
    }



    // 로그인 폼 페이지
    @GetMapping("/login")
    public String loginForm() {
        return "user/login-form";  // 로그인 폼 뷰 반환
    }

    @PostMapping("/login")
    public String login(@RequestParam String id, @RequestParam String password, HttpSession session) {
        // 로그인 처리 코드 (예: 사용자 인증)
        User user = userService.login(id, password); // 예시로 로그인한 사용자 객체

        if (user != null) {
            // 로그인 성공 시 LoginUser 객체를 세션에 저장
            LoginUser loginUser = new LoginUser(user);
            session.setAttribute("loginUser", loginUser);
            return "redirect:/home";  // 로그인 성공 후 이동할 페이지
        } else {
            return "login";  // 로그인 실패 시 로그인 페이지로 돌아감
        }
    }

    // 로그아웃 처리
    @GetMapping("/logout")
    public String logout() {  // 세션 무효화
        return "redirect:/main";  // 로그아웃 후 메인 페이지로 리다이렉트
    }
}
