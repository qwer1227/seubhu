package store.seub2hu2.community.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import store.seub2hu2.community.vo.BoardCategory;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class BoardFilterDto {
    private int page;
    private int rows;
    private String sort;
    private String opt;
    private String keyword;
    private BoardCategory category;
}
