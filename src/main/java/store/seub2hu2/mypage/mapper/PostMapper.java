package store.seub2hu2.mypage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.security.core.parameters.P;
import store.seub2hu2.mypage.vo.Post;

import java.util.List;
import java.util.Map;

@Mapper
public interface PostMapper {

    Post getPostByNo(@Param("no") int no);
    List<Post> getPostsByNo(@Param("no") int userNo);
    void insertPost(@Param("post") Post post);
    int insertPostImages(List<Map<String, Object>> images);
}
