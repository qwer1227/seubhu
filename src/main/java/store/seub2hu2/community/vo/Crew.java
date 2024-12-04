package store.seub2hu2.community.vo;

import lombok.*;
import store.seub2hu2.user.vo.User;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Crew {

    private int no;
    private int fileNo;
    private String name;
    private String schedule;
    private String type;
    private String detail;
    private String location;
    private String title;
    private String description;
    private Date createdDate;
    private Date updatedDate;
    private String deleted;
    private String joined;
    private UploadFile thumbnail;
    private UploadFile uploadFile;
    private User user;
    private int viewCnt;

    public String getType(){
        return schedule.substring(0,2);
    }

    public String getDetail(){
        return schedule.substring(3);
    }
}
