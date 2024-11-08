package store.seub2hu2.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.header.writers.frameoptions.XFrameOptionsHeaderWriter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.List;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity(prePostEnabled = true, securedEnabled = true)
public class SecurityConfig {
    // Spring Security의 SecurityFilterChain을 구성하는 필터들에 대한 사용자정의 설정을 추가한다.
    @Bean
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
        http
                .headers((headers) -> headers
                        .addHeaderWriter(new XFrameOptionsHeaderWriter
                                (XFrameOptionsHeaderWriter.XFrameOptionsMode.SAMEORIGIN)))
                // csrf 비활성화
                .csrf(AbstractHttpConfigurer::disable)
                // 모든 요청에 대해서 접근 허용
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/**").permitAll());
        // 위에서 설정한 사용자정의 설정이 적용된 SecurityFilterChain 객체를 반환한다.
        return http.build();
    }

    // 회원가입시 비밀번호를 인코딩할 때 필요한 객체를 스프링의 빈으로 등록한다.
    @Bean
    PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOriginPatterns(List.of("*")); // 모든 도메인 허용
        configuration.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        configuration.setAllowedHeaders(List.of("*")); // 모든 헤더 허용
        configuration.setAllowCredentials(true); // 인증 정보를 포함할 수 있도록 설정

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }
}

