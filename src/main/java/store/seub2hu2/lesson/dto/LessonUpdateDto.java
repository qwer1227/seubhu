package store.seub2hu2.lesson.dto;

import com.fasterxml.jackson.annotation.JsonFormat;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
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

    @NotBlank(message = "레슨명을 입력해주세요")
    private String title;

    private String lecturerId;
    private String subject;
    private String status;
    private int participant;

    @NotBlank(message = "계획을 작성하거나 메인 이미지를 첨부 해주세요.")
    private String plan;

    @NotNull(message = "가격을 입력해주세요")
    @Min(value=1, message = "가격은 최소 1 이상이어야 합니다.")
    private Integer price;

    @NotNull(message = "썸네일 이미지를 첨부 해주세요")
    private MultipartFile thumbnail;

    @NotNull(message = "계획을 작성하거나 메인 이미지를 첨부 해주세요.")
    private MultipartFile mainImage;

    @NotNull(message = "종료 날짜는 필수입니다.")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime start;

    @NotNull(message = "종료 날짜는 필수입니다.")
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
