package store.seub2hu2.product.enums;

import lombok.Getter;

@Getter
public enum ProductTopNo {
    MEN(10), WOMEN(20), SUPLIES(30);

    private final Integer categories;

    ProductTopNo(Integer categories) {
        this.categories = categories;
    }

}
