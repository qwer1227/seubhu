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

    @GetMapping("")
    public String myPageList(Model model) {
        int userNo = 1;
        List<Post> posts = postService.getPostsByNo(userNo);
        model.addAttribute("posts",posts);

        return "mypage/publicpage";
    }

    @GetMapping("/public/detail")
    public String detail(int no, Model model) {
        Post post = postService.getPostDetail(102);
        System.out.println(post.getImages());
        model.addAttribute(post);

        return "mypage/detail";
    }

//    @GetMapping("/test")
//    public String test(Model model){
//        Post post = postService.getPostDetail(1);
//
//        System.out.println(post);
//        model.addAttribute("Post",post);
//
//        return "mypage/test";
//    }
}