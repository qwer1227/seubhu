package store.seub2hu2.product.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import store.seub2hu2.product.vo.*;

import java.util.List;


@NoArgsConstructor
@ToString
@Setter
@Getter
public class ProdDetailDto {
    private int no;
    private String name;
    private int price;
    private String status;
    private int cnt;
    private double rating;
    private Category category;
    private Brand brand;
}
