package store.seub2hu2.course.vo;

import lombok.*;
import org.apache.ibatis.type.Alias;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Course {
    // 코스 데이터
    private int no; // 코스 번호
    private String name; // 코스 이름
    private int time; // 코스 완주 시간
    private double distance; // 코스 거리
    private int level; // 코스 난이도(단계)
    private int likeCnt; // 좋아요 수
    private int challengeCnt; // 도전 횟수
    private int successCnt; // 성공 횟수
    private String filename; // 파일명
    private Region region; // 지역 번호

    public String getOriginalFilename() {
        if(filename == null) {
            return null;
        }
        return filename.substring(13);

    }
}
