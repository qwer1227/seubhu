package store.seub2hu2.security;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;
import store.seub2hu2.user.vo.Role;
import store.seub2hu2.user.vo.User;

import java.util.*;
import java.util.stream.Collectors;

public class CustomUserDetails extends LoginUser implements UserDetails, OAuth2User {

    private final String id;   // 사용자 ID
    private final String password; // 비밀번호
    private final Collection<? extends GrantedAuthority> authorities; // 권한 목록
    private Map<String, Object> attributes; // OAuth2User용 사용자 속성

    // 공통 생성자
    public CustomUserDetails(User user, List<Role> roles) {
        super(user.getNo(), user.getEmail(), user.getNickname()); // LoginUser 초기화
        this.id = user.getId();
        this.password = user.getPassword();
        this.authorities = roles != null ? roles.stream()
                .map(role -> new SimpleGrantedAuthority(role.getName()))
                .collect(Collectors.toList()) : new ArrayList<>();
    }

    // OAuth2User용 추가 생성자
    public CustomUserDetails(User user, List<Role> roles, Map<String, Object> attributes) {
        this(user, roles);
        this.attributes = attributes;
    }

    // UserDetails 인터페이스 구현
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
        return id;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    // OAuth2User 인터페이스 구현
    @Override
    public Map<String, Object> getAttributes() {
        return attributes;
    }

    @Override
    public String getName() {
        return String.valueOf(super.getNo());
    }



    // OAuth2 속성 추가 메서드
    public void setAttributes(Map<String, Object> attributes) {
        this.attributes = attributes;
    }
}
