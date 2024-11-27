package store.seub2hu2.lesson.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.lesson.dto.LessonReservationPaymentDto;
import store.seub2hu2.lesson.mapper.LessonMapper;
import store.seub2hu2.lesson.mapper.LessonReservationMapper;
import store.seub2hu2.lesson.mapper.PayMapper;
import store.seub2hu2.lesson.vo.Lesson;
import store.seub2hu2.lesson.vo.LessonReservation;
import store.seub2hu2.lesson.vo.Payment;

@Service
@RequiredArgsConstructor
@Slf4j
public class LessonReservationService {

    private final LessonService lessonService;

    private final LessonMapper lessonMapper;
    private final LessonReservationMapper lessonReservationMapper;
    private final PayMapper payMapper;

    @Transactional(isolation = Isolation.READ_COMMITTED)
    public void saveLessonReservation(LessonReservationPaymentDto lessonReservationPaymentDto) {
        try {
            // 1. 레슨 정보 조회
            Lesson lesson = lessonMapper.getLessonByNo(lessonReservationPaymentDto.getLessonNo());

            if (lesson == null) {
                throw new RuntimeException("존재하지 않는 레슨입니다. LessonNo: " + lessonReservationPaymentDto.getLessonNo());
            }

            log.info("레슨 예약 시도: {}", lessonReservationPaymentDto);
            log.info("현재 참가자 수: {}", lesson.getParticipant());

            // 2. 참가자 수 초과 여부 확인
            if (lesson.getParticipant() >= 5) {
                throw new RuntimeException("예약 정원 마감. LessonNo: "
                        + lesson.getLessonNo() + ", Current participants: " + lesson.getParticipant());
            }

            // 3. 결제 정보 저장
            Payment payment = new Payment();
            payment.setNo(lessonReservationPaymentDto.getPayNo());
            payment.setUserNo(lessonReservationPaymentDto.getUserNo());
            payment.setPayStatus("결제완료");
            payment.setPayType("레슨");
            payment.setPayMethod("카드");
            payment.setAmount(1);
            payment.setPrice(lessonReservationPaymentDto.getPrice());
            payMapper.insertPay(payment);

            // 4. 예약 정보 저장
            lessonReservationMapper.insertLessonReservation(lessonReservationPaymentDto);

            // 5. 참가자 수 업데이트
            lesson.setParticipant(lesson.getParticipant() + 1);
            lessonMapper.updateLessonByNo(lesson); // 업데이트 후 커밋

            log.info("레슨 예약 저장 완료: {}", lessonReservationPaymentDto);
        } catch (Exception e) {
            throw new RuntimeException(e);

        }
    }



    @Transactional
    public Lesson getLessonByPayNo(String payNo) {
        return lessonMapper.getLessonByPayNo(payNo);
    }

    public LessonReservation getLessonReservationByNo(int reservationNo) {
        return lessonReservationMapper.getLessonReservationByNo(reservationNo);
    }

}
