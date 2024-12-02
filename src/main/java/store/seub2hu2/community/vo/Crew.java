package store.seub2hu2.community.vo;

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
public class Crew {

    private int no;
    private String name;
    private String schedule;
    private String location;
    private String title;
    private String description;
    private Date createdDate;
    private Date updatedDate;
    private boolean deleted;
    private boolean joined;
    private UploadFile thumbnail;
    private UploadFile uploadFile;
}
