package store.seub2hu2.security.vo;

import lombok.*;
import org.apache.ibatis.type.Alias;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
@ToString
@Alias("JwtToken")  // MyBatis에서 사용할 alias 이름
public class JwtToken {

    private String userId;          // 사용자 ID (Primary key)
    private String refreshToken;  // 리프레시 토큰 값
    private Date createdDate;       // 액세스 토큰 생성 일시
    private Date expiredDate;       // 리프레시 토큰 만료 일시

    // 유효성 검사 및 기타 관련 메서드 추가 가능
}
