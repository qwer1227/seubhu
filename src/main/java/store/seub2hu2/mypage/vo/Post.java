package store.seub2hu2.mypage.vo;

import lombok.*;

import org.apache.ibatis.type.Alias;
import store.seub2hu2.user.vo.User;

import java.util.Arrays;
import java.util.Base64;
import java.util.Date;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
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
    private List<PostImage> images;
}
