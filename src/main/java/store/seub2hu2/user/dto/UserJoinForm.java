package store.seub2hu2.user.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class UserJoinForm {

    @NotBlank(message = "이메일은 필수입력값입니다.")
    @Email(message = "유효한 이메일 형식이 아닙니다.")
    private String email;

    @NotBlank(message = "비밀번호는 필수입력값입니다.")
    @Size(min = 6, message = "비밀번호는 6글자 이상이어야 합니다.")
    private String password;

    @NotBlank(message = "비밀번호확인는 필수입력값입니다.")
    @Size(min = 6, message = "비밀번호는 6글자 이상이어야 합니다.")
    private String passwordConfirm;

    @NotBlank(message = "이름은 필수입력값입니다.")
    private String username;

    @Pattern(regexp = "^[가-힣]+$", message = "닉네임은 한글 한글자 이상이어야 합니다.")
    private String nickname;

    @Pattern(regexp = "^\\d{2,3}-\\d{3,4}-\\d{4}$", message = "유효한 전화번호 형식이 아닙니다.")
    private String tel;

    private String name;
    private String type;  // 로그인 타입 (일반/소셜 등)
    private String provider;  // 소셜 로그인 제공자 (예: google, facebook 등)

    private boolean terms;  // 이용약관 동의
    private boolean privacy;  // 개인정보 수집 및 이용 동의

    private String referrer;  // 추천인 아이디


//	@NotEmpty(message = "사용자 유형은 하나 이상 체크해야 합니다.")
//	private List<String> roles;
}
