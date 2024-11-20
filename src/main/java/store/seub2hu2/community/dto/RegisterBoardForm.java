package store.seub2hu2.community.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

@NoArgsConstructor
@Getter
@Setter
public class RegisterBoardForm {
    private String catName;
    private String title;
    private String content;
    private MultipartFile upfile;

//    private Map<String, Object> hashtag;
}
