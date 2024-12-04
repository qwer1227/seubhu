package store.seub2hu2.lesson.enums;

public enum ReservationStatus {
    COMPLETED("완료", 1),
    RESERVATION("예약", 2),
    CANCELLED("취소", 3),
    REFUND("환불", 4);

    private final String label;
    private final int value;

    ReservationStatus(String label, int value) {
        this.label = label;
        this.value = value;
    }


    public String label() {
        return label;
    }

    public int value() {
        return value;
    }


}
