package store.seub2hu2.payment.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.lesson.dto.*;
import store.seub2hu2.payment.service.KakaoPayService;
import store.seub2hu2.lesson.service.LessonReservationService;
import store.seub2hu2.lesson.service.LessonService;
import store.seub2hu2.lesson.vo.Lesson;
import store.seub2hu2.payment.SessionUtils;
import store.seub2hu2.payment.dto.ApproveResponse;
import store.seub2hu2.payment.dto.CancelResponse;

import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/pay")
public class PayController {

    private final KakaoPayService kakaoPayService;

    private final LessonReservationService lessonReservationService;
    private final LessonService lessonService;

    @GetMapping("/form")
    public String payment(LessonDto lessonDto,
                          Model model) {
        log.info("lessonDto = {}", lessonDto);

        model.addAttribute("lessonDto", lessonDto);
        return "lesson/lesson-payment-form";
    }

    @PostMapping("/ready")
    public @ResponseBody ReadyResponse payReady(@RequestBody LessonReservationPaymentDto lessonReservationPaymentDto) {

        // 카카오 결제 준비하기
        ReadyResponse readyResponse = kakaoPayService.payReady(lessonReservationPaymentDto);
        // 세션에 결제 고유번호(tid) 저장
        SessionUtils.addAttribute("tid", readyResponse.getTid());

        log.info("결제 고유번호: " + readyResponse.getTid());

        return readyResponse;
    }

    @GetMapping("/completed")
    public String payCompleted(@RequestParam("pg_token") String pgToken, Model model) {

        String tid = SessionUtils.getStringAttributeValue("tid");
        log.info("결제승인 요청을 인증하는 토큰: " + pgToken);
        log.info("결제 고유번호: " + tid);

        // 카카오 결제 요청하기
        ApproveResponse approveResponse = kakaoPayService.payApprove(tid, pgToken);

        LessonReservationPaymentDto lessonReservationPaymentDto = new LessonReservationPaymentDto();
        lessonReservationPaymentDto.setPayNo(tid);
        lessonReservationPaymentDto.setPrice(approveResponse.getAmount().getTotal());
        lessonReservationPaymentDto.setLessonNo(Integer.parseInt(approveResponse.getItem_code()));

        log.info("lessonReservationPay = {}", lessonReservationPaymentDto);
        lessonReservationService.saveLessonReservation(lessonReservationPaymentDto);

        return "redirect:/success?id=" + tid;
    }

    @GetMapping("/cancel")
    public String payCancel(@RequestParam("pg_token") String pgToken, Model model) {
        String tid = SessionUtils.getStringAttributeValue("tid");

        Lesson lesson = lessonReservationService.getLessonByPayNo(tid);
        LessonReservationPaymentDto dto = new LessonReservationPaymentDto();
        dto.setPrice(lesson.getPrice());
        dto.setPayNo(tid);
        dto.setQuantity(1);

        // 카카오 결제 취소하기
        CancelResponse cancelResponse = kakaoPayService.payCancel(dto, tid);

        model.addAttribute("cancelResponse", cancelResponse);

        return "redirect:/refund?id=" + tid;
    }

    // 결제 환불 화면
    @GetMapping("/refund")
    public String refund(@RequestParam("pg_token") String pgToken, Model model) {
        String tid = SessionUtils.getStringAttributeValue("tid");

        Lesson lesson = lessonReservationService.getLessonByPayNo(tid);
        LessonReservationPaymentDto dto = new LessonReservationPaymentDto();
        dto.setPrice(lesson.getPrice());
        dto.setPayNo(tid);
        dto.setQuantity(1);

        // 카카오 결제 취소하기
        CancelResponse cancelResponse = kakaoPayService.payCancel(dto, tid);

        model.addAttribute("cancelResponse", cancelResponse);

        return "redirect:/cancel?id=" + tid;
    }

    // 결제 성공 화면
    @GetMapping("/success")
    public String success(@RequestParam("id") String payNo, Model model) {
        log.info("Order 컨트롤러 주문 완료 주문번호 조회 = {}", payNo);
        Lesson lesson = lessonReservationService.getLessonByPayNo(payNo);
        Map<String, String> images = lessonService.getImagesByLessonNo(lesson.getLessonNo());

        log.info("Order 컨트롤러 주문 완료 주문객체 조회 = {}", lesson);
        model.addAttribute("lesson", lesson);
        model.addAttribute("images", images);
        return "lesson/lesson-pay-completed";
    }
}