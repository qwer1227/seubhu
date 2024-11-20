package store.seub2hu2.mypage.controller;

import com.fasterxml.jackson.databind.ser.std.MapSerializer;
import org.apache.coyote.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.mypage.service.PostService;
import store.seub2hu2.mypage.vo.Post;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/mypage")
public class MyPageRestController {

    @Autowired
    private PostService postService;

    @GetMapping("/detail/{no}")
    public Post getPostdetail(@PathVariable("no") int no){
        return postService.getPostDetail(no);
    }

    @PutMapping("/detail/delete/{no}")
    public ResponseEntity<Map<String,Object>> deletePost(@PathVariable("no") int no){

        Map<String,Object> response = new HashMap<>();

        try{
            //논리적 삭제 서비스
            boolean isDeleted = postService.deletePost(no);

            if(isDeleted){
                response.put("message", "게시글이 성공적으로 삭제 처리되었습니다.");
                return ResponseEntity.ok(response);
            } else {
                response.put("message", "게시글을 찾을 수 없습니다.");
                return ResponseEntity.status(404).body(response);
            }
        } catch (Exception e){
            e.printStackTrace();
            response.put("message", "서버 오류");
            return ResponseEntity.status(500).body(response);
        }
    }

    @PutMapping("/detail/update/{no}")
    public ResponseEntity<Map<String,Object>> updatePost(@PathVariable("no") int no, //Path로 게시글 ID받기
                                          @RequestParam("content") String content, // 수정할 게시글 내용
                                          @RequestParam(name = "thumbnailImage", required = false) String thumbnailImage, // 수정할 썸네일 이미지
                                          @RequestParam(name = "files", required = false )MultipartFile[] files
                                             ) {
        Map<String, Object> response = new HashMap<>();

        try {
            // 수정할 게시글을 서비스로 전달
            boolean isUpdated = postService.updatePost(no,content,thumbnailImage,files);

            if (isUpdated) {
                response.put("message", "게시글 수정 성공");
                return ResponseEntity.ok(response);
            } else {
                response.put("message", "게시글을 찾을 수 없습니다");
                return ResponseEntity.status(404).body(response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.put("message", "서버 오류");
            return ResponseEntity.status(500).body(response);
        }
    }
}
