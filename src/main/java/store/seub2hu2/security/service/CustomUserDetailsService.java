package store.seub2hu2.security.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import store.seub2hu2.security.CustomUserDetails;
import store.seub2hu2.user.mapper.UserMapper;
import store.seub2hu2.user.vo.Role;
import store.seub2hu2.user.vo.User;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // 사용자 이름(username)으로 사용자 정보를 조회한다.
        User user = userMapper.getUserByUsername(username);
        // 조회된 사용자 정보가 없으면 UsernameNotFoundException 예외를 발생시킨다.
        if (user == null) {
            throw new UsernameNotFoundException("["+username+"] 사용자가 없습니다.");
        }

        // 사용자의 보유 권한을 조회한다.
        List<Role> roles = userMapper.getRolesByUserNo(user.getNo());

        // 사용자가 권한을 하나도 가지지 않으면 예외를 던진다.
        if (roles == null || roles.isEmpty()) {
            throw new UsernameNotFoundException("["+username+"] 사용자의 권한이 없습니다.");
        }

        // 사용자의 정보와 권한을 기반으로 CustomUserDetails 객체를 생성하여 반환
        CustomUserDetails customUserDetails = new CustomUserDetails(user, roles);

        return customUserDetails;
    }
}

