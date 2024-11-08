package store.seub2hu2.product.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class Product {

    private int no;
    private String name;
    private double price;
    private int stock;
    private boolean isNew;
    private String status;
    private String thumbImg;
    private Category category;
}
