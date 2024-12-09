package store.seub2hu2.community.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Marathon {

    private int no;
    private String thumbnail;
    private String title;
    private String content;
    private Date marathonDate;
    private Date startDate;
    private Date endDate;
    private String url;
    private String place;
    private String deleted;
    private UploadFile uploadFile;
    private List<MarathonOrgan> organ;
    private Date createdDate;
    private Date updatedDate;
    private int viewCnt;

    public String getOriginalFileName() {
        if(uploadFile.getSaveName() == null){
            return null;
        }
        return uploadFile.getSaveName().substring(13);
    }
}
