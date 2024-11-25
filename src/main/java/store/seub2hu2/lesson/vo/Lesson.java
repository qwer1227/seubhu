package store.seub2hu2.lesson.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;
import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;
import store.seub2hu2.user.vo.User;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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
    private LocalDateTime createdDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDateTime updatedDate;
    private User lecturer;
    private String filename;


    public String getOriginalFilename() {
        if (filename == null) {
            return null;
        }
        return filename.substring(13);
    }


    public String getStartDate() {
        return LocalDateTime.from(start).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
    }

    public String getStartTime() {
        return LocalDateTime.from(start).format(DateTimeFormatter.ofPattern("HH:mm"));
    }

    public String getEndDate() {
        return LocalDateTime.from(end).format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
    }

    public String getEndTime() {
        return LocalDateTime.from(end).format(DateTimeFormatter.ofPattern("HH:mm"));
    }


    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime start;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime end;


}
