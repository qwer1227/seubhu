package store.seub2hu2.user.service;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import store.seub2hu2.course.vo.UserLevel;
import store.seub2hu2.mypage.dto.UserInfoReq;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.user.dto.UserJoinForm;
import store.seub2hu2.user.exception.AlreadyUsedIdException;
import store.seub2hu2.user.mapper.UserMapper;
import store.seub2hu2.user.vo.Addr;
import store.seub2hu2.user.vo.Role;
import store.seub2hu2.user.vo.User;
import store.seub2hu2.user.vo.UserRole;

import java.util.List;

@Service
@Transactional
public class UserService {

    @Autowired
    private AuthenticationManager authenticationManager;

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
    @Transactional // 트랜잭션 적용
    public void insertUser(UserJoinForm form) {
        // 사용자 중복 체크
        if (userMapper.getUserById(form.getId()) != null) {
            throw new AlreadyUsedIdException(form.getId());
        }

        // User 객체 생성 및 설정
        User user = new User();
        BeanUtils.copyProperties(form, user); // UserJoinForm의 데이터를 User로 복사
        user.setPassword(passwordEncoder.encode(user.getPassword())); // 비밀번호 암호화

        // 사용자 등록
        userMapper.insertUser(user); // DB에 삽입된 후 user.no가 자동 생성됨

        // Addr 객체 생성 및 설정
        Addr addr = new Addr();
        if (form.getPostcode() == null || form.getPostcode().isEmpty()) {
            throw new IllegalArgumentException("우편번호는 필수 입력 항목입니다.");
        }
        addr.setPostcode(form.getPostcode());             // 우편번호
        addr.setAddress(form.getAddress());             // 기본 주소
        addr.setAddressDetail(form.getAddressDetail() != null ? form.getAddressDetail() : ""); // 상세 주소
        addr.setIsAddrHome("Y");                         // 회원가입 시 기본 배송지로 설정
        addr.setName(form.getName());                    // 사용자 이름 설정
        addr.setUserNo(user.getNo());                    // 생성된 사용자 번호로 설정

        // 주소 등록
        userMapper.insertAddr(addr);

        // 사용자의 주소번호를 새로 등록한 주소의 번호로 없데이트 한다.
        userMapper.updateAddrUserNo(addr.getNo(), user.getNo());

        // 기본 사용자 역할 부여
        addUserRole(user.getNo(), "ROLE_USER");

        // 기본 사용자 레벨 부여
        UserLevel userLevel = new UserLevel();
        userLevel.setUserNo(user.getNo());  // 등록된 사용자 번호
        userLevel.setLevel(1);             // 기본 레벨 설정 (예: 1)
        userMapper.insertUserLevel(userLevel);  // 사용자 레벨 등록
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

    public boolean verifyPassword(String password, LoginUser loginUser) {

        // 로그인한 사용자 정보 가져오기
        User user = userMapper.getUserById(loginUser.getId());

        // 입력된 비밀번호 확인
        if (passwordEncoder.matches(password, user.getPassword())) {
            return true;
        }

        return false;
    }

    /**
     * @param userInfoReq 사용자가 입력한 내용
     * @return 참 여부
     */
    public int updateUser(UserInfoReq userInfoReq, LoginUser loginUser) {

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

        if(userInfoReq.getAddrNo() != 0){
            userMapper.updateAddr(userInfoReq);
        }

        // 이전비밀번호 중복입력검증
        if (userInfoReq.getPassword().equals(user.getPassword())) {
            return 1;
        }

        // 비밀번호확인 검증
        if (!userInfoReq.getPassword().equals(userInfoReq.getConfirmPassword())) {
            return 2;
        }

        // 저장한 객체를 Mapper에 전달
        userMapper.updateUser(user);

        return 0;
    }

    public User findbyUserId(String userId) {
        return userMapper.getUserById(userId);
    }

    /**
     * 권한 번호로 해당 권한을 가진 사용자 목록을 조회하는 서비스
     *
     * @param roleNo 권한번호
     * @return 조회된 사용자 목록 반환
     */
    public List<User> findUsersByUserRoleNo(int roleNo) {
        List<User> findUsers = userMapper.getUsersByRoleNo(roleNo);
        return findUsers;
    }


    public LoginUser authenticateUser(String id, String password) throws AuthenticationException {
        // 인증을 시도하고, 인증에 성공하면 인증된 사용자 정보를 반환
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(id, password)
        );

        // 인증 성공 시, 인증 정보를 SecurityContext에 저장
        SecurityContextHolder.getContext().setAuthentication(authentication);

        return (LoginUser) authentication.getPrincipal();
    }

    public List<User> searchUsersByNickname(String nickname) {
        return userMapper.findUsersByNickname(nickname);
    }

    public boolean updateNickname(String nickname){

        List<User> users = searchUsersByNickname(nickname.trim());

        for (User user : users) {
            if(user.getNickname().equals(nickname)){
                return false;
            }
        }
        return true;
    }

    public User findbyUserNo(int userNo){
        return userMapper.findByUserNo(userNo);
    }

    public boolean isSameAsOldPassword(String password, int userNo){

        User user = findbyUserNo(userNo);

        if(passwordEncoder.matches(password, user.getPassword())){
            return true;
        } else {
            return false;
        }
    }

    public List<Addr> findAddrByUserNo(int userNo){

        return userMapper.findAddrByUserNo(userNo);

    }
}