package store.seub2hu2.security.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import store.seub2hu2.security.vo.OauthToken;

@RestController
@RequestMapping("/auth")
public class AuthController {

    @GetMapping("/kakao/callback")
    public @ResponseBody String kakaoCallback(String code) {
        // POST 방식으로 key=value 데이터를 요청 (카카오쪽으로)
        RestTemplate rt = new RestTemplate();

        // HTTP 요청 헤더 생성
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");

        // HTTP 요청 Body 생성
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("grant_type", "authorization_code");
        params.add("client_id", "your-client-id");
        params.add("redirect_uri", "http://localhost:8080/auth/kakao/callback");
        params.add("code", code);

        // 요청하기 위해 헤더(Header)와 데이터(Body)를 합친다.
        HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(params, headers);

        // POST 방식으로 Http 요청한다.
        ResponseEntity<String> response = rt.exchange(
                "https://kauth.kakao.com/oauth/token",
                HttpMethod.POST,
                kakaoTokenRequest,
                String.class
        );

        ObjectMapper objectMapper = new ObjectMapper();
        OauthToken oauthToken = null;
        try {
            oauthToken = objectMapper.readValue(response.getBody(), OauthToken.class);
        } catch (JsonMappingException e) {
            e.printStackTrace();
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        System.out.println("카카오 액세스 토큰: " + oauthToken.getAccessToken());

        // POST 방식으로 key=value 데이터를 요청 (카카오쪽으로)
        RestTemplate rt2 = new RestTemplate();

        // HTTP 요청 헤더 생성
        HttpHeaders headers2 = new HttpHeaders();
        headers2.add("Authorization", "Bearer"+oauthToken.getAccessToken());
        headers2.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");

        // 요청하기 위해 헤더(Header)와 데이터(Body)를 합친다.
        HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest2 = new HttpEntity<>(headers2);

        // POST 방식으로 Http 요청한다.
        ResponseEntity<String> response2 = rt2.exchange(
                "https://kapi.kakao.com/v2/user/me",
                HttpMethod.POST,
                kakaoProfileRequest2,
                String.class
        );

        return response2.getBody();
    }


    @GetMapping("/naver/callback")
    public @ResponseBody String naverCallback(String code) { // Data 리턴 해 주는 컨트롤러 함수
        return "네이버 인증 완료; 코드값: " + code;
    }

    @GetMapping("/google/callback")
    public @ResponseBody String googleCallback(String code) { // Data 리턴 해 주는 컨트롤러 함수
        return "구글 인증 완료; 코드값: " + code;
    }

}

