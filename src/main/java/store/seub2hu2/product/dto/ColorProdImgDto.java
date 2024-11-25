package store.seub2hu2.product.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import store.seub2hu2.product.vo.Image;
import store.seub2hu2.product.vo.Product;

import java.util.List;

@NoArgsConstructor
@ToString
@Setter
@Getter
public class ColorProdImgDto {

    private int no;
    private String name;
    private Product product;
    private List<Image> images;
}
