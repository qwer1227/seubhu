package store.seub2hu2.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import store.seub2hu2.user.dto.UserJoinForm;
import store.seub2hu2.user.vo.User;
import store.seub2hu2.user.mapper.UserMapper;

@Service
public class UserService {

    private final UserMapper userMapper;
    private final PasswordEncoder passwordEncoder; // PasswordEncoder 추가

    @Autowired
    public UserService(UserMapper userMapper, PasswordEncoder passwordEncoder) {
        this.userMapper = userMapper;
        this.passwordEncoder = passwordEncoder;
    }

    // 회원가입 처리 (UserJoinForm을 받아서 처리)
    public void save(UserJoinForm form) {
        // 이메일 중복 체크
        if (userMapper.existsByEmail(form.getEmail())) {
            throw new IllegalArgumentException("이미 사용 중인 이메일입니다.");
        }

        // 비밀번호 암호화 처리
        String encryptedPassword = passwordEncoder.encode(form.getPassword());

        // User VO 객체 생성
        User user = new User();

        // 암호화된 비밀번호가 포함된 User VO 객체를 DB에 저장
        userMapper.insertUser(user);
    }
}
