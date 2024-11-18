package store.seub2hu2.mypage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.mypage.mapper.PostMapper;
import store.seub2hu2.util.FileUtils;

import java.io.File;
import java.io.IOException;
import java.util.*;

@Service
public class FileUploadService {

    @Value("${file.upload-dir}")
    private String uploadDir;

    @Autowired
    private PostMapper postMapper;

    public String saveFile(List<MultipartFile> files, int postNo) throws IOException {
        List<Map<String, Object>> images = new ArrayList<>();
        String thumbnailFilename = null;  // 썸네일 파일명

        // 파일 저장 디렉토리가 존재하지 않으면 생성
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();  // 디렉토리 생성
        }

        for (MultipartFile file : files) {
            // 파일 확장자 추출
            String originalFilename = file.getOriginalFilename();
            String fileExtension = originalFilename != null ? originalFilename.substring(originalFilename.lastIndexOf(".")) : ".jpg"; // 확장자 기본값 설정

            // 파일 크기 검증 (예: 10MB 이하로 제한)
            long maxSize = 10 * 1024 * 1024; // 10MB
            if (file.getSize() > maxSize) {
                throw new IllegalArgumentException("파일 크기가 너무 큽니다.");
            }

            // 파일 형식 검증 (예: 이미지 파일만 허용)
            List<String> allowedExtensions = Arrays.asList(".jpg", ".jpeg", ".png", ".gif");
            if (!allowedExtensions.contains(fileExtension)) {
                throw new IllegalArgumentException("허용되지 않는 파일 형식입니다.");
            }

            // 현재 시간을 기준으로 파일명 생성 (중복 방지용 UUID 추가)
            String filename = System.currentTimeMillis() + "_" + UUID.randomUUID().toString() + fileExtension;

            // 파일 저장
            FileUtils.saveMultipartFile(file, uploadDir, filename);

            String fileUrl = "/upload/" + filename;

            // 첫 번째 이미지를 썸네일로 설정 (예시로 첫 번째 파일을 썸네일로 설정)
            if (thumbnailFilename == null) {
                thumbnailFilename = filename;
            }

            // 각 파일 정보를 저장할 Map 객체 생성
            Map<String, Object> param = new HashMap<>();
            param.put("imageUrl", fileUrl);
            param.put("postNo", postNo);
            images.add(param);
        }

        // MyBatis 매퍼를 사용해 DB에 데이터 삽입
        postMapper.insertPostImages(images);

        // 썸네일로 사용할 파일명을 반환
        return thumbnailFilename;
    }
}

