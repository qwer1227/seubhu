package store.seub2hu2.lesson.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import store.seub2hu2.lesson.dto.LessonReservationPay;
import store.seub2hu2.lesson.mapper.LessonMapper;
import store.seub2hu2.lesson.mapper.LessonReservationMapper;
import store.seub2hu2.lesson.mapper.PayMapper;
import store.seub2hu2.lesson.vo.Lesson;
import store.seub2hu2.lesson.vo.Payment;

@Service
@RequiredArgsConstructor
@Slf4j
public class LessonReservationService {

    private final LessonService lessonService;

    private final LessonMapper lessonMapper;
    private final LessonReservationMapper lessonReservationMapper;
    private final PayMapper payMapper;


    public void saveLessonReservation(LessonReservationPay lessonReservationPay) {
        Lesson lesson = lessonService.getLessonByNo(lessonReservationPay.getLessonNo());

        log.info("lesson = {}", lesson);
        if(lesson.getParticipant() != 5) {
            Payment payment = new Payment();
            payment.setNo(lessonReservationPay.getPayNo());
            payment.setUserNo(29);
            payment.setPayStatus("결제완료");
            payment.setPayType("레슨");
            payment.setPayMethod("카드");
            payment.setAmount(1);
            payment.setPrice(lessonReservationPay.getPrice());
            log.info("payment = {}", payment);
            payMapper.insertPay(payment);

            lessonReservationPay.setUserNo(29);
            // 예약 테이블 저장 mapper
            lessonReservationMapper.insertLessonReservation(lessonReservationPay);
            lesson.setParticipant(lesson.getParticipant() + 1);
        }


        if(lesson.getParticipant() == 5) {

        }

        lessonMapper.updateLessonByNo(lesson);




    }
}
