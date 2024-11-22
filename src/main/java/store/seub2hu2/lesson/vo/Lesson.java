package store.seub2hu2.lesson.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;
import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;
import store.seub2hu2.user.vo.User;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Alias("Lesson")
public class Lesson {
    private int lessonNo;
    private String title;
    private String subject;
    private int price;
    private int participant;
    private String plan;
    private String status;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date createdDate;
    private Date updatedDate;
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
