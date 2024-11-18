package store.seub2hu2.mypage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.mypage.vo.Post;

import java.util.List;
import java.util.Map;

@Mapper
public interface PostMapper {

    Post getPostByNo(@Param("no") int no);
    void insertPost(@Param("post") Post post);
    void insertPostImages(List<Map<String, Object>> images);
}
