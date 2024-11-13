package store.seub2hu2.admin.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.user.vo.User;
import java.util.List;
import java.util.Map;

@Mapper
public interface AdminMapper {

    /*
    * 코스
    */

    /*
     * 회원
     */
    int getTotalRows(@Param("condition") Map<String, Object> condition);
    List<User> getUsers(@Param("condition") Map<String, Object> condition);
    User getUserByNo(@Param("no") int no);
    /*
     * 상품
     */

    /*
     * 재고
     */

    /*
     * 커뮤니티
     */
}
