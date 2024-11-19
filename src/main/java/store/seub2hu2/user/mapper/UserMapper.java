package store.seub2hu2.user.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.user.vo.User;
import store.seub2hu2.user.vo.Role;
import store.seub2hu2.user.vo.UserRole;

import java.util.List;

@Mapper
public interface UserMapper {

    // 신규 사용자 추가
    void insertUser(@Param("user") User user);

    // 사용자 역할 부여
    void insertUserRole(@Param("userRole") UserRole userRole);

    // 사용자 번호로 역할 정보 조회
    List<Role> getRolesByUserNo(int userNo);

    // 사용자 ID로 사용자 조회
    User findById(@Param("id") String id);

    // 사용자 이메일로 사용자 조회
    User findByEmail(@Param("email") String email);

    // 사용자 이메일로 아이디 조회(아이디 찾기용)
    User findIdByEmail(@Param("email") String email);

    // 사용자 이메일, 아이디로 사용자 조회(비밀번호 찾기용) -->
    User findByIdAndEmail(@Param("id") String id, @Param("email") String email);

    // 역할 이름으로 Role 객체 조회
    Role getRoleByName(@Param("roleName") String roleName);



}
