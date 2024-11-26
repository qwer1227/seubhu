package store.seub2hu2.mypage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.mypage.dto.CommentRequest;
import store.seub2hu2.mypage.dto.CommentResponse;
import store.seub2hu2.mypage.dto.ImageDeleteRequest;
import store.seub2hu2.mypage.service.FileUploadService;
import store.seub2hu2.mypage.service.PostService;
import store.seub2hu2.mypage.vo.Post;
import store.seub2hu2.user.service.UserService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@RestController
@RequestMapping("/mypage")
public class MyPageRestController {

    @Autowired
    private PostService postService;

    @Autowired
    private FileUploadService fileUploadService;
    @Autowired
    private UserService userService;

    @PostMapping("/public/insert")
    public ResponseEntity<Map<String, Object>> insertPost(@RequestParam("content") String postContent,
                                                          @RequestParam("thumbnailImage") String thumb,
                                                          @RequestParam("files") List<MultipartFile> files) {
        try {
            // 1. 게시글 생성
            Post post = new Post();
            post.setPostContent(postContent);
            post.setThumbnail(thumb);
            int postNo = postService.insertPost(post);  // 게시글 생성 후 postNo 반환
//            post.setNo(postNo);

            // 2. 파일 업로드 및 이미지 연결
            fileUploadService.saveFile(files, postNo,thumb);  // postNo와 함께 이미지 업로드

            // 3. 응답 반환
            Map<String, Object> response = new HashMap<>();
            response.put("message", "포스트 생성 완료");
            response.put("PostNo", postNo);
            response.put("thumb", thumb);
            return ResponseEntity.ok(response);

        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of("message", "포스트 생성 실패: " + e.getMessage()));
        }
    }

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

    @DeleteMapping("/detail/imagedelete/{no}")
    public ResponseEntity<Map<String,Object>> deleteImage(@PathVariable("no") int postNo,
                                              @RequestBody ImageDeleteRequest request) {

        Map<String, Object> response = new HashMap<>();

        try{
            int imageNo = request.getImageNo();
            boolean isDeleted = postService.imageDelete(imageNo);

            if(isDeleted) {
                response.put("message", "삭제성공");
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


    @PostMapping("/detail/comment")
    public ResponseEntity<Map<String,Object>> addComment(@RequestBody CommentRequest request) {

        Map<String, Object> response = new HashMap<>();

        try {
            int postId = request.getPostId();
            int userNo = request.getUserNo();

            String userName = postService.getUserNameByUserNo(userNo);
            if (userName == null) {
                response.put("message", "로그인 후 이용 바랍니다.");
                return ResponseEntity.status(404).body(response);
            }
            boolean isInserted = postService.commentInsert(request, userName);
            if (isInserted) {
                response.put("message", "댓글작성성공");
                //todo 리스폰스DTO를 활용해서 수정/입력/삭제 될때 새로고침해서 클라이언트에게 보내주는 작업이 필요함
                List<CommentResponse> commentResponse = postService.getCommentsByPostNo(postId);

                if (!commentResponse.isEmpty()) {
                    response.put("message", "댓글작성성공이후 갱신된값");

                    // 댓글 리스트를 계층 구조로 묶기
                    List<CommentResponse> resultComments = new ArrayList<>();
                    Map<Integer, CommentResponse> commentMap = new HashMap<>();

                    for (CommentResponse comment : commentResponse) {
                        // 댓글을 Map에 추가
                        commentMap.put(comment.getCommentNo(), comment);
                        comment.setAuthorName(userName);
                        System.out.println(comment);
                    }

                    // 대댓글을 부모 댓글에 추가
                    for (CommentResponse comment : commentResponse) {
                        if (comment.getReplyCommentNo() != null && comment.getReplyCommentNo() > 0) {  // 대댓글인 경우
                            // 대댓글이 달릴 부모 댓글 찾기
                            CommentResponse parentComment = commentMap.get(comment.getReplyCommentNo());
                            if (parentComment != null) {
                                parentComment.addReply(comment);  // 대댓글을 부모 댓글에 추가
                            }
                        } else {
                            // 최상위 댓글은 resultComments에 추가
                            resultComments.add(comment);
                        }
                    }

                    // 최상위 댓글을 포함한 전체 댓글 반환
                    response.put("username",userName);
                    response.put("comments", resultComments);
                    return ResponseEntity.ok(response);
                }

                response.put("message","댓글작성성공");
                response.put("username",userName);
                return ResponseEntity.ok(response);
            }

            response.put("message", "댓글작성실패");
            return ResponseEntity.ok(response);

        } catch (Exception e) {
            e.printStackTrace();
            response.put("message", "서버 오류");
            return ResponseEntity.status(500).body(response);
        }
    }
}
