package store.seub2hu2.user.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.user.dto.UserJoinForm;
import store.seub2hu2.user.mapper.UserMapper;
import store.seub2hu2.user.service.UserEmailService;
import store.seub2hu2.user.service.UserService;

import static java.awt.SystemColor.text;

// 인증이 안된 사용자들이 출입할 수 있는 경로를 /auth/**허용
// 그냥 주소가 / 이면 index.jsp 허용
// static 이하에 있는 /js/**, /css/**, /image/** 허용

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserEmailService userEmailService;

    // 회원가입 폼 페이지
    @GetMapping("/join")
    public String joinForm(Model model) {
        model.addAttribute("joinForm", new UserJoinForm());
        return "user/join-form";
    }

    @PostMapping("/join")
    public String join(@Valid @ModelAttribute("joinForm") UserJoinForm form, BindingResult errors) {

        // 유효성 검증을 통과하지 못하면 join-form.jsp로 내부이동시킨다.
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
        return "user/login-form";
    }

    @PostMapping("/login")
    public String login(@CookieValue(name = "key", required = false) String cookieId, Model model) {
        if (cookieId != null) {
            model.addAttribute("cookieId", cookieId);
        }
        // 로그인 처리
        return "user/login-form";
    }

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
        // 사용자 검증
        if (!userService.isValidUser(id, email)) {
            model.addAttribute("error", "아이디와 이메일이 일치하지 않습니다.");
            return "user/find-password"; // 폼 페이지로 다시 이동
        }

        // 임시 비밀번호 생성
        String temporaryPassword = userService.generateTemporaryPassword();

        // 비밀번호 업데이트
        userService.updateUserPassword(id, temporaryPassword);

        // 이메일 발송
        String subject = "임시 비밀번호 발급 안내";
        String text = "임시 비밀번호: " + temporaryPassword + "\n" +
                "로그인 후 반드시 비밀번호를 변경해 주세요.";
        try {
            UserEmailService userEmailService;
            model.addAttribute("message", "임시 비밀번호가 이메일로 발송되었습니다.");
        } catch (IllegalStateException e) {
            model.addAttribute("error", "이메일 발송에 실패했습니다. 잠시 후 다시 시도해주세요.");
            return "user/find-password";
        }

        // 성공 시 로그인 페이지로 리다이렉트
        return "redirect:/login";
    }
    }













