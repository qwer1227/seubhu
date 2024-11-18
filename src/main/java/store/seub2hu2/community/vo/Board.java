package store.seub2hu2.community.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;
import store.seub2hu2.user.vo.User;

import java.util.Date;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Board {
    private int no;
    private String catName;
    private User user;
    private String title;
    private String content;
    private UploadFile uploadFile;
    private Date createdDate;
    private Date updatedDate;
    private int viewCnt;
//    private Scrap scrap; // 구현할때 타입 변경
    private int like;
    private String isDeleted;
    private String isKeep;
    private String insReport;
//    private Hashtag hashtag;
    private List<Reply> reply;

    public String getOriginalFileName() {
        if(uploadFile.getOriginalName() == null){
            return null;
        }
        return uploadFile.getSaveName().substring(13);
    }
}
