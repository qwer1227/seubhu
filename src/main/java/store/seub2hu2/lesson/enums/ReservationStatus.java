package store.seub2hu2.lesson.enums;

public enum ReservationStatus {
    COMPLETED("예약", 1),
    CANCELLED("취소", 2),
    REFUND("환불", 3);

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