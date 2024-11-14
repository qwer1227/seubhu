package store.seub2hu2.security;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import store.seub2hu2.user.mapper.UserMapper;
import store.seub2hu2.user.vo.Role;
import store.seub2hu2.user.vo.User;

@Service
public class CustomUserDetailsService implements UserDetailsService{

	@Autowired
	private UserMapper userMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// 이메일로 사용자 정보를 조회한다.
		User user = userMapper.getUserByEmail(username);
		// 조회된 사용자 정보가 없으면 UsernameNotFoundException예외를 발생시킨다.
		if (user == null) {
			throw new UsernameNotFoundException("["+username+"] 사용자가 없습니다.");
		}
		
		//
		List<Role> roles = userMapper.getRolesByUserNo(user.getNo());
		
		// UserDetails 구현객체를 생성해서 사용자정보(이메일, 비밀번호, 권한정보)를 담는다.
		CustomUserDetails customUserDetails = new CustomUserDetails(user, roles);
		
		return customUserDetails;
	}

}
