package store.seub2hu2.product.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import store.seub2hu2.product.vo.Category;
import store.seub2hu2.product.vo.Image;

import java.util.Date;
import java.util.List;
import java.util.Map;

@NoArgsConstructor
@ToString
@Setter
@Getter
public class ProdListDto {

    private int no;
    private String name;
    private int price;
    private String status;
    private Date createdAt;
    private String imgThum;
    private Category category;

}
