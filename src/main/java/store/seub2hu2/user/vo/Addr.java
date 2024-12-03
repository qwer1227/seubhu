package store.seub2hu2.user.vo;

import lombok.*;

@ToString
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class Addr {

    private int no; // 주소 번호
    private String name; // 배송지명(?)
    private String zipcode; // 우편 번호
    private String address; // 주소 1
    private String addressDetail; // 상세주소
    private String isAddrHome; // 기본 주소 설정
}
