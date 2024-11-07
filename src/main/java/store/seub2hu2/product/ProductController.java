package store.seub2hu2.product;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/product")
public class ProductController {

    // 임시 홈 페이지 이동
    @GetMapping("/")
    public String home() {
        return "home";
    }
    
    // 임시 상품 전체 페이지 이동
    @GetMapping("/list")
    public String list() {
        return "product/list";
    }

    // 임시 상품 상세 페이지 이동
    @GetMapping("/detail")
    public String detail() {

        return "product/detail";
    }
}
