package store.seub2hu2.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.user.vo.User;
import store.seub2hu2.user.mapper.UserMapper;
import store.seub2hu2.user.dto.UserRegisterForm;
import store.seub2hu2.user.dto.UserUpdateRequest;

@Service
public class UserService {

    private final UserMapper userMapper;

    @Autowired
    public UserService(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    @Transactional
    public void updateUserInfo(String userId, UserUpdateRequest request) {
        User user = userMapper.findById(userId);
        if (user == null) {
            throw new RuntimeException("사용자를 찾을 수 없습니다.");
        }

        // 요청 받은 값으로 사용자 정보 업데이트
        user.setUsername(request.getUsername());
        user.setEmail(request.getEmail());
        // user.setAddress(request.getAddress());

        // 사용자 정보 업데이트 (MyBatis 매퍼를 이용한 SQL 실행)
        userMapper.updateUserInfo(userId, request.getUsername(), request.getEmail(), request.getAddress());
    }

    // 회원가입 처리
    public void save(User user) {
        // 이메일 중복 체크 및 기타 유효성 검사 로직 추가 가능
        if (userMapper.existsByEmail(user.getEmail())) {
            throw new IllegalArgumentException("사용중인 이메일입니다.");
        }
        userMapper.insertUser(user); // 실제 데이터베이스에 저장
    }

    public void addNewUser(UserRegisterForm form) {

    }

    //public boolean checkEmailExists(String email) {
    //     return userMapper.checkEmailExists(email);
    // }

    //public boolean checkNicknameExists(String nickname) {
    //    return userMapper.checkNicknameExists(nickname);
    //}
}
