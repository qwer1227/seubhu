package store.seub2hu2.course.vo;

import lombok.*;
import org.apache.ibatis.type.Alias;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
@Alias("Review")
public class Review {
    // 코스 리뷰 데이터
    private int no; // 리뷰 번호
    private String title; // 리뷰 제목
    private String content; // 리뷰 내용
    private int likeCnt; // 좋아요 수
    private Date createdDate; // 작성날짜
    private Date updatedDate; // 수정날짜
    private String isDeleted; // 삭제여부
//  private User user; // 회원번호
    private Course course; // 코스번호
}
