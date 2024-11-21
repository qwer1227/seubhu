package store.seub2hu2.product.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import store.seub2hu2.product.vo.*;



@NoArgsConstructor
@ToString
@Setter
@Getter
public class ProdDetailDto {
    private int no;
    private String name;
    private String content;
    private int price;
    private String status;
    private int cnt;
    private double rating;
    private int colorNum;
    private Category category;
    private Brand brand;
}
