package store.seub2hu2.community.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Notice {
    private int no;
    private String category;
    private String title;
    private String content;
    private Date createdDate;
    private Date updatedDate;
    private String first;
    private String isDeleted;
    private int viewCnt;
}
