package store.seub2hu2.lesson.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;
import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.user.vo.User;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Alias("Lesson")
public class Lesson {
    private int lessonNo;
    private String title;
    private String category;
    private int price;
    private int participant;
    private String plan;
    private String status;
    private Date createdDate;
    private Date updatedDate;
    private Date startDate;
    private Date endDate;
    private User lecturer;
    private String filename;



    public String getOriginalFilename() {
        if (filename == null) {
            return null;
        }
        return filename.substring(13);
    }


    @JsonFormat(pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date start;

    @JsonFormat(pattern = "yyyy-MM-dd")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date end;


}
