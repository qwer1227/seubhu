package store.seub2hu2.user.vo;

import lombok.*;
import org.apache.ibatis.type.Alias;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
@ToString
@Alias("User")  // MyBatis에서 사용할 alias 이름
public class User {

    private int no;             // 유저 고유 ID
    private String id;          // 유저 ID (아이디로 로그인 시 사용)
    private String username;    // 사용자 고유 이름
    private String password;    // 비밀번호 (암호화되어 저장됨)
    private String email;       // 이메일 (로그인용)
    private String nickname;    // 닉네임
    private String tel;         // 전화번호
    private String type;        // 로그인 타입 (일반/소셜 등)
    private String provider;    // 소셜 로그인 제공자 (예: google, facebook 등)
    private Date createdDate;   // 계정 생성일
    private Date updatedDate;   // 계정 수정일
    // private Address address;    // 주소 (사용자 관련 추가 정보)

}
