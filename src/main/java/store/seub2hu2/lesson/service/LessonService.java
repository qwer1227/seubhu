package store.seub2hu2.lesson.service;

import lombok.RequiredArgsConstructor;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import store.seub2hu2.lesson.dto.LessonRegisterForm;
import store.seub2hu2.lesson.dto.ReservationSearchCondition;
import store.seub2hu2.lesson.mapper.LessonFileMapper;
import store.seub2hu2.lesson.mapper.LessonMapper;
import store.seub2hu2.lesson.vo.*;

import java.text.SimpleDateFormat;
import java.util.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class LessonService {

    @Value("${file.upload-dir}")
    private String saveDirectory;

    private final LessonMapper lessonMapper;
    private final LessonFileMapper lessonFileMapper;
    private final LessonFileService lessonFileService;

    public List<Lesson> getAllLessons(Map<String, Object> param, String course) {
        return lessonMapper.getAllLessons(param, course);
    }

    public Lesson getLessonByNo(int lessonNo) {
        return lessonMapper.getLessonByNo(lessonNo);
    }

    public List<LessonReservation> getLessonsByUserNo(int userNo) {
        return lessonMapper.getLessonReservationByUserNo(userNo);
    }

    public void addNewLesson(Lesson lesson) {
        lessonMapper.insertLesson(lesson);
    }


    // lessonNo에 맞는 이미지 파일 정보 가져오기
    public Map<String, String> getImagesByLessonNo(int lessonNo) {
        List<LessonFile> lessonFiles = lessonFileMapper.getImagesByLessonNo(lessonNo);

        // 썸네일과 본문 이미지 경로를 Map으로 구분하여 반환
        Map<String, String> images = new HashMap<>();
        for (LessonFile file : lessonFiles) {
            if ("THUMBNAIL".equals(file.getFileType())) {
                images.put("THUMBNAIL", file.getFileName());
                log.info("THUMBNAIL = {}", file.getFileName());
            } else if ("MAIN_IMAGE".equals(file.getFileType())) {
                images.put("MAIN_IMAGE",  file.getFileName());
                log.info("MAIN_IMAGE = {}",  file.getFileName());
            }
        }
        return images;
    }


    public void registerLesson(Lesson lesson, LessonRegisterForm form) {
        // Convert LessonRegisterForm to Lesson

        lessonMapper.insertLesson(lesson); // Save lesson details and generate lessonNo

        // Save thumbnail and main images
        lessonFileService.saveLessonImages(getMostLatelyLessonNo(), form.getThumbnail(), form.getMainImage());

    }

    public int getMostLatelyLessonNo() {
        return lessonFileMapper.lastInsertedLessonNo();
    }


    public List<LessonReservation> searchLessonReservationList(ReservationSearchCondition condition, int userNo) {
        // startDate, endDate 기본값 설정 (현재 날짜 기준 한 달)
        if (condition.getStartDate() == null || condition.getEndDate() == null) {
            Calendar calendar = Calendar.getInstance();

            // endDate 기본값: 현재 날짜
            if (condition.getEndDate() == null) {
                condition.setEndDate(calendar.getTime());
            }

            // startDate 기본값: 한 달 전
            if (condition.getStartDate() == null) {
                calendar.add(Calendar.MONTH, -1);
                condition.setStartDate(calendar.getTime());
            }
        }

        // MyBatis 매퍼 호출
        return lessonMapper.getReservationByCondition(condition, userNo);
    }
}
