package store.seub2hu2.mypage.vo;

import lombok.*;
import org.apache.catalina.User;
import org.apache.ibatis.type.Alias;

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
}
