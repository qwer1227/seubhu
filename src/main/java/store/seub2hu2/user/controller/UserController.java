package store.seub2hu2.user.controller;

import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.user.dto.UserJoinForm;
import store.seub2hu2.user.exception.AlreadyUsedIdException;
import store.seub2hu2.user.mapper.UserMapper;
import store.seub2hu2.user.service.UserService;
import store.seub2hu2.user.vo.User;

import java.io.IOException;
import java.util.Random;

// 인증이 안된 사용자들이 출입할 수 있는 경로를 /auth/**허용
// 그냥 주소가 / 이면 index.jsp 허용
// static 이하에 있는 /js/**, /css/**, /image/** 허용

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private JavaMailSender mailSender;

    // 회원가입 폼 페이지
    @GetMapping("/join")
    public String joinForm(Model model) {
        model.addAttribute("joinForm", new UserJoinForm());
        return "user/join-form";
    }

    // 회원가입 요청 처리
    @PostMapping("/join")
    public String join(@Valid @ModelAttribute("joinForm") UserJoinForm form, BindingResult errors) {

        // 유효성 검증을 통과하지 못하면 join-form.jsp로 내부이동시킨다.
        if (errors.hasErrors()) {
            return "user/join-form";
        }

        // 추가적인 유효성 검증 실시하기
        if (!form.getPassword().equals(form.getPasswordConfirm())) {
            errors.rejectValue("passwordConfirm", null, "비밀번호가 일치하지 않습니다.");
            return "user/join-form";
        }

        try {
            userService.insertUser(form);
        } catch (AlreadyUsedIdException ex) {
            errors.rejectValue("email", null, "이미 사용중인 이메일입니다.");
            return "user/join-form";
        }

        return "redirect:/main";
    }

    // 로그인 폼 페이지
    @GetMapping("/login")

    public String loginform() {
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


    // 로그아웃
//@GetMapping("/logout")
//public String logout() {
// Spring Security의 자동 로그아웃 처리
//    return "redirect:/main"; // 로그아웃 후 메인 페이지로 리다이렉트
//}

    // 아이디 찾기
    @GetMapping("/forgot-id")
    public String forgotIdForm() {
        return "user/forgot-id";
    }

    @PostMapping("/forgot-id")
    public ResponseEntity<String> findIdByEmail(@RequestParam String email) {
        String userId = userService.findIdByEmail(email);
        if (userId != null) {
            return ResponseEntity.ok("가입된 아이디는: " + userId + "입니다.");
        }
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("해당 이메일로 가입된 아이디가 없습니다.");
    }

    // 비밀번호 찾기
    @GetMapping("/forgot-password")
    public String forgotPasswordForm() {
        return "user/forgot-password";
    }

    @PostMapping("/forgot-password")
    @ResponseBody
    public String findByIdAndEmail(HttpServletRequest request, @RequestParam("id") String id, @RequestParam("email") String email) {

        Random r = new Random();
        int checkNum = r.nextInt(888888) + 111111;

        String title = "습습후후 아이디/비밀번호 찾기 인증 이메일 입니다.";
        String from = "@gmail.com";
        String to = email;
        String content =
                System.getProperty("line.separator") +
                        System.getProperty("line.separator") +
                        "습습후후 임시 비밀번호입니다."
                        + System.getProperty("line.separator") +
                        System.getProperty("line.separator")
                        + checkNum +
                        System.getProperty("line.separator");

        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

            messageHelper.setFrom(from);
            messageHelper.setTo(to);
            messageHelper.setSubject(title);
            messageHelper.setText(content);

            mailSender.send(message);

        } catch (Exception e) {
            System.out.println(e);
        }
        return checkNum + "";
    }


    }









