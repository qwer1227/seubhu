package store.seub2hu2.lesson.vo;

import lombok.Data;

@Data
public class thumbnail {

    private String uploadFileName;
    private String storeFileName;

    public thumbnail(String uploadFileName, String storeFileName) {
        this.uploadFileName = uploadFileName;
        this.storeFileName = storeFileName;
    }
}
