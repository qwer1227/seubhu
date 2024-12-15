package store.seub2hu2.product.dto;

import lombok.*;

@ToString
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class ProdReviewDto {

    // 리뷰 정보
    private int reviewNo;
    private String reviewTitle;
    private String reviewContent;
    private int rating;
    private String reviewDate;

    // 리뷰이미지
    private int reviewImgNo;
    private String reviewImg;

    // 상품
    private int prodNo;
    private String prodName;

    // 색상
    private int colorNo;
    private String colorName;

    // 사이즈
    private int sizeNo;
    private String sizeName;

    private int userNo;
    private String userName;
    private String userNickname;
}
