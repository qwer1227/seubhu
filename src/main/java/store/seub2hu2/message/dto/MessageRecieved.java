package store.seub2hu2.message.dto;

import lombok.*;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class MessageRecieved {
    private int messageNo;             // 메시지 번호
    private String title;              // 메시지 제목
    private int senderUserNo;          // 보낸 사람의 사용자 번호
    private Date createDate;  // 메시지 생성 날짜
    private String readStatus;         // 읽음 여부
    private Date readDate;    // 읽은 날짜
}


