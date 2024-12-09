package store.seub2hu2.mypage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Service;
import store.seub2hu2.admin.dto.RequestParamsDto;
import store.seub2hu2.mypage.dto.AnswerDTO;
import store.seub2hu2.mypage.dto.QnaCreateRequest;
import store.seub2hu2.mypage.dto.QnaResponse;
import store.seub2hu2.mypage.mapper.QnaMapper;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.util.ListDto;
import store.seub2hu2.util.Pagination;

import java.util.List;
import java.util.Map;

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

    public ListDto<QnaResponse> getQnas(Map<String, Object> condition){

        // 검색 조건에 맞는 전체 데이터 개수를 조회하는 기능
        int totalRows = qnaMapper.getTotalRows(condition);

        System.out.println("totalrows" + totalRows);

        // Pagination 객체를 생성한다
        int page = (Integer) condition.get("page");
        int rows = (Integer) condition.get("rows");

        Pagination pagination = new Pagination(page, totalRows, rows);

        // 데이터 검색 범위를 조회해서 Map에 저장한다
        condition.put("begin", pagination.getBegin());
        condition.put("end", pagination.getEnd());

        // ProdListDto 타입의 데이터를 담는 ListDto객체를 생성한다
        // 질문 목록 ListDto(QnaReponse), 페이징처리 정보(Pagination)을 담는다
        List<QnaResponse> qnas = qnaMapper.getQnas(condition);
        System.out.println(qnas);
        ListDto<QnaResponse> dto = new ListDto<>(qnas,pagination);

        return dto;
    }

    public ListDto<QnaResponse> getQnas2(RequestParamsDto requestParamsDto){

        // 검색 조건에 맞는 전체 데이터 개수를 조회하는 기능
        int totalRows = qnaMapper.getTotalRows2(requestParamsDto);

        System.out.println("totalrows" + totalRows);

        // Pagination 객체를 생성한다
        int page = requestParamsDto.getPage();
        int rows = requestParamsDto.getRows();

        Pagination pagination = new Pagination(page, totalRows, rows);

        // 데이터 검색 범위를 조회해서 Map에 저장한다
        //condition.put("begin", pagination.getBegin());
        requestParamsDto.setBegin(pagination.getBegin());
        //condition.put("end", pagination.getEnd());
        requestParamsDto.setEnd(pagination.getEnd());

        // ProdListDto 타입의 데이터를 담는 ListDto객체를 생성한다
        // 질문 목록 ListDto(QnaReponse), 페이징처리 정보(Pagination)을 담는다
        List<QnaResponse> qnas = qnaMapper.getQnas2(requestParamsDto);
        System.out.println(qnas);
        ListDto<QnaResponse> dto = new ListDto<>(qnas,pagination);

        return dto;
    }

    public void updateAnswer(AnswerDTO answerDTO, int userNo){

        qnaMapper.updateAnswer(answerDTO,userNo);
    }
}
