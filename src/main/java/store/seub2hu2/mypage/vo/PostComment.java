package store.seub2hu2.mypage.vo;

import lombok.*;
import org.apache.ibatis.type.Alias;
import store.seub2hu2.user.vo.User;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Alias("PostComment")
@ToString
public class PostComment {

    private int no;
    private String commentText;
    private Date createdDate;
    private Post post;
    private User user;
    private PostComment postComment;
    private String commentUserName; // 댓글 작성자의 이름을 저장할 필드 추가
}
