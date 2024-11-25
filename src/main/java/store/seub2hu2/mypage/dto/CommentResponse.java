package store.seub2hu2.mypage.dto;

import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class CommentResponse {
    private int commentNo;
    private String commentText;
    private String authorName;
    private String createdDate;
}
