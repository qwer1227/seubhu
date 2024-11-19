package store.seub2hu2.mypage.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.beans.factory.annotation.Autowired;
import store.seub2hu2.mypage.service.FileUploadService;
import store.seub2hu2.mypage.service.PostService;
import store.seub2hu2.mypage.vo.Post;

import java.util.*;


@RestController
@RequestMapping("/mypage")
public class FeedRestController {

    @Autowired
    private FileUploadService fileUploadService;

    @Autowired
    private PostService postService;

    /*@PostMapping("/public/insert")
    public ResponseEntity<Map<String, Object>> insertPost(@RequestParam("content") String postContent,
                                                          @RequestParam("thumbnailImage") String thumb,
                                                          @RequestParam("files") List<MultipartFile> files) {
     *//*   try {
            // 1. 썸네일 이미지 처리
            //thumb = thumb.replaceFirst("data:image/[^;]+;base64,", "");
            //System.out.println("Before decoding: " + thumb);
            //byte[] thumbnailBytes = Base64.getDecoder().decode(thumb);
            //System.out.println("After decoding: " + Arrays.toString(thumbnailBytes));

            // 2. 게시글 생성
            Post post = new Post();
            post.setPostContent(postContent);
            post.setThumbnail(thumb);
            int postNo = postService.insertPost(post);  // 게시글 생성 후 postNo 반환

            // 3. 파일 업로드 및 이미지 연결
            Map<String, Object> fileResponse = fileUploadService.saveFile(files, postNo, thumb);  // postNo와 함께 이미지 업로드

            // 4. 응답 반환
            Map<String, Object> response = new HashMap<>();
            response.put("message", "포스트 생성 완료");
            response.put("PostNo", postNo);
            response.put("thumbnailFilename", fileResponse.get("thumbnailFilename"));
            return ResponseEntity.ok(response);

        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of("message", "포스트 생성 실패: " + e.getMessage()));
        }
    }

      */
}


