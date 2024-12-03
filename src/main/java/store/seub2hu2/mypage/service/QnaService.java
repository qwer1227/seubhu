package store.seub2hu2.mypage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import store.seub2hu2.mypage.dto.QnaCreateRequest;
import store.seub2hu2.mypage.dto.QnaResponse;
import store.seub2hu2.mypage.mapper.QnaMapper;
import store.seub2hu2.security.user.LoginUser;

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

    public void insertQna(QnaCreateRequest qnaCreateRequest, int userNo){

        qnaCreateRequest.setQuestionUserNo(userNo);

        qnaMapper.insertQna(qnaCreateRequest);

    }

    public void deleteQna(int qnaNo){

        qnaMapper.deleteQna(qnaNo);
    }

    public void updateQna(QnaCreateRequest qnaCreateRequest, int qnaNo){

        qnaMapper.updateQna(qnaNo,qnaCreateRequest);
    }
}
