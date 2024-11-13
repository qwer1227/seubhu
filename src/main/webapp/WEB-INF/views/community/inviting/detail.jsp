<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
  <%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<style>
    #inviting-table th {
        text-align: center;
    }
    #inviting-table tr{
        height: 50px;
    }
</style>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">
  
  <h2> 크루모임 글 상세페이지 </h2>
  
  <div class="row p-3 m-3">
    <table id="marathon-table" class="text-start">
      <colgroup>
        <col width="10%">
        <col width="40%">
        <col width="10%">
        <col width="40%">
      </colgroup>
      <tbody>
      <tr>
        <div class="col d-flex justify-content-left">
          <a href="" style="text-decoration-line: none">번개</a>
        </div>
      </tr>
      <tr>
        <th colspan="4" style="text-align: start" class="fs-4">마라톤 이름</th>
      </tr>
      <tr>
        <th>일시</th>
        <td>2024.11.09</td>
        <th>접수기간</th>
        <td>2024.07.10 ~ 2024.10.18</td>
      </tr>
      <tr>
        <th>장소</th>
        <td colspan="3">전남 순천시 팔마로 333 (연향동, 순천팔마종합경기장) 순천팔마종합운동장 외 주로코스</td>
      </tr>
      <tr>
        <th>홈페이지</th>
        <td>http://sc-marathon.kr/</td>
        <th>참가비</th>
        <td>15,000원</td>
      </tr>
      <tr>
        <th colspan="4">
          <textarea disabled style="width: 100%">마라톤 디테일</textarea>
        </th>
      </tr>
      <tr>
        <th>다운로드</th>
        <td colspan="3">
          <input type="file" class="form-control" name="download"/>
        </td>
      </tr>
      </tbody>
    </table>
  </div>
  
  <div class="actions d-flex justify-content-between mb-4">
    <div>
      <button class="btn btn-warning">수정</button>
      <button class="btn btn-danger">삭제</button>
      <button class="btn btn-danger">신고</button>
    </div>
    <div>
      <button class="btn btn-outline-dark">
        <i class="bi bi-hand-thumbs-up"></i>
        <i class="bi bi-hand-thumbs-up-fill"></i>
      </button>
      <a type="button" href="main" class="btn btn-secondary">목록</a>
    </div>
  </div>
  
  <div class="comment-form mb-4">
    <h5 style="text-align: start">댓글 작성</h5>
    <div class="row">
      <div class="form-group col-11">
        <textarea class="form-control" rows="3" placeholder="댓글을 작성하세요."></textarea>
      </div>
      <div class="col">
        <button class="btn btn-success">등록</button>
      </div>
    </div>
  </div>
  
  <!-- 댓글 목록 / style은 구현할때 삭제 예정 -->
  <div class="row comments rounded" style="background-color: #c9e0f0">
    <!--댓글 내용 -->
    <div class="comment pt-3">
      <div class="row">
        <div class="col-1">
          <img src="https://github.com/mdo.png" alt="" style="width: 50px" class="rounded-circle">
        </div>
        
        <div class="col d-flex justify-content-between">
          <div style="text-align: start">
            <strong>모모랜드</strong><br/>
            <span>2024.11.07 15:40</span>
          </div>
          <div style="text-align: end">
            <button class="btn btn-warning btn-sm">수정</button>
            <button class="btn btn-danger btn-sm">삭제</button>
          </div>
        </div>
      </div>
      
      <div class="comment-item mt-1" style="border: 1px solid gray;">
        댓글 내용이오
      </div>
      
      <button class="btn btn-outline-dark btn-sm d-flex justify-content-start">답글</button>
    </div>
    
    <!-- 답글 내용 -->
    <div class="row">
      <div class="col-1" style="text-align: end">
        <i class="bi bi-arrow-return-right"></i>
      </div>
      <div class="col-11" style="border: 1px solid gray">
        <div class="col d-flex justify-content-between">
          <div style="text-align: start">
            <img src="https://github.com/mdo.png" alt="" style="width: 35px" class="rounded-circle">
            <strong>모모랜드</strong><br/>
          </div>
          <div style="text-align: end">
            <button class="btn btn-warning btn-sm">수정</button>
            <button class="btn btn-danger btn-sm">삭제</button>
          </div>
        </div>
        <div class="comment-item rounded mt-1" style="border: 1px solid gray;">
          답글 내용이오
        </div>
        <div style="font-size: 10px; text-align: start">
          <span>2024.11.07 04:06</span>
          <button type="button" class="btn"
                  style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">신고
          </button>
        </div>
        <button class="btn btn-outline-dark btn-sm d-flex justify-content-start">답글</button>
      </div>
    </div>
  </div>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>