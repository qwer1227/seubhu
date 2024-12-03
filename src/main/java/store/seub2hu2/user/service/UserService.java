package store.seub2hu2.user.service;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.mypage.dto.UserInfoReq;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.user.dto.UserJoinForm;
import store.seub2hu2.user.exception.AlreadyUsedIdException;
import store.seub2hu2.user.exception.InvalidCredentialsException;
import store.seub2hu2.user.vo.Addr;
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

        // 주소 데이터가 있는 경우 먼저 주소 저장
        if (form.getAddr() != null) {
            Addr addr = form.getAddr();
            addr.setUserNo(user.getNo()); // USER_NO 설정
            int addrNo = userMapper.insertAddr(addr); // 주소 저장
            user.getAddr().setNo(addrNo); // 사용자에 ADDR_NO 설정
        }

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

    public boolean verifyPassword(String password, LoginUser loginUser){

        // 로그인한 사용자 정보 가져오기
        User user = userMapper.getUserById(loginUser.getId());

        // 입력된 비밀번호 확인
        if (passwordEncoder.matches(password, user.getPassword())) {
            return true;
        }

        return false;
    }

    /**
     *
     * @param userInfoReq 사용자가 입력한 내용
     * @return 참 여부
     */
    public int updateUser(UserInfoReq userInfoReq, LoginUser loginUser){

        // userId를 사용해 유저 정보를 조회
        User user = userMapper.getUserById(loginUser.getId());

        // 입력한 비밀번호 인코딩
        String EncodedPwd = passwordEncoder.encode(userInfoReq.getPassword());

        // 사용자가 입력한 정보를 USER객체에 저장
        user.setNo(loginUser.getNo());
        user.setName(userInfoReq.getName());
        user.setNickname(userInfoReq.getNickname());
        user.setPassword(EncodedPwd);
        user.setTel(userInfoReq.getPhone());
        user.setEmail(userInfoReq.getEmail());

        // 이전비밀번호 중복입력검증
        if(userInfoReq.getPassword().equals(user.getPassword())){
            return 1;
        }

        // 비밀번호확인 검증
        if(!userInfoReq.getPassword().equals(userInfoReq.getConfirmPassword())){
            return 2;
        }

        // 저장한 객체를 Mapper에 전달
        userMapper.updateUser(user);

        return 0;
    }

    public User findbyUserNo(String userId){
        return userMapper.getUserById(userId);
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