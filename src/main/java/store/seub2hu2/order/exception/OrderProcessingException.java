package store.seub2hu2.order.exception;

public class OrderProcessingException extends RuntimeException {

    // 주문 처리 중 발생할 수 있는 예외 처리
    public OrderProcessingException(String message) {
        super(message);
    }

    public OrderProcessingException(String message, Throwable cause) {
        super(message, cause);
    }

}
