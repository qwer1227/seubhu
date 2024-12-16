package store.seub2hu2.user.controller;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.security.user.CustomOAuth2User;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.user.dto.UserJoinForm;
import store.seub2hu2.user.service.UserService;
import store.seub2hu2.user.vo.User;

import java.util.List;

@Controller
public class UserController {

    private final AuthenticationManager authenticationManager;

    @Autowired
    public UserController(AuthenticationManager authenticationManager) {
        this.authenticationManager = authenticationManager;
    }

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

        // 회원가입 처리
        userService.insertUser(form);

        // 가입 성공 시 success 페이지로 리다이렉트
        return "user/join-success-form";
    }

    // 회원가입 폼 화면 요청
    @GetMapping("/socialJoin")
    public String socialJoinForm(@AuthenticationPrincipal LoginUser loginUser, Model model) {
        // 소셜 로그인 제공자 정보와 사용자 ID를 폼에 설정
        User user = userService.findbyUserId(loginUser.getId());
        UserJoinForm userJoinForm = new UserJoinForm();
        userJoinForm.setId(user.getId());
        userJoinForm.setName(user.getName());
        userJoinForm.setEmail(user.getEmail());

        model.addAttribute("joinForm", userJoinForm);
        model.addAttribute("provider", user.getProvider());  // 소셜 로그인 제공자 정보 전달
        return "user/social-join-form";  // social-join-form.jsp
    }

    // 회원가입 폼 제출 처리
    @PostMapping("/socialJoin")
    public String socialJoin(@Valid @ModelAttribute("joinForm") UserJoinForm form,
                             BindingResult errors,
                             @RequestParam String provider) {
        // 유효성 검증 실패 시 다시 가입 폼으로
        if (errors.hasErrors()) {
            return "user/social-join-form";
        }

        // 비밀번호 확인
        if (!form.getPassword().equals(form.getPasswordConfirm())) {
            errors.rejectValue("passwordConfirm", null, "비밀번호가 일치하지 않습니다.");
            return "user/social-join-form";
        }

        // 소셜 로그인 처리: 비밀번호는 필요 없지만, 제공된 정보를 바탕으로 사용자 생성
        userService.insertSocialUser(form, provider);

        // 가입 성공 시 success 페이지로 리다이렉트
        return "redirect:/user/join-success-form";
    }


    // 로그인 폼 페이지
    @GetMapping("/login")
    public String loginForm() {
        return "user/login-form";  // 로그인 폼 뷰 반환
    }


    @PostMapping("/login")
    public String login(@RequestParam String id, @RequestParam String password, HttpSession session, Model model) {
        try {
            // 인증 시도
            LoginUser loginUser = userService.authenticateUser(id, password);

            // 로그인 성공 시 세션에 사용자 정보 저장
            session.setAttribute("loginUser", loginUser);

            // 홈 페이지로 리다이렉트
            return "redirect:/home";
        } catch (BadCredentialsException e) {
            // 예외 메시지를 모델에 추가하여 로그인 폼으로 리다이렉트
            model.addAttribute("errorMessage", e.getMessage());
            return "user/login-form";  // 로그인 폼으로 돌아가기
        }
    }


    // 로그아웃 처리
    @GetMapping("/logout")
    public String logout() {  // 세션 무효화
        return "redirect:/main";  // 로그아웃 후 메인 페이지로 리다이렉트
    }
}
