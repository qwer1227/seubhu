package store.seub2hu2.course.vo;

import lombok.*;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@Alias("UserLevel")
public class UserLevel {
    // 사용자 코스 레벨 데이터
    private int level; // 현재 도전 가능 단계
//  private User user; // 회원 번호
    private Records records; // 코스 완주 번호
}
