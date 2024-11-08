package store.seub2hu2.lesson.dto;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

public class LessonDateDto {
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date start;
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date end;
}
