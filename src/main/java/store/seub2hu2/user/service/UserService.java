package store.seub2hu2.user.service;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.user.dto.UserJoinForm;
import store.seub2hu2.user.exception.AlreadyUsedIdException;
import store.seub2hu2.user.exception.InvalidCredentialsException;
import store.seub2hu2.user.vo.Role;
import store.seub2hu2.user.vo.User;
import store.seub2hu2.user.mapper.UserMapper;
import store.seub2hu2.user.vo.UserRole;

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

    public User login(String id, String password) throws InvalidCredentialsException {
        // 아이디로 사용자 조회
        User user = userMapper.getUserById(id);

        if (user == null) {
            // 사용자가 없으면 예외 발생
            throw new InvalidCredentialsException("User not found.");
        }

        // 비밀번호 확인 (입력된 비밀번호와 DB에 저장된 비밀번호를 비교)
        if (!passwordEncoder.matches(password, user.getPassword())) {
            // 비밀번호가 일치하지 않으면 예외 발생
            throw new InvalidCredentialsException("Invalid password.");
        }

        // 로그인 성공 시, 사용자 객체 반환
        return user;
    }
}