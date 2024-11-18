package store.seub2hu2.lesson.dto;

import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public class LessonDto {

    private int lessonNo;
    private String lessonName;
    private MultipartFile attachFile;
    private List<MultipartFile> imageFiles;
}
