package store.seub2hu2.lesson.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.lesson.dto.*;
import store.seub2hu2.lesson.service.KakaoPayService;
import store.seub2hu2.lesson.service.LessonReservationService;
import store.seub2hu2.lesson.vo.Lesson;
import store.seub2hu2.payment.SessionUtils;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/order")
public class OrderController {

    private final KakaoPayService kakaoPayService;

    private final LessonReservationService lessonReservationService;

    @GetMapping("/pay/form")
    public String payment(LessonDto lessonDto,
                          Model model)  {
        log.info("lessonDto = {}", lessonDto);

        model.addAttribute("lessonDto", lessonDto);
        return "lesson/lesson-payment-form";
    }

    @PostMapping("/pay/ready")
    public @ResponseBody ReadyResponse payReady(@RequestBody LessonReservationPaymentDto lessonReservationPaymentDto) {

        // 카카오 결제 준비하기
        ReadyResponse readyResponse = kakaoPayService.payReady(lessonReservationPaymentDto);
        // 세션에 결제 고유번호(tid) 저장
        SessionUtils.addAttribute("tid", readyResponse.getTid());

        log.info("결제 고유번호: " + readyResponse.getTid());

        return readyResponse;
    }

    @GetMapping("/pay/completed")
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

        return "redirect:/order/completed?id=" + tid;
    }

    // 완료 화면
    @GetMapping("/completed")
    public String completed(@RequestParam("id") String payNo, Model model) {
        log.info("Order 컨트롤러 주문 완료 주문번호 조회 = {}", payNo);
        Lesson lesson =  lessonReservationService.getLessonReservationByPayNo(payNo);
        log.info("Order 컨트롤러 주문 완료 주문객체 조회 = {}", lesson);
        model.addAttribute("lesson", lesson);
        return "lesson/lesson-pay-completed";
    }
}