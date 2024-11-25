package store.seub2hu2.mypage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.mypage.service.PostService;
import store.seub2hu2.mypage.vo.Post;

import java.util.List;

@Controller
@RequestMapping("/mypage")
public class MyPageController {

    @Autowired
    PostService postService;

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

    // 위시리스트 화면으로 간다.
    @GetMapping("/wish")
    public String wish() {

        return "mypage/wish";
    }

    // 주문결제 화면으로 간다.
    @GetMapping("/order")
    public String order() {

        return "mypage/order";
    }
}
