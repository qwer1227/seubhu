package store.seub2hu2.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.web.SecurityFilterChain;
import store.seub2hu2.security.service.CustomOAuth2UserService;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity(prePostEnabled = true, securedEnabled = true)
public class SecurityConfig {

    @Autowired
    private CustomAuthenticationEntryPoint customAuthenticationEntryPoint;

    @Autowired
    private CustomAccessDeniedHandler customAccessDeniedHandler;

    @Autowired
    private CustomOAuth2UserService customOAuth2UserService;

    @Bean
    SecurityFilterChain webSecurityFilterChain(HttpSecurity http) throws Exception {

// 세션 기반 일반 로그인 설정
        http
                .csrf(csrf -> csrf.disable()) // CSRF 활성화
                // 접근 인가정책을 설정한다.
                .authorizeHttpRequests(auth -> auth
                        // /mypage** 요청은 USER, MANAGER, ADMIN 권한을 가지고 있을 때만 접근허용
//                        .requestMatchers("/mypage/**").hasAnyRole("USER", "COACH", "ADMIN")
                        // /admin/** 요청은 ADMIN 권한을 가지고 있을때만 접근허용
//                        .requestMatchers("/admin/**").hasRole("ADMIN")
                        // 위에서 설정한 요청외의 모든 요청은 인증된 사용자만 접근허용
                        .anyRequest().permitAll())
                // 폼 로그인 정책을 설정한다.
                .formLogin(formLogin -> formLogin
                        // 로그인 폼을 요청하는 URL을 지정한다.
                        .loginPage("/login")
                        // 로그인 폼의 입력필드 이름을 지정한다.
                        .usernameParameter("id")
                        .passwordParameter("password")
                        // 로그인 요청을 처리하는 url을 지정한다.
                        .loginProcessingUrl("/login")
                        // 로그인 성공 시 이동할 URL을 지정한다.
                        .defaultSuccessUrl("/main", true)
                        // 로그인 실패 시 이동할 URL을 지정한다.
                        .failureUrl("/login?error=fail"))
// 로그아웃 정책을 설정한다.
                .logout(logout -> logout
// 로그아웃...
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/main")
                        .invalidateHttpSession(true))
                .oauth2Login(oauth2Configurer -> oauth2Configurer
                        .loginPage("/login")
                        .defaultSuccessUrl("/main")
                        .failureUrl("/login")
                        .userInfoEndpoint()
                        .userService(customOAuth2UserService))
                .exceptionHandling(exceptionHandling -> exceptionHandling
                        // 인증되지 않은 사용자가 인증이 필요한 리소스를 요청했을 때
                        .authenticationEntryPoint(customAuthenticationEntryPoint)
                        // 접근권한을 가지고 있지 않는 리소스를 요청했을 때
                        .accessDeniedHandler(customAccessDeniedHandler));

        return http.build();
    }

    @Bean
    PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
