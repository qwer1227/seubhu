package store.seub2hu2.mypage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.mypage.vo.Post;

@Mapper
public interface PostMapper {

    Post getPostByNo(@Param("no") int no);
}
