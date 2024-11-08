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
public class UserRegisterForm {

    @NotBlank(message = "이메일은 필수입력값입니다.")
    @Email(message = "유효한 이메일 형식이 아닙니다.")
    private String email;

    @NotBlank(message = "비밀번호는 필수입력값입니다.")
    @Size(min = 6, message = "비밀번호는 6글자 이상이어야 합니다.")
    private String password;

    @NotBlank(message = "비밀번호확인는 필수입력값입니다.")
    @Size(min = 6, message = "비밀번호는 6글자 이상이어야 합니다.")
    private String passwordConfirm;

    @Pattern(regexp = "^[가-힣]+$", message = "닉네임은 한글 한글자 이상이어야 합니다.")
    private String nickname;

    @Pattern(regexp = "^\\d{2,3}-\\d{3,4}-\\d{4}$", message = "유효한 전화번호 형식이 아닙니다.")
    private String tel;

//	@NotEmpty(message = "사용자 유형은 하나 이상 체크해야 합니다.")
//	private List<String> roles;
}
