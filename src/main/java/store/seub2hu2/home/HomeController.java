package store.seub2hu2.home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import lombok.extern.slf4j.Slf4j;
import store.seub2hu2.product.dto.ProdListDto;
import store.seub2hu2.user.mapper.UserMapper;

import java.util.List;

@Controller
@Slf4j
public class HomeController {

    @Autowired
    private HomeService homeService;


    // 메인 홈 페이지
    @GetMapping("/home")
    public String home(Model model) {
        // 주간 베스트 상품 - 별점 순
        List<ProdListDto> bestByRating = homeService.getWeeklyBestProductsByRating();
        // 주간 베스트 상품 - 조회수 순 (러닝화 기준)
        List<ProdListDto> bestByViewCount = homeService.getWeeklyBestProductsByViewCount();

        // 모델에 데이터 추가
        model.addAttribute("bestByRating", bestByRating);
        model.addAttribute("bestByViewCount", bestByViewCount);

        return "home"; // 해당 JSP 페이지로 전달
    }

}
