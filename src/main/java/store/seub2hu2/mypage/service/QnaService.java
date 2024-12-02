package store.seub2hu2.mypage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import store.seub2hu2.mypage.dto.QnaResponse;
import store.seub2hu2.mypage.mapper.QnaMapper;

import java.util.List;

@Service
public class QnaService {

    @Autowired
    private QnaMapper qnaMapper;

    public List<QnaResponse> getQnasByUserNo(int userNo){

        List<QnaResponse> qnaResponses = qnaMapper.getQnasByUserNo(userNo);

        return qnaResponses;
    }

    public QnaResponse getQnaByQnaNo(int qnaNo){

        QnaResponse qnaResponse = qnaMapper.getQnaByQnaNo(qnaNo);

        return qnaResponse;
    }
}
