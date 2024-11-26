package store.seub2hu2.admin.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

@NoArgsConstructor
@Getter
@Setter
public class ProductRegisterForm {

    private String name;
    private int price;
    private int brandNo;
    private int categoryNo;
    private int categoryDetailNo;
    private int sizeNo;
    private String color;
    private String content;
    private MultipartFile thumbnail;
    private MultipartFile image;
}
