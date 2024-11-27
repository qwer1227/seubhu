package store.seub2hu2.mypage.controller;

import com.nimbusds.openid.connect.sdk.claims.UserInfo;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.cart.dto.CartRegisterForm;
import store.seub2hu2.community.service.BoardService;
import store.seub2hu2.community.vo.Board;
import store.seub2hu2.mypage.dto.UserInfoReq;
import store.seub2hu2.mypage.service.CartService;
import store.seub2hu2.mypage.service.PostService;
import store.seub2hu2.mypage.vo.Post;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.user.service.UserService;
import store.seub2hu2.user.vo.User;
import store.seub2hu2.util.ListDto;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/mypage")
public class MyPageController {

    @Autowired
    PostService postService;

    @Autowired
    CartService cartService;

    @Autowired
    UserService userService;

    @Autowired
    BoardService boardService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    // URL localhost/mypage 입력 시 유저의 No를 활용해 그 유저의 페이지를 보여줌
    @GetMapping("")
    public String myPageList(Model model, @AuthenticationPrincipal LoginUser loginUser) {
        List<Post> posts = postService.getPostsByNo(loginUser.getNo());
        User user = userService.findbyUserNo(loginUser.getId());

        model.addAttribute("posts",posts);
        model.addAttribute("user",user);

        System.out.println(posts);

        return "mypage/publicpage";
    }

    @GetMapping("/private")
    public String mypagePrivate(){

        return "mypage/privatepage";
    }

    // 내 정보 수정전에 비밀번호 검증
    @GetMapping("/verify-password")
    public String verifyPassword(){
        return "mypage/verify-password";
    }

    // 검증 로직
    @PostMapping("/verify-password")
    public String verifyPassword(@RequestParam(name = "password") String password, @AuthenticationPrincipal LoginUser loginUser) {

        boolean isChecked = userService.verifyPassword(password,loginUser);

        if(isChecked) {
            // 비밀번호가 맞으면 페이지 변경
            return "redirect:/mypage/edit";
        }
        // 비밀번호가 틀리면 다시 입력하도록 에러 메시지 추가
        return "redirect:/mypage/verify-password?error";
    }


    // 내 정보 수정 폼
    @GetMapping("/edit")
    public String userEdit(){

        return "mypage/edit";
    }

    // 수정 폼 입력값 저장
    @PostMapping("/edit")
    public String userEdit(@ModelAttribute UserInfoReq userInfoReq,@AuthenticationPrincipal LoginUser loginUser){

        int isUpdated = userService.updateUser(userInfoReq,loginUser);

        if(isUpdated == 0){
            return "redirect:/mypage/private";
        } else if(isUpdated == 1){
            return "redirect:/mypage/edit?error1";
        } else {
            return "redirect:/mypage/edit?error2";
        }
    }

    @GetMapping("/history")
    public String userHistory(@RequestParam(name = "page", required = false, defaultValue = "1") int page
            , @RequestParam(name = "rows", required = false, defaultValue = "10") int rows
            , @RequestParam(name = "sort", required = false, defaultValue = "date") String sort
            , @RequestParam(name = "opt", required = false) String opt
            , @RequestParam(name = "keyword", required = false) String keyword
            , @RequestParam(name = "category", required = false) String category
            , Model model) {


        Map<String, Object> condition = new HashMap<>();
        condition.put("page", page);
        condition.put("rows", rows);
        condition.put("sort", sort);

        // 카테고리 필터링 처리
        if (StringUtils.hasText(category)) {
            condition.put("category", category);
        }

        if (StringUtils.hasText(keyword)){
            condition.put("opt", opt);
            condition.put("keyword", keyword);
        }

        ListDto<Board> dto = boardService.getBoards(condition);

        model.addAttribute("boards", dto.getData());
        model.addAttribute("paging", dto.getPaging());
        return "mypage/history";
    }

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

        // CartRegisterForm
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
