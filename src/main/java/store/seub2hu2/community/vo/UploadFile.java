package store.seub2hu2.community.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class UploadFile {
    private int no;
    private Board board;
    private String originalName;
    private String saveName;
    private String path;
    private String type;
}
