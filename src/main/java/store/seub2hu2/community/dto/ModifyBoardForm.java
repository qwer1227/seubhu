package store.seub2hu2.community.dto;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class ModifyBoardForm {
    private String catName;
    private int no;
    private String title;
    private String content;
    private MultipartFile upfile;
}
