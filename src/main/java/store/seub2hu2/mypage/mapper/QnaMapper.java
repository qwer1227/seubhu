package store.seub2hu2.mypage.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.security.core.parameters.P;
import store.seub2hu2.mypage.dto.QnaCreateRequest;
import store.seub2hu2.mypage.dto.QnaResponse;

import java.util.List;

@Mapper
public interface QnaMapper {
    List<QnaResponse> getQnasByUserNo(@Param("userNo") int userNo);
    QnaResponse getQnaByQnaNo(@Param("qnaNo") int qnaNo);
    void insertQna(@Param("qna") QnaCreateRequest qnaCreateRequest);
    void deleteQna(@Param("qnaNo") int qnaNo);
    void updateQna(@Param("qnaNo") int qnaNo, @Param("qna") QnaCreateRequest qnaCreateRequest);
}
