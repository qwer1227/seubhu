package store.seub2hu2.lesson.dto;

import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class LessonDto {

    private int lessonNo;
    private String title;
    private String name;
    private String lecturerName;
    private String subject;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private String startDate;
    private int price;
}
