package store.seub2hu2.product.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import store.seub2hu2.product.dto.ProdListDto;
import store.seub2hu2.product.enums.ProductCategories;
import store.seub2hu2.product.service.ProductService;
import store.seub2hu2.util.ListDto;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
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


    //  상품 전체 페이지 이동
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
