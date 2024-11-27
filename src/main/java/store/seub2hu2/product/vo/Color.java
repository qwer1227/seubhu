package store.seub2hu2.product.vo;

import lombok.*;

@ToString
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class Color {

    private int no; // 색상 번호
    private String name; // 색상명
    private Product product; // 객체
}
