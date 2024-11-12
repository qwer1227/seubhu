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
    public String list(@RequestParam(name = "page", required = false, defaultValue = "1") int page,
                       @RequestParam(name = "rows", required = false, defaultValue = "5") int rows,
                       @RequestParam(name = "sort", required = false, defaultValue = "date") String sort,
                       @RequestParam(name = "opt", required = false) String opt,
                       @RequestParam(name = "value", required = false) String value,
                       Model model) {

        // 조건들을 맵에 담기.
        Map<String, Object> condition = new HashMap<>();
        condition.put("page", page);
        condition.put("rows", rows);
        condition.put("sort", sort);
        if(StringUtils.hasText(value)) {
            condition.put("opt", opt);
            condition.put("value", value);
        }

        // 관련 데이터와 페이징 데이터를 담는다.
        ListDto<ProdListDto> dto = productService.getProducts(condition);
        model.addAttribute("products", dto.getData());

        model.addAttribute("paging", dto.getPagination());


        return "product/list";
    }

    // 임시 상품 상세 페이지 이동
    @GetMapping("/detail")
    public String detail() {

        return "product/detail";
    }
}
