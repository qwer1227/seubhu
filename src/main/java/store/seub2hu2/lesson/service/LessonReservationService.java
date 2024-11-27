package store.seub2hu2.lesson.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.lesson.dto.ReservationSearchCondition;
import store.seub2hu2.payment.dto.PaymentDto;
import store.seub2hu2.lesson.mapper.LessonMapper;
import store.seub2hu2.lesson.mapper.LessonReservationMapper;
import store.seub2hu2.payment.mapper.PayMapper;
import store.seub2hu2.lesson.vo.Lesson;
import store.seub2hu2.lesson.vo.LessonReservation;
import store.seub2hu2.payment.vo.Payment;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class LessonReservationService {

    private final LessonMapper lessonMapper;
    private final LessonReservationMapper lessonReservationMapper;
    private final PayMapper payMapper;

    @Transactional(isolation = Isolation.READ_COMMITTED)
    public void saveLessonReservation(PaymentDto paymentDto) {
        try {
            // 1. 레슨 정보 조회
            Lesson lesson = lessonMapper.getLessonByNo(paymentDto.getLessonNo());
            log.info("saveLessonReservation에서 사용되는 paymentDto = {}", paymentDto);

            if (lesson == null) {
                throw new RuntimeException("존재하지 않는 레슨입니다. LessonNo: " + paymentDto.getLessonNo());
            }

            log.info("레슨 예약 시도: {}", paymentDto);
            log.info("현재 참가자 수: {}", lesson.getParticipant());

            // 2. 참가자 수 초과 여부 확인
            if (lesson.getParticipant() >= 5) {
                throw new RuntimeException("예약 정원 마감. LessonNo: "
                        + lesson.getLessonNo() + ", Current participants: " + lesson.getParticipant());
            }

            // 3. 결제 정보 저장
            Payment payment = new Payment();
            payment.setId(paymentDto.getPayId());
            payment.setUserNo(paymentDto.getUserNo());
            payment.setStatus("결제완료");
            payment.setType("레슨");
            payment.setMethod("카드");
            payment.setAmount(1);
            payment.setPrice(paymentDto.getTotalAmount());
            log.info("결제 정보 저장 Payment = {}", payment);
            payMapper.insertPay(payment);

            // 4. 예약 정보 저장
            lessonReservationMapper.insertLessonReservation(paymentDto);

            // 5. 참가자 수 업데이트
            log.info("참가자 수 업데이트 할 lesson = {}", lesson);
            lesson.setParticipant(lesson.getParticipant() + 1);
            lessonMapper.updateLessonByNo(lesson); // 업데이트 후 커밋

            log.info("레슨 예약 저장 완료: {}", paymentDto);
        } catch (Exception e) {
            throw new RuntimeException(e);

        }
    }

    public LessonReservation getLessonReservationByPayId(String payId) {
        return lessonReservationMapper.getLessonReservationByPayId(payId);
    }

    public LessonReservation getLessonReservationByNo(int reservationNo) {
        return lessonReservationMapper.getLessonReservationByNo(reservationNo);
    }

    public List<LessonReservation> searchLessonReservationList(ReservationSearchCondition condition, int userNo) {
        // 기본 날짜 포맷 정의
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        // startDate와 endDate 초기화 및 기본값 설정
        if (condition.getStart() == null) {
            if (condition.getStartDate() != null && !condition.getStartDate().isEmpty()) {
                condition.setStart(LocalDateTime.parse(condition.getStartDate(), formatter));
            } else {
                condition.setStart(LocalDateTime.now().minusMonths(1)); // 기본값: 한 달 전
            }
        }

        if (condition.getEnd() == null) {
            if (condition.getEndDate() != null && !condition.getEndDate().isEmpty()) {
                condition.setEnd(LocalDateTime.parse(condition.getEndDate(), formatter));
            } else {
                condition.setEnd(LocalDateTime.now()); // 기본값: 현재 날짜
            }
        }

        // MyBatis 매퍼 호출
        return lessonReservationMapper.getReservationByCondition(condition, userNo);
    }


}
