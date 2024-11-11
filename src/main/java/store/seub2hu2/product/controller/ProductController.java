package store.seub2hu2.product.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import store.seub2hu2.product.dto.ProdListDto;
import store.seub2hu2.product.service.ProductService;
import store.seub2hu2.product.vo.Product;

import java.util.List;

@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private ProductService productService;

    // 임시 홈 페이지 이동
    @GetMapping("/")
    public String home() {
        return "home";
    }
    
    // 임시 상품 전체 페이지 이동
    @GetMapping("/list")
    public String list(Model model) {

        List<ProdListDto> products = productService.getProducts();
        model.addAttribute("products", products);
        return "product/list";
    }

    // 임시 상품 상세 페이지 이동
    @GetMapping("/detail")
    public String detail() {

        return "product/detail";
    }
}
