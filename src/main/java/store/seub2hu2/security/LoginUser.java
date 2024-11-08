package store.seub2hu2.security;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class LoginUser {

	private int no;            // 유저 고유 ID
	private String email;      // 이메일 (로그인용)
	private String username;   // 사용자 이름
	private String nickname;   // 닉네임

}
