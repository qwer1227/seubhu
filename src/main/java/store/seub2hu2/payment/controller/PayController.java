package store.seub2hu2.payment.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.lesson.dto.*;
import store.seub2hu2.lesson.enums.ReservationStatus;
import store.seub2hu2.lesson.service.LessonFileService;
import store.seub2hu2.lesson.service.LessonService;
import store.seub2hu2.lesson.vo.LessonReservation;
import store.seub2hu2.mypage.dto.ResponseDTO;
import store.seub2hu2.order.mapper.OrderMapper;
import store.seub2hu2.order.service.OrderService;
import store.seub2hu2.order.vo.OrderItem;
import store.seub2hu2.payment.dto.PaymentDto;
import store.seub2hu2.payment.service.KakaoPayService;
import store.seub2hu2.lesson.service.LessonReservationService;
import store.seub2hu2.payment.dto.ApproveResponse;
import store.seub2hu2.payment.dto.CancelResponse;
import store.seub2hu2.payment.service.PaymentService;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.util.SessionUtils;

import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/pay")
public class PayController {

    private final KakaoPayService kakaoPayService;
    private final SessionUtils sessionUtils;

    private final LessonReservationService lessonReservationService;
    private final LessonService lessonService;
    private final LessonFileService lessonFileService;
    private final PaymentService paymentService;

    private final OrderService orderService;

    @PreAuthorize("isAuthenticated()")
    @GetMapping("/form")
    public String payment(LessonDto lessonDto,
                          Model model) {
        log.info("/form lessonDto = {}", lessonDto);

        Map<String, String> images = lessonFileService.getImagesByLessonNo(lessonDto.getLessonNo());

        model.addAttribute("lessonDto", lessonDto);
        model.addAttribute("images", images);
        return "lesson/lesson-payment-form";
    }

    @PostMapping("/ready")
    public @ResponseBody ReadyResponse payReady(@RequestBody PaymentDto paymentDto
    , @AuthenticationPrincipal LoginUser loginUser) {



        paymentDto.setUserNo(loginUser.getNo());
        // 카카오 결제 준비하기
        ReadyResponse readyResponse = kakaoPayService.payReady(paymentDto);
        // 세션에 결제 고유번호(tid) 저장
        sessionUtils.addAttribute("tid", readyResponse.getTid());

        log.info("결제 고유번호: " + readyResponse.getTid());

        return readyResponse;
    }

    @GetMapping("/completed")
    public String payCompleted(@RequestParam("pg_token") String pgToken
            , @RequestParam  Map<String, Object> param
            , Model model) {

        String tid = sessionUtils.getAttribute("tid");
        log.info("결제승인 요청을 인증하는 토큰: " + pgToken);
        log.info("결제 고유번호: " + tid);

        String type = (String) param.get("type");


        if (type.equals("레슨")) {
            String lessonNoStr = (String) param.get("lessonNo");
            int lessonNo = Integer.parseInt(lessonNoStr);
            String userId = (String) param.get("userId");


            // 카카오 결제 요청하기
            ApproveResponse approveResponse = kakaoPayService.payApprove(tid, pgToken, lessonNo);

            PaymentDto paymentDto = new PaymentDto();
            paymentDto.setUserId(userId);
            paymentDto.setPaymentId(tid);
            paymentDto.setTotalAmount(approveResponse.getAmount().getTotal());
            paymentDto.setLessonNo(lessonNo);

            log.info("lessonReservationPay = {}", paymentDto);
            lessonReservationService.saveLessonReservation(paymentDto);
        }

        if (type.equals("상품")) {
            // 결재정보를 저장한다.
            String orderStr = (String) param.get("orderNo");
            int orderNo = Integer.parseInt(orderStr);
            String userId = (String) param.get("userId");


            // 카카오 결제 요청하기
            ApproveResponse approveResponse = kakaoPayService.payApprove(tid, pgToken, orderNo);

            PaymentDto paymentDto = new PaymentDto();
            paymentDto.setUserId(userId);
            paymentDto.setPaymentId(tid);
            paymentDto.setTotalAmount(approveResponse.getAmount().getTotal());

        }

        return "redirect:/pay/success";
    }

    // 결제 취소 요청
    @PostMapping("/cancel")
    public String payCancel(@ModelAttribute PaymentDto paymentDto
                           , @AuthenticationPrincipal LoginUser loginUser
            , Model model) {

        String paymentId= paymentDto.getPaymentId();

        // 예약 정보 조회
        LessonReservation lessonReservation = lessonReservationService.getLessonReservationByPayId(paymentId);

        // 주문 정보 조회


        // 카카오 결제 취소하기
        CancelResponse cancelResponse = kakaoPayService.payCancel(paymentDto, paymentId);

        // 예약 상태 변경
        if (lessonReservation != null) {
            lessonReservationService.cancelReservation(paymentId, ReservationStatus.CANCELLED, paymentDto.getLessonNo());
        }

        model.addAttribute("cancelResponse", cancelResponse);
        return "redirect:/lesson/reservation";
    }

    // 결제 성공 화면
    @GetMapping("/success")
    public String success(Model model) {
        String tid= sessionUtils.getAttribute("tid");
        String type = paymentService.getPaymentTypeById(tid);

        if (type.equals("레슨")) {
            LessonReservation lessonReservation = lessonReservationService.getLessonReservationByPayId(tid);
            int lessonNo = lessonReservation.getLesson().getLessonNo();
            Map<String, String> startAndEnd = lessonService.getStartAndEnd(lessonNo);
            log.info("/success lessonReservation 객체 = {} ", lessonReservation);
            Map<String, String> images = lessonFileService.getImagesByLessonNo(lessonNo);
            model.addAttribute("lessonReservation", lessonReservation);
            model.addAttribute("images", images);
            model.addAttribute("startDate", startAndEnd.get("startDate"));
            model.addAttribute("startTime", startAndEnd.get("startTime"));
            model.addAttribute("endTime", startAndEnd.get("endTime"));
        }

        if (type.equals("상품")) {
            // 결제 성공 화면에 출력할 상품 정보
            int orderNo = 1001;
            ResponseDTO responseDTO = orderService.getOrderDetails(orderNo);
            model.addAttribute("orderDetail", responseDTO);

            return "/mypage/order-pay-completed";
        }

        return "lesson/lesson-pay-completed";
    }
}