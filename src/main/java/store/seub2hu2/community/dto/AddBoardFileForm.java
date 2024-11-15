package store.seub2hu2.community.dto;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class AddBoardFileForm {
    private String fileName;
    private MultipartFile upfile;
}
