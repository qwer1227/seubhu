<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
  <%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<style>
  #content-title:hover{
      text-decoration: black underline;
      font-weight: bold;
  }
</style>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">
  <div class="row p-3 justify-content-center">
    <div class="col mb-3">
      <h2> 커뮤니티 </h2>
    </div>
  </div>
  
  <div class="row">
    <div class="col-7" style="margin: 15px; border: 1px solid black">
      <table class="m-3">
        <tbody>
        <tr>
          <td>
            <a href="" style="text-decoration-line: none; color: black; font-weight: bold">공지사항1</a>
          </td>
        </tr>
        <tr>
          <td>
            <a href="" style="text-decoration-line: none; color: black; font-weight: bold">공지사항2</a>
          </td>
        </tr>
        <tr>
          <td>
            <a href="" style="text-decoration-line: none; color: black; font-weight: bold">공지사항3</a>
          </td>
        </tr>
        <tr>
          <td>
            <a href="" style="text-decoration-line: none; color: black; font-weight: bold">공지사항4</a>
          </td>
        </tr>
        <tr>
          <td>
            <a href="" style="text-decoration-line: none; color: black; font-weight: bold">공지사항5</a>
          </td>
        </tr>
        </tbody>
      </table>
    </div>
    
    <div class="col" style="margin: 15px; border: 1px solid black">
      광고 올 자리
    </div>
  </div>
  
  <div class="row row-cols-2 row-cols-lg-5 g-2 g-lg-3">
    <div class="col " >
      <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="#">전체</a>
    </div>
    <div class="col " >
      <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="#">일반</a>
    </div>
    <div class="col " >
      <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="#">자랑</a>
    </div>
    <div class="col " >
      <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="#">질문</a>
    </div>
    <div class="col " >
      <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="#">훈련일지</a>
    </div>
  </div>
  
  
  <div class="row p-3">
    <table class="table">
      <colgroup>
        <col width="5%">
        <col width="10%">
        <col width="*%">
        <col width="15%">
        <col width="10%">
        <col width="10%">
        <col width="10%">
      </colgroup>
      <thead class="text-start">
      <tr style="text-align: center">
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
      <c:choose>
        <c:when test="${empty boards}">
          <tr>
            <td colspan="7" style="text-align: center">등록된 게시글이 없습니다.</td>
          </tr>
        </c:when>
        <c:otherwise>
          <c:forEach var="board" items="${boards}">
            <tr style="text-align: center">
              <td>${board.no}</td>
              <td>${board.cat.name()}</td>
              <td id="content-title" style="text-align: start">
                <a href="detail?no=${board.no}" style="text-decoration-line: none; color: black">${board.title}</a>
              </td>
              <td>${board.user.id}</td>
              <td>${board.like}</td>
              <td>${board.cnt}</td>
              <td><fmt:formatDate value="${board.createdDate}" pattern="yyyy-MM-dd"/></td>
            </tr>
          </c:forEach>
        </c:otherwise>
      </c:choose>
      </tbody>
    </table>
  </div>
  <div class="row p-3 d-flex justify-content-left">
    <div class="col-2">
      <select class="form-control" name="opt">
        <option value="title"> 게시글 제목</option>
        <option value="content"> 게시글 내용</option>
        <option value="writer"> 작성자</option>
<%--        <option value="hashtag"> 해시태그</option>--%>
      </select>
    </div>
    
    <div class="col-2">
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


<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>