package store.seub2hu2.community.dto;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class BoardForm {
    private int no;
    private String catName;
    private String title;
    private String content;
    private MultipartFile upfile;
}
