package store.seub2hu2.user.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import store.seub2hu2.user.dto.LoginResponse;
import store.seub2hu2.user.dto.SocialLoginRequest;
import store.seub2hu2.user.service.UserService;

import java.net.URI;

@RestController
    @RequestMapping("/api/user")
    @RequiredArgsConstructor
    public class UserApiController {
        private final UserService userService;

        @PostMapping("/social-login")
        public ResponseEntity<LoginResponse> doSocialLogin(@RequestBody @Valid SocialLoginRequest request) {

            return ResponseEntity.created(URI.create("/social-login"))
                    .body(userService.doSocialLogin(request));
        }
}
