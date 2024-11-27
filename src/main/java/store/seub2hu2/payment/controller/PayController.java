package store.seub2hu2.payment.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.lesson.dto.*;
import store.seub2hu2.lesson.vo.LessonReservation;
import store.seub2hu2.payment.dto.PaymentDto;
import store.seub2hu2.payment.service.KakaoPayService;
import store.seub2hu2.lesson.service.LessonReservationService;
import store.seub2hu2.lesson.service.LessonService;
import store.seub2hu2.lesson.vo.Lesson;
import store.seub2hu2.payment.SessionUtils;
import store.seub2hu2.payment.dto.ApproveResponse;
import store.seub2hu2.payment.dto.CancelResponse;
import store.seub2hu2.payment.service.PaymentService;

import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/pay")
public class PayController {

    private final KakaoPayService kakaoPayService;

    private final LessonReservationService lessonReservationService;
    private final LessonService lessonService;
    private final PaymentService paymentService;

    @GetMapping("/form")
    public String payment(LessonDto lessonDto,
                          Model model) {
        log.info("/form lessonDto = {}", lessonDto);

        model.addAttribute("lessonDto", lessonDto);
        return "lesson/lesson-payment-form";
    }

    @PostMapping("/ready")
    public @ResponseBody ReadyResponse payReady(@RequestBody PaymentDto paymentDto) {

        // 카카오 결제 준비하기
        ReadyResponse readyResponse = kakaoPayService.payReady(paymentDto);
        // 세션에 결제 고유번호(tid) 저장
        SessionUtils.addAttribute("tid", readyResponse.getTid());

        log.info("결제 고유번호: " + readyResponse.getTid());

        return readyResponse;
    }

    @GetMapping("/completed")
    public String payCompleted(@RequestParam("pg_token") String pgToken
                            , @RequestParam("type") String type
                               , @RequestParam("lessonNo") int lessonNo
                             , Model model) {

        String tid = SessionUtils.getStringAttributeValue("tid");
        log.info("결제승인 요청을 인증하는 토큰: " + pgToken);
        log.info("결제 고유번호: " + tid);

        // 카카오 결제 요청하기
        ApproveResponse approveResponse = kakaoPayService.payApprove(tid, pgToken, lessonNo);

        PaymentDto paymentDto = new PaymentDto();
        paymentDto.setUserNo(29);
        paymentDto.setPayId(tid);
        paymentDto.setTotalAmount(approveResponse.getAmount().getTotal());
        paymentDto.setLessonNo(lessonNo);

        log.info("lessonReservationPay = {}", paymentDto);

        if (type.equals("레슨")) {
            lessonReservationService.saveLessonReservation(paymentDto);
        }

        if (type.equals("상품")) {
            // 상품 주문 정보 저장 로직
        }

        return "redirect:/pay/success?id=" + tid;
    }

    // 결제 취소 요청
    @PostMapping("/cancel")
    public CancelResponse payCancel(@RequestParam("pg_token") String pgToken, Model model) {
        String tid = SessionUtils.getStringAttributeValue("tid");


        LessonReservation lessonReservation = lessonReservationService.getLessonReservationByPayId(tid);
        PaymentDto paymentDto = new PaymentDto();
        paymentDto.setTotalAmount(lessonReservation.getPayment().getPrice());
        paymentDto.setPayId(tid);
        paymentDto.setQuantity(1);

        // 카카오 결제 취소하기
        CancelResponse cancelResponse = kakaoPayService.payCancel(paymentDto, tid);

        model.addAttribute("cancelResponse", cancelResponse);

        return cancelResponse;
    }

    // 결제 환불 화면
    @GetMapping("/refund")
    public String refund(@RequestParam("pg_token") String pgToken, Model model) {
        String tid = SessionUtils.getStringAttributeValue("tid");


        return "lesson/lesson-pay-cancel?id=" + tid;
    }

    // 결제 성공 화면
    @GetMapping("/success")
    public String success(@RequestParam("id") String payId, Model model) {
        String type = paymentService.getPaymentTypeById(payId);

        if (type.equals("레슨")) {
            LessonReservation lessonReservation = lessonReservationService.getLessonReservationByPayId(payId);
            log.info("/success lessonReservation 객체 = {} ", lessonReservation);
            Map<String, String> images = lessonService.getImagesByLessonNo(lessonReservation.getLesson().getLessonNo());
            model.addAttribute("lessonReservation", lessonReservation);
            model.addAttribute("images", images);
        }

        if (type.equals("상품")) {
            // 결제 성공 화면에 출력할 상품 정보
        }

        return "lesson/lesson-pay-completed";
    }
}