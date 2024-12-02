package store.seub2hu2.user.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.user.vo.User;
import store.seub2hu2.user.vo.Role;
import store.seub2hu2.user.vo.UserRole;

import java.util.List;
import java.util.Optional;

@Mapper
public interface UserMapper {

    // 신규 사용자 추가
    void insertUser(@Param("user") User user);

    // 사용자 역할 부여
    void insertUserRole(@Param("userRole") UserRole userRole);

    // 사용자 정보 수정
    void updateUser(@Param("user") User user);

    // 사용자 ID로 사용자 조회
    User getUserById(@Param("id") String id);

    // 사용자 이메일로 사용자 조회
    User getUserByEmail(@Param("email") String email);

    // 사용자 닉네임으로 사용자 조회
    User getUserByNickname(@Param("nickname") String nickname);

    // 이메일로 아이디 찾기 (아이디 찾기용)
    Optional<String> findIdByEmail(@Param("email") String email);

    // 사용자 번호로 역할 정보 조회
    List<Role> getRolesByUserNo(@Param("userNo") int userNo);

    // 역할 이름으로 Role 객체 조회
    Role getRoleByName(@Param("roleName") String roleName);

    // 아이디와 이메일로 사용자 조회
    User findUserByIdAndEmail(@Param("id") String id, @Param("email") String email);

    // 비밀번호 업데이트 (임시 비밀번호 발급)
    void updatePassword(@Param("id") String id, @Param("email") String email);

    // 사용자 권한 번호로 사용자 조회(사용자 번호, 이름, 아이디)
    List<User> getUsersByRoleNo(@Param("roleNo") int roleNo);
}
