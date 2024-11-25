package store.seub2hu2.product.dto;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import store.seub2hu2.product.vo.Color;
import store.seub2hu2.product.vo.Image;

import java.util.List;

@NoArgsConstructor
@ToString
@Setter
@Getter
public class ProdImagesDto {

    private int no;
    private String name;
    private Color color;
    private List<Image> images;
}
