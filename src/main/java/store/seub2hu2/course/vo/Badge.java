package store.seub2hu2.course.vo;

import lombok.*;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@Alias("Badge")
public class Badge {
    // 배지 데이터
    private int no; // 배지 번호
    private String name; // 배지 이름
    private String description; // 배지 설명
    private String image; // 배지 이미지
}