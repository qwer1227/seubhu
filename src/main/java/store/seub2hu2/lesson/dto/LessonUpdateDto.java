package store.seub2hu2.lesson.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.user.vo.User;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class LessonUpdateDto {

    private int lessonNo;
    private String title;
    private String lecturerId;
    private String subject;
    private String status;
    private int participant;
    private String plan;
    private int price;
    private MultipartFile thumbnail;
    private MultipartFile mainImage;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime start;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime end;

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
}
