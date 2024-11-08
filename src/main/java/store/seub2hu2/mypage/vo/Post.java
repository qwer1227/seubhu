package store.seub2hu2.mypage.vo;

import lombok.*;
import org.apache.catalina.User;
import org.apache.ibatis.type.Alias;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Alias("Post")
@Setter
@Getter
@ToString
public class Post {

    private int no;
    private String thumbnail;
    private String postContent;
    private char postDeleted;
    private Date postCreatedDate;
    private User user;

}
