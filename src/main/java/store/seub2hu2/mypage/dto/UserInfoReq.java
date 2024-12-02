package store.seub2hu2.mypage.dto;


import lombok.*;

@NoArgsConstructor
@AllArgsConstructor
@ToString
@Getter
@Setter
public class UserInfoReq {
    private String name;
    private String password;
    private String confirmPassword;
    private String nickname;
    private String phone;
    private String email;
}
