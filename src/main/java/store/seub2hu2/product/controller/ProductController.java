package store.seub2hu2.product.controller;

import lombok.extern.slf4j.Slf4j;
import okhttp3.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import store.seub2hu2.product.dto.*;
import store.seub2hu2.product.mapper.ProdReviewMapper;
import store.seub2hu2.product.service.ProductService;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.user.service.UserService;
import store.seub2hu2.user.vo.User;
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

    @Autowired
    private UserService userService;

    @Autowired
    private ProdReviewMapper prodReviewMapper;


    //  상품 전체 페이지 이동
    @GetMapping("/list")
    public String list(@RequestParam(name= "topNo") int topNo,
                       @RequestParam(name = "catNo", required = false, defaultValue = "0") int catNo,
                       @RequestParam(name = "page", required = false, defaultValue = "1") int page,
                       @RequestParam(name = "rows", required = false, defaultValue = "6") int rows,
                       @RequestParam(name = "sort" , required = false, defaultValue = "date") String sort,
                       @RequestParam(name = "opt", required = false) String opt,
                       @RequestParam(name = "value", required = false) String value,
                       Model model) {

        Map<String, Object> condition = new HashMap<>();
        condition.put("topNo", topNo);
        if(catNo != 0) {
            condition.put("catNo", catNo);
        }

        condition.put("page", page);
        condition.put("rows", rows);
        condition.put("sort", sort);
        if(StringUtils.hasText(opt) && StringUtils.hasText(value)) {
            condition.put("opt", opt);
            condition.put("value", value);
        }

        ListDto<ProdListDto> dto = productService.getProducts(condition);
        model.addAttribute("topNo", topNo);
        model.addAttribute("catNo", catNo);
        model.addAttribute("products", dto.getData());
        model.addAttribute("paging", dto.getPaging());

        return "product/list";
    }

    // 상품 상세 페이지 이동
    @GetMapping("/detail")
    public String detail(@RequestParam("no") int no,
                         @RequestParam("colorNo") int colorNo,
                         @AuthenticationPrincipal LoginUser loginUser,
                         Model model) {


        User user = userService.findbyUserId(loginUser.getId());

        model.addAttribute("user", user);

        ProdDetailDto prodDetailDto = productService.getProductByNo(no);
        model.addAttribute("prodDetailDto", prodDetailDto);

        List<ColorProdImgDto> colorProdImgDto = productService.getProdImgByColorNo(no);
        model.addAttribute("colorProdImgDto", colorProdImgDto);

        SizeAmountDto sizeAmountDto = productService.getSizeAmountByColorNo(colorNo);
        model.addAttribute("sizeAmountDto", sizeAmountDto);

        ProdImagesDto prodImagesDto = productService.getProdImagesByColorNo(colorNo);
        model.addAttribute("prodImagesDto", prodImagesDto);


        return "product/detail";
    }

    @GetMapping("/hit")
    public String hit(@RequestParam("no") int prodNo, @RequestParam("colorNo") int colorNo){
        productService.updateProdDetailViewCnt(prodNo, colorNo);
        return "redirect:detail?no=" + prodNo +"&colorNo="+colorNo;
    }


    @PostMapping("/addProdReview")
    public ResponseEntity<?> addReview(ProdReviewForm form) {
        System.out.println("------------- 리뷰등록");
        System.out.println(form);

        return ResponseEntity.ok(null);
    }
}
