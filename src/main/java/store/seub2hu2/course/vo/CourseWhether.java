package store.seub2hu2.course.vo;

import lombok.*;
import store.seub2hu2.user.vo.User;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class CourseWhether {
    // 코스 도전 및 성공 여부
    private String isRegister; // 코스 도전 등록 여부
    private String isSuccess; // 코스 성공 여부
    private Course course; // 코스 번호
    private User user; // 회원 번호
}
