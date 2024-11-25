package store.seub2hu2.product.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import store.seub2hu2.product.vo.Size;

import java.util.List;


@NoArgsConstructor
@ToString
@Setter
@Getter
public class SizeAmountDto {

    private int no;
    private String name;
    private List<Size> sizes;
}
