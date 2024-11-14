package store.seub2hu2.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import store.seub2hu2.user.vo.Role;
import store.seub2hu2.user.vo.User;

public class CustomUserDetails extends LoginUser implements UserDetails {

    private String username;	// username에 해당하는 값이다.
    private String password;	// 비밀번호에 해당하는 값이다.
    private Collection<? extends GrantedAuthority> authorities = new ArrayList<>();

    public CustomUserDetails(User user, List<Role> roles) {
        // LoginUser 객체의 생성자 메소드를 호출해서
        // LoginUser의 no, email, nickname을 초기화한다.
        super(user.getNo(), user.getEmail(), user.getNickname());
        this.username = user.getEmail();
        this.password = user.getPassword();

        List<SimpleGrantedAuthority> list = new ArrayList<>();
        for (Role role : roles) {
            list.add(new SimpleGrantedAuthority(role.getName()));
        }
        this.authorities = list;

    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        // TODO Auto-generated method stub
        return authorities;
    }
    @Override
    public String getPassword() {
        // TODO Auto-generated method stub
        return password;
    }
    @Override
    public String getUsername() {
        // TODO Auto-generated method stub
        return username;
    }


}
