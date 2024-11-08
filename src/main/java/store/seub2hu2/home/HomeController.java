package store.seub2hu2.home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import store.seub2hu2.user.dto.UserRegisterForm;
import store.seub2hu2.user.service.UserService;

import jakarta.validation.Valid;

@Controller
public class HomeController {

    @Autowired
    private UserService userService;

    @GetMapping("/home")
    public String home() {
        return "home";
    }

    @GetMapping("/login")
    public String loginform() {
        return "login-form";
    }

    @GetMapping("/register")
    public String registerform(Model model) {
        model.addAttribute("registerForm", new UserRegisterForm());

        return "register-form";
    }

    @PostMapping("/register")
    public String register(
            @Valid @ModelAttribute("registerForm") UserRegisterForm form,
            BindingResult errors) {

        // 유효성 검증을 통과하지 못하면 register-form.jsp로 내부이동시킨다.
        if (errors.hasErrors()) {
            return "register-form";
        }

        // 추가적인 유효성 검증 실시하기
        if (!form.getPassword().equals(form.getPasswordConfirm())) {
            errors.rejectValue("passwordConfirm", null, "비밀번호가 일치하지 않습니다.");
            return "register-form";
        }



        return "redirect:/home";
    }

}











