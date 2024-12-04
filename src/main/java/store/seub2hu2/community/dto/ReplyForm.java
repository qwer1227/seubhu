package store.seub2hu2.community.dto;

import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import store.seub2hu2.user.vo.User;

@NoArgsConstructor
@Getter
@Setter
public class ReplyForm {

    private int boardNo;
    private int crewNo;
    private int userNo;
    private int no;
    private int prevNo;
    @NotEmpty(message = "댓글 내용은 필수입력 항목입니다.")
    private String content;
    private String deleted;
}
