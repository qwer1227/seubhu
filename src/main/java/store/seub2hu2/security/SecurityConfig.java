package store.seub2hu2.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
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


    @Bean
    public SecurityFilterChain apiSecurityFilterChain(HttpSecurity http) throws Exception {
        http
                .securityMatcher("/api/**")  // REST API에만 적용
                .csrf(csrf -> csrf.disable()) // CSRF 비활성화
                .authorizeHttpRequests(auth -> auth
                        .anyRequest().authenticated()) // 모든 API 요청은 인증 필요
                .sessionManagement(session -> session
                        .sessionCreationPolicy(SessionCreationPolicy.STATELESS)); // 세션 사용 안 함
 //               .addFilter(new JwtAuthenticationFilter()) // JWT 인증 필터 추가

        return http.build();
    }

    @Bean
    SecurityFilterChain webSecurityFilterChain(HttpSecurity http) throws Exception {

// 세션 기반 일반 로그인 설정
        http
                .securityMatcher("/**") // 웹 요청에만 적용
                .csrf(csrf -> csrf.disable()) // CSRF 활성화
                // 접근 인가정책을 설정한다.
                .authorizeHttpRequests(auth -> auth
                        // /my** 요청은 USER, MANAGER, ADMIN 권한을 가지고 있을 때만 접근허용
//                        .requestMatchers("/my/**").hasAnyRole("USER", "MANAGER", "ADMIN")
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
                .exceptionHandling(exceptionHandling -> exceptionHandling
                        // 인증되지 않은 사용자가 인증이 필요한 리소스를 요청했을 때
                        .authenticationEntryPoint(customAuthenticationEntryPoint)
                        // 접근권한을 가지고 있지 않는 리소스를 요청했을 때
                        .accessDeniedHandler(customAccessDeniedHandler))

                // 세션 관리 (세션 기반 로그인과 REST 기반의 공존을 위한 분리)
                .sessionManagement(session -> session
                        .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED));

        return http.build();
    }
    @Bean
    PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
