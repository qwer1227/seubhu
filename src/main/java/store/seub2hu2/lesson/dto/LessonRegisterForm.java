package store.seub2hu2.lesson.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class LessonRegisterForm {

    @NotBlank(message = "레슨명을 입력해주세요")
    private String title;

    @NotNull(message = "가격을 입력해주세요")
    @Min(value=1, message = "가격은 최소 1 이상이어야 합니다.")
    private Integer price;

    private int lecturerNo;
    private String lecturerId;
    private String subject;
    private String lecturerName;
    private int group;

    @NotBlank(message = "장소를 입력해주세요")
    private String place;

    private String status;

    private String plan;

    @NotNull(message = "썸네일을 등록해주세요")
    private MultipartFile thumbnail;

    private MultipartFile mainImage;

    @NotBlank(message = "시작 날짜는 필수입니다.")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private String startDate;

    @NotBlank(message = "종료 날짜는 필수입니다.")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private String endDate;

    @AssertTrue(message = "시작 날짜는 종료 날짜보다 이전이어야 합니다.", groups = {LessonRegisterForm.class})
    public boolean isStartBeforeEnd() {
        if (startDate == null || endDate == null) {
            return true; // 검증을 넘기기 전에 null 체크를 해주세요.
        }

        try {
            LocalDateTime start = LocalDateTime.parse(startDate, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
            LocalDateTime end = LocalDateTime.parse(endDate, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));

            return start.isBefore(end);
        } catch (Exception e) {
            return false; // 파싱 실패 시 false 반환
        }
    }

    public LocalDateTime getStart() {
        startDate = startDate.replace("T", " ");

        return LocalDateTime.parse(startDate, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
    }

    public LocalDateTime getEnd() {
        endDate = endDate.replace("T", " ");

        return LocalDateTime.parse(endDate, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
    }

}
