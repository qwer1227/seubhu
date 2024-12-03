package store.seub2hu2.lesson.scheduler;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import store.seub2hu2.lesson.service.LessonService;

@Component
public class LessonStatusScheduler {

    private final LessonService lessonService;

    public LessonStatusScheduler(LessonService lessonService) {
        this.lessonService = lessonService;
    }

    // 매일 자정 실행
    @Scheduled(cron = "0 0 0 * * ?")
    public void scheduleLessonStatusUpdate() {
        lessonService.updatePastLessons();
        System.out.println("스케줄러 실행: 지난 레슨 상태 업데이트 완료");
    }

}
