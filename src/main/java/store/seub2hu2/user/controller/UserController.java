package store.seub2hu2.user.controller;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
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
    public String login(@RequestParam String id, @RequestParam String password, HttpSession session, Model model) {
        try {
            // 서비스에서 로그인 처리
            LoginUser loginUser = userService.authenticateUser(id, password);

            // 로그인 성공 시 세션에 사용자 정보 저장
            session.setAttribute("loginUser", loginUser);

            // 로그인 성공 후 홈 페이지로 리다이렉트
            return "redirect:/home";
        } catch (AuthenticationException e) {
            // 인증 실패 시 오류 메시지 추가
            model.addAttribute("errorMessage", "아이디 또는 비밀번호가 잘못되었습니다.");
            return "user/login-form";  // 로그인 폼으로 돌아감
        }
    }

    // 로그아웃 처리
    @GetMapping("/logout")
    public String logout() {  // 세션 무효화
        return "redirect:/main";  // 로그아웃 후 메인 페이지로 리다이렉트
    }

    @GetMapping("/search")
    public ResponseEntity<List<User>> searchUsers(@RequestParam("nickname") String nickname) {
        List<User> users = userService.searchUsersByNickname(nickname);
        return ResponseEntity.ok(users);
    }
}
