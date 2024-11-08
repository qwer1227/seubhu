package store.seub2hu2.security.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.security.vo.JwtToken;

import java.util.Date;
import java.util.Optional;

@Mapper
public interface JwtTokenMapper {

    // 사용자 ID에 해당하는 리프레시 토큰 조회
    Optional<JwtToken> findByUserId(@Param("userId") String userId);

    // 리프레시 토큰 업데이트
    void updateRefreshToken(@Param("userId") String userId, @Param("refreshToken") String refreshToken, @Param("expiredDate") Date expiredDate);

    // 리프레시 토큰 저장
    void saveJwtToken(JwtToken jwtToken);
}
