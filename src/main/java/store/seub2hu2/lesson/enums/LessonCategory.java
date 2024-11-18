package store.seub2hu2.lesson.enums;


public enum LessonCategory {
    POSTURE("자세"),
    BREATH("호흡"),
    EXERCISE( "운동");

    private final String label;

    LessonCategory(String label) {
        this.label = label;
    }

    public String label() {
        return label;
    }

}
