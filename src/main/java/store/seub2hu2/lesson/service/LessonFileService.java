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
import store.seub2hu2.util.WebContentFileUtils;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class LessonFileService {

    private final WebContentFileUtils webContentFileUtils;

    @Value("${upload.directory.lesson}")
    private String saveDirectory;

    private final LessonFileMapper lessonFileMapper;

    public void saveLessonImages(Integer lessonNo, MultipartFile thumbnail, MultipartFile mainImage)  {
        System.out.println("saveLessonImages lessonNo: " + lessonNo);

        if (thumbnail != null && !thumbnail.isEmpty()) {
            String thumbnailFileName = UUID.randomUUID() + thumbnail.getOriginalFilename();
            webContentFileUtils.saveWebContentFile(thumbnail, saveDirectory, thumbnailFileName);
            LessonFile thumbnailFile = new LessonFile(
                    lessonNo, thumbnailFileName , "THUMBNAIL", saveDirectory
            );
            lessonFileMapper.insertLessonFile(thumbnailFile);
        }

        if (mainImage != null && !mainImage.isEmpty()) {
            String mainImageFileName = UUID.randomUUID() + mainImage.getOriginalFilename();
            webContentFileUtils.saveWebContentFile(mainImage, saveDirectory, mainImageFileName);
            LessonFile mainImageFile = new LessonFile(
                    lessonNo,  mainImageFileName, "MAIN_IMAGE", saveDirectory
            );
            lessonFileMapper.insertLessonFile(mainImageFile);
        }
    }

    // lessonNo에 맞는 이미지 파일 정보 가져오기
    public Map<String, String> getImagesByLessonNo(int lessonNo) {
        List<LessonFile> lessonFiles = lessonFileMapper.getImagesByLessonNo(lessonNo);

        // 썸네일과 본문 이미지 경로를 Map으로 구분하여 반환
        Map<String, String> images = new HashMap<>();
        for (LessonFile file : lessonFiles) {
            if ("THUMBNAIL".equals(file.getFileType())) {
                images.put("THUMBNAIL", file.getFileName());
                log.info("THUMBNAIL = {}", file.getFileName());
            } else if ("MAIN_IMAGE".equals(file.getFileType())) {
                images.put("MAIN_IMAGE",  file.getFileName());
                log.info("MAIN_IMAGE = {}",  file.getFileName());
            }
        }

        log.info("썸네일 = {}", images.get("THUMBNAIL"));
        log.info("본문 = {}", images.get("MAIN_IMAGE"));

        return images;
    }




}
