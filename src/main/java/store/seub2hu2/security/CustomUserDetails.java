package store.seub2hu2.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import store.seub2hu2.user.vo.Role;
import store.seub2hu2.user.vo.User;

public class CustomUserDetails implements UserDetails {

    private String id;            // 사용자의 고유 ID
    private String username;  // 사용자가 설정한 이름
    private String password;
    private String email;     // 이메일
    private String provider;  // 소셜 로그인 제공자
    private Collection<? extends GrantedAuthority> authorities;

    public CustomUserDetails(User user, List<Role> roles) {
        // 사용자 정보를 초기화
        this.id = String.valueOf(user.getNo());  // 사용자의 고유 ID
        this.username = user.getUsername(); // 사용자 고유 ID (no 필드를 사용하여 초기화)
        this.password = user.getPassword();
        this.email = user.getEmail(); // 이메일도 저장
        this.provider = user.getProvider(); // 소셜 로그인 제공자

        // 권한 설정
        List<SimpleGrantedAuthority> authoritiesList = new ArrayList<>();
        for (Role role : roles) {
            authoritiesList.add(new SimpleGrantedAuthority(role.getName()));
        }
        this.authorities = authoritiesList;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return username;
    }

    // 사용자 고유 ID
    public String getId() {
        return id;
    }

    // 이메일도 필요할 경우 제공
    public String getEmail() {
        return email;
    }

    // 소셜 로그인 제공자
    public String getProvider() {
        return provider;
    }

    // 사용자 계정이 잠겨 있지 않으면 true 반환
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    // 사용자 비밀번호가 만료되지 않았으면 true 반환
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    // 사용자가 활성화 되어 있으면 true 반환
    @Override
    public boolean isEnabled() {
        return true;
    }

}

