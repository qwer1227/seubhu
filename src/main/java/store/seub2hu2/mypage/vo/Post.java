package store.seub2hu2.mypage.vo;

import lombok.*;

import org.apache.ibatis.type.Alias;
import store.seub2hu2.user.vo.User;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class Post {

    private int no;
    private byte[] thumbnail;
    private String postContent;
    private char postDeleted;
    private Date postCreatedDate;
    private User user;

}
