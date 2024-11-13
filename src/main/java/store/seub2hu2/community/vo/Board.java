package store.seub2hu2.community.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;
import store.seub2hu2.user.vo.User;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Board {
    private int no;
    private String catName;
    private BoardCategory category;
    private User user;
    private String title;
    private String content;
    private String filename;
    private Date createdDate;
    private Date updatedDate;
    private int viewCnt;
    private Scrap scrap;
    private int like;
    private String isDeleted;
    private String isKeep;
    private String insReport;
    private Hashtag hashtag;
    private Reply reply;

    public String getOriginalFileName() {
        if(filename == null){
            return null;
        }
        return filename.substring(13);
    }
}
