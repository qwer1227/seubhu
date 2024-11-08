package store.seub2hu2.lesson.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;
import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Alias("Lesson")
public class Lesson {
    private int no;
    private String title;
    private int price;
    private String plan;
    private String status;
    private Date createdDate;
    private Date updatedDate;
    private MultipartFile thumbnail;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date start;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date end;

//    private User user;
}
