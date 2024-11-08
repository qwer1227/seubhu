package store.seub2hu2.user.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.user.vo.Role;
import store.seub2hu2.user.vo.User;

import java.util.List;

@Mapper
public interface UserMapper {

    // 회원 정보 삽입
    void insertUser(User user);

    // 사용자 ID로 사용자 정보 조회
    User findById(@Param("userId") String userId);

    // 사용자 이름으로 사용자 정보 조회
    User getUserByUsername(@Param("username") String username);

    // 이메일 중복 체크
    boolean existsByEmail(String email);

    // 사용자 역할 목록 조회
    List<Role> getRolesByUserNo(@Param("no") int no);

    // 사용자 정보 업데이트
    void updateUserInfo(@Param("userId") String userId,
                        @Param("username") String username,
                        @Param("email") String email,
                        @Param("address") String address);
}
