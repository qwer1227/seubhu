package store.seub2hu2.course.vo;

import lombok.*;
import org.apache.ibatis.type.Alias;
import store.seub2hu2.user.vo.User;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Records {
    // 코스 완주 기록 데이터
    private int no; // 코스 완주 번호
    private Date finishedDate; // 코스 완주 날짜
    private int finishedTime; // 코스 완주 시간
    private User user; // 회원 번호
    private Course course; // 코스 번호
}
