package store.seub2hu2.mypage.dto;

import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class CommentRequest {
    private int postId;
    private String postComment;
    private int userNo;
}
