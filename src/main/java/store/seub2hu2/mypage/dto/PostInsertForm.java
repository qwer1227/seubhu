package store.seub2hu2.mypage.dto;

import lombok.*;
import store.seub2hu2.mypage.vo.Post;

@NoArgsConstructor
@AllArgsConstructor
@ToString
@Getter
@Setter
public class PostInsertForm {

    private int no;
    private Post post;
}
