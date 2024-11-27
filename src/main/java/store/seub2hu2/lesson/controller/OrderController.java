package store.seub2hu2.lesson.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.lesson.dto.*;
import store.seub2hu2.lesson.service.KakaoPayService;
import store.seub2hu2.lesson.service.LessonReservationService;
import store.seub2hu2.util.SessionUtils;

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
    public @ResponseBody ReadyResponse payReady(@RequestBody LessonReservationPay lessonReservationPay) {
        
        String name = lessonReservationPay.getTitle();
        int totalPrice = lessonReservationPay.getPrice();
        
        log.info("예약 레슨 이름: " + name);
        log.info("레슨 금액: " + totalPrice);

        // 카카오 결제 준비하기
        ReadyResponse readyResponse = kakaoPayService.payReady(lessonReservationPay, name, totalPrice);
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

        LessonReservationPay lessonReservationPay = new LessonReservationPay();
        lessonReservationPay.setPayNo(tid);
        lessonReservationPay.setPrice(20000);
        lessonReservationPay.setLessonNo(10);

        log.info("lessonReservationPay = {}", lessonReservationPay);
        lessonReservationService.saveLessonReservation(lessonReservationPay);


        return "redirect:/order/completed?id=" + tid;
    }

    @GetMapping("/completed")
    public String completed(@RequestParam("id") String orderId, Model model) {


        return "lesson/lesson-pay-completed";
    }
}