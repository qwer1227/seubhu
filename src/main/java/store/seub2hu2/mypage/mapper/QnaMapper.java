package store.seub2hu2.mypage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import store.seub2hu2.mypage.dto.QnaResponse;

import java.util.List;

@Mapper
public interface QnaMapper {
    List<QnaResponse> getQnasByUserNo(@Param("userNo") int userNo);
    QnaResponse getQnaByQnaNo(@Param("qnaNo") int qnaNo);
}
