package store.seub2hu2.course.vo;

import lombok.*;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@Alias("ReviewImage")
public class ReviewImage {
    // 코스 리뷰 첨부 파일 데이터
    private int no; // 이미지 번호
    private String name; // 이미지 이름
    private Review review; // 리뷰 번호
}
