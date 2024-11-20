package store.seub2hu2.home;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class HomeController {


    // 메인 홈 페이지
    @GetMapping("/main")
    public String main() {
        log.info("main() 메소드 실행됨");
        return "main";
    }
}
