package store.seub2hu2.course.vo;

import lombok.*;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@Alias("ChallengeCounts")
public class ChallengeCounts {
    // 코스 도전 및 성공 횟수
    private int challengeCnt; // 코스 도전 횟수
    private int successCnt; // 코스 성공 횟수
//  private User user; // 회원 번호
    private Course course; // 코스 번호
}
