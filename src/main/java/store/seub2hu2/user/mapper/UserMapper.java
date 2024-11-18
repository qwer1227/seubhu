package store.seub2hu2.user.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.user.vo.Role;
import store.seub2hu2.user.vo.User;
import store.seub2hu2.user.vo.UserRole;

import java.util.List;

@Mapper
public interface UserMapper {

    // 회원 정보 삽입
    void insertUser(@Param("user") User user);

    // 사용자 이름으로 사용자 정보 조회
    User getUserByUsername(@Param("username") String username);

    // 사용자 번호로 사용자 정보 조회
    User getUserByNo(@Param("no") int no);

    // 이메일 중복 체크
    boolean existsByEmail(@Param("email") String email);

    // 닉네임 중복 체크
    boolean existsByNickname(@Param("nickname") String nickname);

    User getUserByEmail(@Param("email") String email);
    // 사용자 역할 목록 조회
    List<Role> getRolesByUserNo(@Param("userNo") int userNo);

    // 사용자 번호로 권한 지정
    void insertUserRole(@Param("userRole") UserRole userRole);
}
