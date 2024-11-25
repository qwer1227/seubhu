package store.seub2hu2.mypage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.mypage.dto.CommentRequest;
import store.seub2hu2.mypage.vo.Post;
import store.seub2hu2.mypage.vo.PostComment;
import store.seub2hu2.user.vo.User;

import java.util.List;
import java.util.Map;

@Mapper
public interface PostMapper {

    Post getPostByNo(@Param("no") int no);
    List<Post> getPostsByNo(@Param("no") int userNo);
    int insertPost(@Param("post") Post post);
    int insertPostImages(List<Map<String, Object>> images);
    int updatePost(@Param("post") Post post);
    int deletePost(@Param("no") int postNo);
    int deletePostImagesByPostNo(@Param("no") int imageNo);
    int insertComment(@Param("comment") PostComment postComment);
    // 사용자 ID로 사용자 조회
    String findByUserNo(@Param("no") int userNo);
}
