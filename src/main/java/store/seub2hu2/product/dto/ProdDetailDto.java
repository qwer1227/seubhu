package store.seub2hu2.product.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import store.seub2hu2.product.vo.Category;
import store.seub2hu2.product.vo.Image;

import java.util.Date;
import java.util.List;


@NoArgsConstructor
@ToString
@Setter
@Getter
public class ProdDetailDto {
    private int no;
    private String name;
    private double price;
    private int stock;
    private boolean isNew;
    private String status;
    private Date createdAt;
    private Date updatedAt;
    private List<Image> images;
    private int cnt;
    private double rating;
    private Category category;

}
