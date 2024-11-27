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

    @NotBlank(message = "아이디는 필수 입력값입니다.")
    private String id;

    @NotBlank(message = "비밀번호는 필수 입력값입니다.")
    private String password;

    @NotBlank(message = "비밀번호 확인은 필수 입력값입니다.")
    private String passwordConfirm;

    @NotBlank(message = "이메일은 필수 입력값입니다.")
    @Email(message = "유효한 이메일 형식이 아닙니다.")
    private String email;



    @Pattern(regexp = "^[가-힣a-z0-9]{2,}$", message = "닉네임은 한글, 영소문자, 숫자 조합으로 2글자 이상이어야 합니다.")
    private String nickname;

    @NotBlank(message = "전화번호는 필수 입력값입니다.")
    private String tel;

    private String name;
    private String type;  // 로그인 타입 (일반/소셜 등)
    private String provider;  // 소셜 로그인 제공자 (예: google, facebook 등)

    private boolean terms;  // 이용약관 동의
    private boolean privacy;  // 개인정보 수집 및 이용 동의


//	@NotEmpty(message = "사용자 유형은 하나 이상 체크해야 합니다.")
//	private List<String> roles;
}
