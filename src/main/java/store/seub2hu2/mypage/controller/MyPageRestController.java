package store.seub2hu2.mypage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.mypage.service.PostService;
import store.seub2hu2.mypage.vo.Post;

@RestController
@RequestMapping("/mypage")
public class MyPageRestController {

    @Autowired
    private PostService postService;

    @GetMapping("/detail/{no}")
    public Post getPostdetail(@PathVariable("no") int no){
        return postService.getPostDetail(no);
    }


}
