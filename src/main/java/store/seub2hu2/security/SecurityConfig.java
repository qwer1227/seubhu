package com.example.demo.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import store.seub2hu2.security.CustomAccessDeniedHandler;
import store.seub2hu2.security.CustomAuthenticationEntryPoint;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity(prePostEnabled = true, securedEnabled = true)
public class SecurityConfig {

    @Autowired
    private CustomAuthenticationEntryPoint customAuthenticationEntryPoint;

    @Autowired
    private CustomAccessDeniedHandler customAccessDeniedHandler;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Bean
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

        http
                // 사이트간 요청번조를 방지하는 csrf 토큰 사용을 비활성화한다.
                .csrf(csrf -> csrf.disable())
                // 접근 인가정책을 설정한다.
                .authorizeHttpRequests(auth -> auth
                        // /my** 요청은 USER, MANAGER, ADMIN 권한을 가지고 있을 때만 접근허용
                        .requestMatchers("/my/**").hasAnyRole("USER", "COACH", "ADMIN")
                        // /admin/** 요청은 ADMIN 권한을 가지고 있을때만 접근허용
                        .requestMatchers("/admin/**").hasRole("ADMIN")
                        // 위에서 설정한 요청외의 모든 요청은 인증된 사용자만 접근허용
                        .anyRequest().permitAll())
                // 폼 로그인 정책을 설정한다,
                .formLogin(formLogin -> formLogin
                        // 로그인 폼을 요청하는 URL을 지정한다.
                        .loginPage("/login")
                        // 로그인 폼의 입력필드 이름을 지정한다.
                        .usernameParameter("id")
                        .passwordParameter("password")
                        // 로그인 요청을 처리하는 url을 지정한다.
                        .loginProcessingUrl("/login")
                        // 로그인 성공 시 이동할 URL을 지정한다.
                        .defaultSuccessUrl("/main")
                        // 로그인 실패 시 이동할 URL을 지정한다.
                        .failureUrl("/login?error=fail"))
                // 로그아웃 정책을 설정한다.
                .logout(logout -> logout
                        // 로그아웃...
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/main")
                        .invalidateHttpSession(true))
                .exceptionHandling(exceptionHandling -> exceptionHandling
                        // 인증되지 않은 사용자가 인증이 필요한 리소스를 요청했을 때
                        .authenticationEntryPoint(customAuthenticationEntryPoint)
                        // 접근권한을 가지고 있지 않는 리소스를 요청했을 때
                        .accessDeniedHandler(customAccessDeniedHandler));
        return http.build();
    }

    // 비밀번호를 암호화하는 비밀번호 인코더를 스프링의 빈으로 등록시킨다.
    @Bean
    PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
