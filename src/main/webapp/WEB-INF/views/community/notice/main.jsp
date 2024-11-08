<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
  <%@include file="/WEB-INF/common/common.jsp" %>
</head>
<style>
    #content-title:hover{
        text-decoration: black underline;
        font-weight: bold;
    }
</style>
<body>
<%@include file="/WEB-INF/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">
  <div class="row p-3 justify-content-center">
    <div class="col mb-3">
      <h2> 공지사항 </h2>
    </div>
  </div>

  
  <div class="row d-flex justify-content-between">
    <div class="col " >
      <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="#">공지사항</a>
    </div>
    <div class="col " >
      <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="#">자주묻는 질문</a>
    </div>
  </div>
  
  
  <div class="row p-3">
    <table class="table">
      <colgroup>
        <col width="5%">
        <col width="10%">
        <col width="*%">
        <col width="10%">
        <col width="10%">
        <col width="10%">
        <col width="10%">
      </colgroup>
      <thead class="text-start">
      <tr>
        <th>번호</th>
        <th>분류</th>
        <th>제목</th>
        <th>작성자</th>
        <th>추천</th>
        <th>조회</th>
        <th>날짜</th>
      </tr>
      </thead>
      <tbody class="text-start">
      <tr>
        <td>1</td>
        <td>자유게시판</td>
        <td id="content-title">
          <a href="detail" style="text-decoration-line: none; color: black">재밌는이야기</a>
        </td>
        <td>고길동</td>
        <td>2345</td>
        <td>5</td>
        <td>2024-10-27</td>
      </tr>
      </tbody>
    
    </table>
  </div>
  <div class="row p-3 d-flex justify-content-left">
    <div class="col-4">
      <input type="text" class="form-control" name="value" value="">
    </div>
    <div class="col-1">
      <button class="btn btn-outline-primary">검색</button>
    </div>
    <div class="col d-flex justify-content-center">
    
    </div>
    <div class="col d-flex justify-content-end">
      <a href="form" type="button" class="btn btn-primary">글쓰기</a>
    </div>
  </div>
  <div>
    <a href=""><<</a>
    <a href="">1</a>
    |
    <a href="">2</a>
    |
    <a href="">3</a>
    <a href="">>></a>
  </div>
</div>
<%@include file="/WEB-INF/common/footer.jsp" %>
</body>
</html>