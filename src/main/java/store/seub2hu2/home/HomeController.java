package store.seub2hu2.home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import store.seub2hu2.user.dto.UserJoinForm;
import store.seub2hu2.user.exception.AlreadyUsedEmailException;
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
            // 업무로직 메소드를 호출한다.
            userService.insertUser(form);

        } catch (AlreadyUsedEmailException ex) {
            // 이메일 중복으로 폼 입력값이 유효하지 않는 경우
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

