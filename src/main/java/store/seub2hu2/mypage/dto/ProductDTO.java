package store.seub2hu2.mypage.dto;

import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@ToString
@Getter
@Setter
public class ProductDTO {
    private String prodName;
    private int sizeNo;
    private String sizeName;
    private int colorNo;
    private String colorName;
    private int orderQty;
    private int prodPrice;
    private String prodImgUrl;
}
