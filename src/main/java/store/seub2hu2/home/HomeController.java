package store.seub2hu2.home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import lombok.extern.slf4j.Slf4j;
import store.seub2hu2.user.mapper.UserMapper;

@Controller
@Slf4j
public class HomeController {

    @Autowired
    UserMapper userMapper;


    // 메인 홈 페이지
    @GetMapping("/home")
    public String home() {

        return "home";
    }
}
