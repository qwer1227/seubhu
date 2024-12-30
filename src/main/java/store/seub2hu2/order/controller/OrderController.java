package store.seub2hu2.order.controller;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.lesson.dto.ReadyResponse;
import store.seub2hu2.lesson.enums.ReservationStatus;
import store.seub2hu2.lesson.vo.LessonReservation;
import store.seub2hu2.mypage.dto.OrderResultDto;
import store.seub2hu2.order.service.OrderService;
import store.seub2hu2.payment.dto.ApproveResponse;
import store.seub2hu2.payment.dto.CancelResponse;
import store.seub2hu2.payment.dto.PaymentDto;
import store.seub2hu2.payment.mapper.PayMapper;
import store.seub2hu2.payment.service.PayService;
import store.seub2hu2.payment.service.PaymentService;
import store.seub2hu2.payment.vo.Payment;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.util.SessionUtils;

import java.util.Map;

@RequestMapping("/order")
@RequiredArgsConstructor
@Slf4j
@Controller
public class OrderController {

    private final SessionUtils sessionUtils;

    private final PayService payService;

    private final OrderService orderService;

    private final PaymentService paymentService;

    private final PayMapper payMapper;

    @PostMapping("/ready")
    public @ResponseBody ReadyResponse payReady(@RequestBody PaymentDto paymentDto
            , @AuthenticationPrincipal LoginUser loginUser) {

        paymentDto.setUserNo(loginUser.getNo());
        // 카카오 결제 준비하기
        ReadyResponse readyResponse = payService.payReady(paymentDto);
        // 세션에 결제 고유번호(tid) 저장
        sessionUtils.addAttribute("tid", readyResponse.getTid());

        log.info("결제 고유번호: " + readyResponse.getTid());

        return readyResponse;
    }

    @GetMapping("/completed")
    public String payCompleted(@RequestParam("pg_token") String pgToken
            , @AuthenticationPrincipal LoginUser loginUser
            , @RequestParam Map<String, Object> param
            , Model model) {

        String tid = sessionUtils.getAttribute("tid");
        String orderStr = (String) param.get("orderNo");
        int orderNo = Integer.parseInt(orderStr);

        // 결제 완료 처리
        payService.payCompleted(pgToken, tid, orderNo);

            return "redirect:/order/success?no="+ orderNo;
        }


    // 결제 성공 화면
    @GetMapping("/success")
    public String success(@RequestParam(name ="no", required = false, defaultValue = "0") int orderNo, Model model) {
        String tid = sessionUtils.getAttribute("tid");
        String type = paymentService.getPaymentTypeById(tid);
        System.out.println("------------------------- tid: " + tid);
        System.out.println("------------------------- 타입: " + type);


        OrderResultDto orderResultDto = orderService.getOrderResult(orderNo);

        model.addAttribute("orderDetail", orderResultDto);

        return "mypage/order-pay-completed";
    }

    // 결제 취소 요청
    @PostMapping("/cancel")
    public String payCancel(PaymentDto paymentDto
            , @AuthenticationPrincipal LoginUser loginUser
            , Model model) {

            // 주문관련 정보 수정
            OrderResultDto dto = orderService.cancelOrder(paymentDto);

            String paymentId = dto.getPayId();
            paymentDto.setTotalAmount(dto.getPayPrice());

            // 카카오 결제 취소
            CancelResponse cancelResponse = payService.payCancel(paymentDto, paymentId);

            // 결재정보를 변경
            Payment p2 = new Payment();
            p2.setId(paymentId);
            p2.setStatus("취소");
            payMapper.updateProductPayStatus(p2);


            model.addAttribute("cancelResponse", cancelResponse);

            return "redirect:/mypage/orderhistory";
    }
}
