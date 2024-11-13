package store.seub2hu2.mypage.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.parameters.P;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.beans.factory.annotation.Autowired;
import store.seub2hu2.mypage.service.FileUploadService;
import store.seub2hu2.mypage.service.PostService;
import store.seub2hu2.mypage.vo.Post;

import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@RestController
@RequestMapping("/mypage")
public class FileUploadRestController {

    @Autowired
    private FileUploadService fileUploadService;

    @Autowired
    private PostService postService;

    @PostMapping("/public/insert")
    public void insertPost(@RequestParam("content") String postContent, @RequestParam("thumbnailImage") String thumb){

        thumb = thumb.replaceFirst("data:image/[^;]+;base64,", "");
        // Base64로 인코딩된 문자열을 byte[]로 디코딩
        byte[] thumbnailBytes = Base64.getDecoder().decode(thumb);


        Post post = new Post();
        post.setPostContent(postContent);
        post.setThumbnail(thumbnailBytes);

        postService.insertPost(post);

    }

    @PostMapping("/public/upload")
    public ResponseEntity<Map<String, Object>> uploadFiles(@RequestParam("files") List<MultipartFile> files,
                                                           @RequestParam("postNo") int postNo) {

        if (files.size() > 5) {
            return ResponseEntity.badRequest().body(Map.of("message", "최대 5개의 파일만 업로드할 수 있습니다."));
        }

        try {
            // 파일 업로드 후 썸네일 파일명 얻기
            String thumbnailFilename = fileUploadService.saveFile(files, postNo);

            // 성공적으로 업로드된 파일 정보 반환
            Map<String, Object> response = new HashMap<>();
            response.put("message", "파일 업로드 성공");
            response.put("thumbnail", thumbnailFilename);  // 썸네일 파일명 반환

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of("message", "파일 업로드 실패: " + e.getMessage()));
        }
    }

}
