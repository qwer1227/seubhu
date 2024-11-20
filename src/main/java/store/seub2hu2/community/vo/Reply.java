package store.seub2hu2.community.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import store.seub2hu2.user.vo.User;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Reply {
    private int no;
    private int prevNo;
    private int boardNo;
    private String content;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date createdDate;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date updatedDate;
    private int userNo;
    private String report;
    private int replyLike;
    private String deleted;
}
