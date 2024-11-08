package store.seub2hu2.lesson.enums;

public enum lessonStatus {
    RECRUITMENT("모집중"),
    CLOSE("마감"),
    END("종료");

    private String status;

    private lessonStatus(String name) {
        this.status = name;
    }

}
