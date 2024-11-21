package store.seub2hu2.product.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class Product {

    private int no;
    private String name;
    private String content;
    private double price;
    private int stock;
    private int colorNum;
    private boolean isNew;
    private String status;
    private Date createdAt;
    private Date updatedAt;
    private String imgThum;
    private int cnt;
    private double rating;
    private Category category;
}
