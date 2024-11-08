package store.seub2hu2.security;

import java.io.IOException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import store.seub2hu2.security.dto.RestResponseDto;

@Component
public class CustomAuthenticationEntryPoint implements AuthenticationEntryPoint {

    private static final Logger log = LoggerFactory.getLogger(CustomAuthenticationEntryPoint.class);

    private static final ObjectMapper objectMapper = new ObjectMapper(); // ObjectMapper 재사용

    // 인증되지 않은 사용자가 인증이 필요한 서비스를 요청했을 때 실행되는 메소드다.
    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response,
                         AuthenticationException authException) throws IOException, ServletException {

        String requestURI = request.getRequestURI();

        log.info("Unauthorized access attempt to URI: {}", requestURI);

        if (requestURI.startsWith("/ajax")) {
            // 응답메세지객체를 생성한다.
            RestResponseDto<Void> dto = RestResponseDto.fail(HttpServletResponse.SC_UNAUTHORIZED, "로그인이 필요한 서비스입니다");

            // 응답메세지객체를 json 형식의 텍스트로 변환한다.
            String jsonText = objectMapper.writeValueAsString(dto);

            // HttpServletResponse 객체를 이용해서 응답을 보낸다.
            response.setContentType("application/json; charset=utf-8");
            // 응답메세지의 HTTP 응답코드를 401로 설정한다.
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            // 브라우저로 응답을 보낸다.
            response.getWriter().write(jsonText);

            // 리다이렉트할 URL을 Referer 헤더에서 가져오기
            String redirectUrl = request.getHeader("Referer"); // 이전 페이지 URL을 가져오기
            if (redirectUrl != null) {
                response.sendRedirect("/login?error=required&redirect=" + redirectUrl);
            }
        } else {
            // 일반적인 리다이렉션 처리
            response.sendRedirect("/login?error=required");
        }
    }
}
