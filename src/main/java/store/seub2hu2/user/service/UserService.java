package store.seub2hu2.user.service;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import store.seub2hu2.user.dto.LoginResponse;
import store.seub2hu2.user.dto.SocialLoginRequest;
import store.seub2hu2.user.dto.UserJoinForm;
import store.seub2hu2.user.exception.AlreadyUsedEmailException;
import store.seub2hu2.user.vo.User;
import store.seub2hu2.user.mapper.UserMapper;
import store.seub2hu2.user.vo.UserRole;

@Service
public class UserService {


    @Autowired
    private UserMapper userMapper;

    /**
     * 이메일을 전달받아서 존재여부를 체크하는 서비스다
     *
     * @param email 이메일
     * @return 이메일이 존재하면 true를반환한다.
     */
    public boolean isExistEmail(String email) {

        User user = userMapper.getUserByEmail(email);
        return user != null;
    }

    /**
     * 신규 사용자 정보를 전달받아서 회원가입 시키는 서비스다.
     *
     * @param form
     */
    public void insertUser(UserJoinForm form) {
        // 이메일 중복 체크
        User savedUser = userMapper.getUserByEmail(form.getEmail());
        if (savedUser != null) {
            throw new AlreadyUsedEmailException(form.getEmail());
        }

        User user = new User();
        BeanUtils.copyProperties(form, user);
        // 비밀번호를 암호화한다.
        //String encodedPassword = passwordEncoder.encode(user.getPassword());
        //user.setPassword(encodedPassword);
        // 회원정보를 테이블에 저장시킨다.
        userMapper.insertUser(user);

        addUserRole(user.getNo(), "ROLE_USER");
    }

    /**
     * 사용자번호, 권한이름을 전달받아서 권한을 추가하는 서비스다.
     *
     * @param userNo   사용자번호
     * @param roleName 권한이름
     */
    public void addUserRole(int userNo, String roleName) {
        UserRole userRole = new UserRole(userNo, roleName);
        userMapper.insertUserRole(userRole);

    }

    public LoginResponse doSocialLogin(SocialLoginRequest request) {
        return null;

    }
}
