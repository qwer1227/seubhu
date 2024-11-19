package store.seub2hu2.home;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import store.seub2hu2.user.dto.UserJoinForm;
import store.seub2hu2.user.exception.AlreadyUsedIdException;
import store.seub2hu2.user.service.UserService;
import store.seub2hu2.user.vo.User;

import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class HomeController {

    @Autowired
    private UserService userService;

    // 메인 홈 페이지
    @GetMapping("/main")
    public String main() {
        log.info("main() 메소드 실행됨");
        return "main";
    }

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
}

// 로그아웃
//@GetMapping("/logout")
//public String logout() {
    // Spring Security의 자동 로그아웃 처리
//    return "redirect:/main"; // 로그아웃 후 메인 페이지로 리다이렉트
//}


