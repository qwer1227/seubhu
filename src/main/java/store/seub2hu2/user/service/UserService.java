package store.seub2hu2.user.service;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.user.dto.LoginResponse;
import store.seub2hu2.user.dto.SocialLoginRequest;
import store.seub2hu2.user.dto.UserJoinForm;
import store.seub2hu2.user.exception.AlreadyUsedIdException;
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

    /**
     * 신규 사용자 정보를 전달받아서 회원가입 시키는 서비스다.
     *
     */
    public void insertUser(UserJoinForm form) {
        // 사용자 ID 중복 체크

        User savedUser = userMapper.findUserById(form.getId());
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
        addUserRole(user.getNo(),"ROLE_USER");
    }


    /**
     * 사용자번호, 권한이름을 전달받아서 권한을 추가하는 서비스다.
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
     * 소셜 로그인 처리 (현재는 구현되지 않음).
     *
     * @param request 소셜 로그인 요청
     * @return 로그인 응답
     */
    public LoginResponse doSocialLogin(SocialLoginRequest request) {
        // 소셜 로그인 처리 로직을 여기에 추가해야 합니다.
        return null;  // 임시로 null 반환
    }
}
