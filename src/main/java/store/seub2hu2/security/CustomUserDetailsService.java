package store.seub2hu2.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import store.seub2hu2.user.mapper.UserMapper;
import store.seub2hu2.user.vo.Role;
import store.seub2hu2.user.vo.User;

import java.util.List;

@Service
public class CustomUserDetailsService implements UserDetailsService {

	private final UserMapper userMapper;

	@Autowired
	public CustomUserDetailsService(UserMapper userMapper) {
		this.userMapper = userMapper;
	}

	@Override
	public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {
		// 1. 사용자 정보 조회
		System.out.println("loadUserByUsername : " + id);
		User user = userMapper.findUserById(id);
		System.out.println("loadUserByUsername : " + user);
		if (user == null) {
			throw new UsernameNotFoundException("[" + id + "] 사용자가 없습니다.");
		}

		// 2. 역할(Role) 정보 조회
		List<Role> roles = userMapper.getRolesByUserNo(user.getNo());

		// 3. CustomUserDetails 생성 및 반환
		return new CustomUserDetails(user, roles);
	}
}
