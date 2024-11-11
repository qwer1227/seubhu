package store.seub2hu2.mypage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import store.seub2hu2.mypage.service.PostService;
import store.seub2hu2.mypage.vo.Post;

@Controller
@RequestMapping("/mypage")
public class MyPageController {

    @Autowired
    PostService postService;

    @GetMapping("")
    public String myPageList() {

        return "mypage/publicpage";
    }

    @GetMapping("/public/detail")
    public String detail(int no, Model model) {
        Post post = postService.getPostDetail(no);
        model.addAttribute(post);


        return "mypage/detail";
    }
}
