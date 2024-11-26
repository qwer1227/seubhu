package store.seub2hu2.mypage.dto;

import lombok.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class CommentResponse {
    private int postNo;
    private int commentNo;
    private String commentText;
    private String authorName;
    private Date createdDate;
    private Integer replyCommentNo;
    private List<CommentResponse> replies;

    // replies가 null인 경우 새로 생성하여 추가
    public void addReply(CommentResponse reply) {
        if (this.replies == null) {
            this.replies = new ArrayList<>();
        }
        this.replies.add(reply);  // 대댓글을 replies 리스트에 추가
    }

}
