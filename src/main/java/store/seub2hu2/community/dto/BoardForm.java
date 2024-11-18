package store.seub2hu2.community.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;
import store.seub2hu2.community.vo.BoardCategory;
import store.seub2hu2.community.vo.Hashtag;

import java.util.Date;
import java.util.Map;

@NoArgsConstructor
@Getter
@Setter
public class BoardForm {
    private String catName;
    private String title;
    private String content;
    private MultipartFile upfile;

//    private Map<String, Object> hashtag;
}
