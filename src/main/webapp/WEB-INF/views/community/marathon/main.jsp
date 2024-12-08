<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
  <%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<style>
    .category-nav a {
        font-size: 20px;
        font-weight: bolder;
        color: #0064FF;
        padding: 10px 20px;
        border: 2px solid #0064FF;
        border-radius: 5px;
        text-decoration: none;
        margin: 0 10px;
    }

    .category-nav a:hover {
        background-color: #0064FF;
        color: white;
    }
</style>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">
  
  <h2> 마라톤 정보 </h2>
  <div class="category-nav d-flex justify-content-center mb-4">
    <a href="#">전체</a>
    <a href="#">진행중</a>
    <a href="#">종료</a>
  </div>
  
  <div class="row row-cols-1 row-cols-md-3 g-4">
    <!-- 카드 1 -->
    <c:forEach var="marathon" items="${marathons}">
    <div class="col">
      <a href="detail" style="text-decoration-line: none">
      <div class="card">
        <img src="${marathon.thumbnail}" style="height: 200px" class="card-img-top" alt="마라톤 이미지">
        <div class="card-body text-center">
          <h5 class="card-title">${marathon.title}</h5>
          <p class="card-text">${marathon.date}</p>
        </div>
      </div>
      </a>
    </div>
    </c:forEach>
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
  <%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>