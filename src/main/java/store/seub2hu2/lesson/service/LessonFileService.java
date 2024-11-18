package store.seub2hu2.lesson.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.lesson.mapper.LessonFileMapper;
import store.seub2hu2.lesson.mapper.LessonMapper;
import store.seub2hu2.lesson.vo.LessonFile;
import store.seub2hu2.util.FileUtils;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class LessonFileService {

    @Value("${file.upload-lesson-dir}")
    private String saveDirectory;

    private final LessonMapper lessonMapper;
    private final LessonFileMapper lessonFileMapper;

    public void saveLessonImages(Integer lessonNo, MultipartFile thumbnail, MultipartFile mainImage)  {
        System.out.println("saveLessonImages lessonNo: " + lessonNo);

        if (thumbnail != null && !thumbnail.isEmpty()) {
            String thumbnailFileName = FileUtils.saveMultipartFile(thumbnail, saveDirectory);
            LessonFile thumbnailFile = new LessonFile(
                    lessonNo, thumbnailFileName, "THUMBNAIL", saveDirectory
            );
            lessonFileMapper.insertLessonFile(thumbnailFile);
        }

        if (mainImage != null && !mainImage.isEmpty()) {
            String mainImageFileName = FileUtils.saveMultipartFile(mainImage, saveDirectory);
            LessonFile mainImageFile = new LessonFile(
                    lessonNo, mainImageFileName, "MAIN_IMAGE", saveDirectory
            );
            lessonFileMapper.insertLessonFile(mainImageFile);
        }


    }

//    public Map<String, LessonFile> findLessonImagesByLessonNo(Integer lessonNo) {
//        List<LessonFile> lessonFiles = lessonFileMapper.getImagesByLessonNo(lessonNo);
//        Map<String, LessonFile> lessonFileMap = new HashMap<>();
//        for (LessonFile lessonFile : lessonFiles) {
//            if (lessonFile.getFileType().equals("THUMBNAIL")) {
//                LessonFile thumbnailFile = new LessonFile(
//                        lessonNo, lessonFile.getFileName(), "THUMBNAIL", lessonFile.getFilePath()
//                );
//                lessonFileMap.put("THUMBNAIL", thumbnailFile);
//            }
//
//            if (lessonFile.getFileType().equals("MAIN_IMAGE")) {
//                LessonFile mainImageFile = new LessonFile(
//                        lessonNo, lessonFile.getFileName(), "MAIN_IMAGE", saveDirectory
//                );
//                lessonFileMap.put("MAIN_IMAGE", mainImageFile.getFilePath() + "/" + mainImageFile.getFileName());
//            }
//        }
//
//
//        return lessonFileMap;
//    }
}
