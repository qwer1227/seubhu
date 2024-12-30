package store.seub2hu2.payment.service;


import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;
import store.seub2hu2.delivery.mapper.DeliveryMapper;
import store.seub2hu2.delivery.vo.Delivery;
import store.seub2hu2.mypage.dto.OrderResultDto;
import store.seub2hu2.mypage.dto.OrderResultItemDto;
import store.seub2hu2.mypage.dto.ResponseDTO;
import store.seub2hu2.mypage.mapper.CartMapper;
import store.seub2hu2.order.exception.*;
import store.seub2hu2.order.mapper.OrderMapper;
import store.seub2hu2.order.vo.Order;
import store.seub2hu2.order.vo.OrderItem;
import store.seub2hu2.payment.dto.PaymentDto;
import store.seub2hu2.payment.dto.ApproveResponse;
import store.seub2hu2.payment.dto.CancelResponse;
import store.seub2hu2.lesson.dto.ReadyResponse;
import store.seub2hu2.product.dto.ProdAmountDto;
import store.seub2hu2.product.dto.ProdDetailDto;
import store.seub2hu2.product.dto.ProdImagesDto;
import store.seub2hu2.product.dto.ProdListDto;
import store.seub2hu2.product.mapper.ProductMapper;
import store.seub2hu2.product.vo.Color;
import store.seub2hu2.product.vo.Product;
import store.seub2hu2.product.vo.Size;
import store.seub2hu2.user.mapper.UserMapper;
import store.seub2hu2.user.vo.Addr;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class KakaoPayService {

    @Value("${server.ip}")
    private String serverIp;

    @Autowired
    private ProductMapper productMapper;
    // 주문 맵퍼 인터페이스(주문, 주문상품)
    @Autowired
    private OrderMapper orderMapper;
    // 배송 정보
    @Autowired
    private DeliveryMapper deliveryMapper;
    // 주소지
    @Autowired
    private UserMapper userMapper;

    
    @Value("${kakaopay.secretKey}")
    String secretKey;
    @Autowired
    private CartMapper cartMapper;

    // 카카오페이 결제 승인
    // 사용자가 결제 수단을 선택하고 비밀번호를 입력해 결제 인증을 완료한 뒤,
    // 최종적으로 결제 완료 처리를 하는 단계
    @Transactional
    public ReadyResponse payReady(PaymentDto paymentDto) {
        log.info("Pay ready dto = {}", paymentDto);
        Map<String, String> parameters = new HashMap<>();
        parameters.put("cid", "TC0ONETIME");
        parameters.put("partner_order_id", "1234567890");
        parameters.put("partner_user_id", "seub2hu2");
        parameters.put("quantity", String.valueOf(paymentDto.getQuantity()));

        // 레슨 결제
        parameters.put("item_name", paymentDto.getTitle());
        parameters.put("item_code", String.valueOf(paymentDto.getLessonNo()));
        parameters.put("total_amount", String.valueOf(paymentDto.getTotalAmount()));

        parameters.put("approval_url", serverIp + "/pay/completed?type=" + paymentDto.getType()
                    + "&lessonNo=" + paymentDto.getLessonNo());

        parameters.put("tax_free_amount", "0");
        parameters.put("cancel_url", serverIp + "/pay/cancel");
        parameters.put("fail_url", serverIp + "/pay/fail");


        // HttpEntity : HTTP 요청 또는 응답에 해당하는 Http Header와 Http Body를 포함하는 클래스
        HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(parameters, this.getHeaders());

        // RestTemplate
        // : Rest 방식 API를 호출할 수 있는 Spring 내장 클래스
        //   REST API 호출 이후 응답을 받을 때까지 기다리는 동기 방식 (json, xml 응답)
        RestTemplate template = new RestTemplate();
        String url = "https://open-api.kakaopay.com/online/v1/payment/ready";
        // RestTemplate의 postForEntity : POST 요청을 보내고 ResponseEntity로 결과를 반환받는 메소드
        ResponseEntity<ReadyResponse> responseEntity = template.postForEntity(url, requestEntity, ReadyResponse.class);
        log.info("결제준비 응답객체: " + responseEntity.getBody());


        return responseEntity.getBody();
    }

    // 카카오페이 결제 승인
    // 사용자가 결제 수단을 선택하고 비밀번호를 입력해 결제 인증을 완료한 뒤,
    // 최종적으로 결제 완료 처리를 하는 단계
    public ApproveResponse payApprove(String tid, String pgToken, int lessonNo) {
        Map<String, String> parameters = new HashMap<>();
        parameters.put("cid", "TC0ONETIME");              // 가맹점 코드(테스트용)
        parameters.put("tid", tid);                       // 결제 고유번호
        parameters.put("partner_order_id", "1234567890"); // 주문번호
        parameters.put("partner_user_id", "seub2hu2");    // 회원 아이디
        parameters.put("pg_token", pgToken);              // 결제승인 요청을 인증하는 토큰
        HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(parameters, this.getHeaders());

        RestTemplate template = new RestTemplate();
        String url = "https://open-api.kakaopay.com/online/v1/payment/approve";
        ApproveResponse approveResponse = template.postForObject(url, requestEntity, ApproveResponse.class);
        log.info("결제승인 응답객체: " + approveResponse);

        return approveResponse;
    }

    // 카카오페이 결제 취소
    // 사용자가 결제 수단을 선택하고 비밀번호를 입력해 결제 인증을 완료한 뒤,
    // 최종적으로 결제 취소 처리를 하는 단계
    public CancelResponse payCancel(PaymentDto paymentDto, String tid) {

        Map<String, String> parameters = new HashMap<>();
        parameters.put("cid", "TC0ONETIME");
        parameters.put("tid", tid);
        parameters.put("cancel_amount", String.valueOf(paymentDto.getTotalAmount()));
        parameters.put("cancel_tax_free_amount", String.valueOf(0));
        parameters.put("quantity", String.valueOf(paymentDto.getQuantity()));
        log.info("결제 취소 = {}", paymentDto);

        // HttpEntity : HTTP 요청 또는 응답에 해당하는 Http Header와 Http Body를 포함하는 클래스
        HttpEntity<Map<String, String>> requestEntity = new HttpEntity<>(parameters, this.getHeaders());

        // RestTemplate
        // : Rest 방식 API를 호출할 수 있는 Spring 내장 클래스
        //   REST API 호출 이후 응답을 받을 때까지 기다리는 동기 방식 (json, xml 응답)
        RestTemplate template = new RestTemplate();
        String url = "https://open-api.kakaopay.com/online/v1/payment/cancel";
        // RestTemplate의 postForEntity : POST 요청을 보내고 ResponseEntity로 결과를 반환받는 메소드
        CancelResponse cancelResponse = template.postForObject(url, requestEntity, CancelResponse.class);
        log.info("결제취소 응답객체: " + cancelResponse);

        return cancelResponse;
    }

    // 카카오페이 측에 요청 시 헤더부에 필요한 값
    private HttpHeaders getHeaders() {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "SECRET_KEY " + secretKey);
        headers.set("Content-type", "application/json");

        return headers;
    }
}