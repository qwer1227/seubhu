package store.seub2hu2.mypage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.AuthenticatedPrincipal;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.mypage.service.PostService;
import store.seub2hu2.mypage.vo.Post;
import store.seub2hu2.security.LoginUser;
import store.seub2hu2.user.vo.User;

import java.util.List;

@Controller
@RequestMapping("/mypage")
public class MyPageController {

    @Autowired
    PostService postService;

    // URL localhost/mypage 입력 시 유저의 No를 활용해 그 유저의 페이지를 보여줌
    @GetMapping("")
    public String myPageList(Model model) {
//        User user = new User();
//        user.setNo(loginUser.getNo());
//        int userNo = user.getNo();
//        System.out.println(loginUser.getNo());
        List<Post> posts = postService.getPostsByNo(11);
        model.addAttribute("posts",posts);


        return "mypage/publicpage";
    }

    @GetMapping("/private")
    public String mypagePrivate(Model model){

        return "mypage/privatepage";
    }

}
