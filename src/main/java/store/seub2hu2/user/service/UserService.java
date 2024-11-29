package store.seub2hu2.user.service;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.user.dto.UserJoinForm;
import store.seub2hu2.user.exception.AlreadyUsedIdException;
import store.seub2hu2.user.vo.Role;
import store.seub2hu2.user.vo.User;
import store.seub2hu2.user.mapper.UserMapper;
import store.seub2hu2.user.vo.UserRole;

import java.util.List;

@Service
@Transactional
public class UserService {

    @Autowired
    private PasswordEncoder passwordEncoder; // PasswordEncoder bean 등록

    @Autowired
    private UserMapper userMapper;

    // 아이디 중복 체크
    public boolean isIdExists(String id) {
        return userMapper.getUserById(id) != null;
    }

    // 닉네임 중복 체크
    public boolean isNicknameExists(String nickname) {
        return userMapper.getUserByNickname(nickname) != null;
    }

    // 이메일 중복 체크
    public boolean isEmailExists(String email) {
        return userMapper.getUserByEmail(email) != null;
    }



    /**
     * 신규 사용자 정보를 전달받아서 회원가입 시키는 서비스
     *
     * @param form 사용자 가입 정보를 담고 있는 UserJoinForm 객체
     */
    public void insertUser(UserJoinForm form) {
        // 사용자 중복 체크 및 예외 처리
            User savedUser = userMapper.getUserById(form.getId());
            if (savedUser != null) {
                throw new AlreadyUsedIdException(form.getId());
            }

        // User 객체로 변환
        User user = new User();
        BeanUtils.copyProperties(form, user);

        // 비밀번호 암호화
        String encodedPassword = passwordEncoder.encode(user.getPassword());
        user.setPassword(encodedPassword);

        // 사용자 정보를 테이블에 저장
        userMapper.insertUser(user);

        // 기본 사용자 역할 부여
        addUserRole(user.getNo(), "ROLE_USER");
    }


    /**
     * 사용자번호, 권한이름을 전달받아서 권한을 추가하는 서비스
     *
     * @param userNo   사용자번호
     * @param roleName 권한이름
     */
    public void addUserRole(int userNo, String roleName) {
        // roleName을 통해 Role 객체를 조회
        Role role = userMapper.getRoleByName(roleName); // 역할 이름을 통해 Role 객체를 조회하는 메서드

        // Role 객체를 UserRole에 포함시켜 역할 부여
        UserRole userRole = new UserRole(userNo, role);

        // 사용자 역할 추가 메서드 호출
        userMapper.insertUserRole(userRole);
    }

    /**
     * 권한 번호로 해당 권한을 가진 사용자 목록을 조회하는 서비스
     * @param roleNo 권한번호
     * @return 조회된 사용자 목록 반환
     */
    public List<User> findUsersByUserRoleNo(int roleNo) {
        List<User> findUsers = userMapper.getUsersByRoleNo(roleNo);
        return findUsers;
    }
}