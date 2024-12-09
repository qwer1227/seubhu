package store.seub2hu2.order.exception;

public class OutOfStockException extends RuntimeException {
    
    // 재고 수량 없을 때
    public OutOfStockException(String message) {
        super(message);
    }
    
    public OutOfStockException(String message, Throwable cause) {
        super(message, cause);
    }
}
