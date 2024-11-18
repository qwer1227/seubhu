package store.seub2hu2.product.enums;

public enum ProductCategories {
    MEN(10),
    WOMEN(20),
    SUPPLIES(30);

    private final Integer topNo;

    ProductCategories(final Integer topNo) {
        this.topNo = topNo;
    }

    public Integer getValue() {
        return topNo;
    }
}
