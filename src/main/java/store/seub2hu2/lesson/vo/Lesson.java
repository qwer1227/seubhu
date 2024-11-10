package store.seub2hu2.lesson.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;
import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.user.vo.User;

import java.time.LocalDateTime;
import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Alias("Lesson")
public class Lesson {
    private int lessonNo;
    private String title;
    private int price;
    private int participant;
    private String plan;
    private String status;
    private Date createdDate;
    private Date updatedDate;
    private User lecturer;

//    private UploadFile thumbnail;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date start;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date end;

//    private User user;
}
