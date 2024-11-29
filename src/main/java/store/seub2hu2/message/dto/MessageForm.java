package store.seub2hu2.message.dto;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class MessageForm {
    private int messageNo;
    private String title;
    private String content;
    private MultipartFile MessageFile;
}
