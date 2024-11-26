package store.seub2hu2.mypage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.cart.dto.CartRegisterForm;
import store.seub2hu2.mypage.service.CartService;
import store.seub2hu2.mypage.service.PostService;
import store.seub2hu2.mypage.vo.Post;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.user.vo.User;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/mypage")
public class MyPageController {

    @Autowired
    PostService postService;

    @Autowired
    CartService cartService;

    // URL localhost/mypage 입력 시 유저의 No를 활용해 그 유저의 페이지를 보여줌
    @GetMapping("")
    public String myPageList(Model model) {
        int userNo = 1;
        List<Post> posts = postService.getPostsByNo(userNo);
        model.addAttribute("posts",posts);

        return "mypage/publicpage";
    }

//    @GetMapping("/public/detail")
//    public String detail(int no, Model model) {
//        Post post = postService.getPostDetail(102);
//        System.out.println(post.getImages());
//        model.addAttribute(post);
//
//        return "mypage/detail";
//    }

//    @GetMapping("/test")
//    public String test(Model model){
//        Post post = postService.getPostDetail(1);
//
//        System.out.println(post);
//        model.addAttribute("Post",post);
//
//        return "mypage/test";
//    }

    // 장바구니 화면으로 간다.
    @GetMapping("/cart")
    public String cart() {

        return "mypage/cart";
    }

    // Post 방식으로
    @PostMapping("/cart")
    public String addCart(@RequestParam("sizeNo") List<Integer> sizeNo
            , @RequestParam("prodNo") List<Integer> prodNo
            , @RequestParam("stock") List<Integer> stock
            , @RequestParam("colorNo") List<Integer> colorNo
            , @AuthenticationPrincipal LoginUser loginUser) {

        List<CartRegisterForm> cartRegisterForms = new ArrayList<>();
        for (int i = 0; i < sizeNo.size(); i++) {
            int size = sizeNo.get(i);
            int prod = prodNo.get(i);
            int color = colorNo.get(i);
            int amount = stock.get(i);



            CartRegisterForm cartRegisterForm = new CartRegisterForm();
            cartRegisterForm.setSizeNo(size);
            cartRegisterForm.setProdNo(prod);
            cartRegisterForm.setColorNo(color);
            cartRegisterForm.setStock(amount);

            User user = User.builder().no(loginUser.getNo()).build();
            cartRegisterForm.setUserNo(user.getNo());

            cartRegisterForms.add(cartRegisterForm);
        }





        cartService.addCart(cartRegisterForms);

        return "mypage/cart";
    }

    // 위시리스트 화면으로 간다.
    @GetMapping("/wish")
    public String wish() {

        return "mypage/wish";
    }

    // Post 방식으로 
    @PostMapping("/wish")
    public String addWish() {
        return "mypage/wish";
    }

    // 주문결제 화면으로 간다.
    @GetMapping("/order")
    public String order() {

        return "mypage/order";
    }
}
