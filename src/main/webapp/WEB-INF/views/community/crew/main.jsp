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
  
  <h2> 습습후후 러닝 크루 </h2>
  <div class="category-nav d-flex justify-content-center mb-4">
    <a href="#">모집중</a>
    <a href="#">마감</a>
  </div>
  
  <div class="row row-cols-1 row-cols-md-3 g-4">
    <!-- 카드 1 -->
    <c:forEach var="crew" items="${crews}">
      <div class="col">
        <a href="detail" style="text-decoration-line: none">
          <div class="card">
          <c:choose>
          <c:when test="${empty crew.thumbnail}">
            <img src="/resources/images/community/inviting_default_main.jpg" alt="크루 대표 이미지" class="card-img-top"
                 style="height: 200px; filter: ${crew.joined ? 'grayscale(0%)' : 'grayscale(100%)'}">
          </c:when>
          <c:otherwise>
            <img src="/resources/images/community/${crew.thumbnail.saveName}" alt="크루 대표 이미지" class="card-img-top"
                   style="height: 200px; filter: ${crew.joined ? 'grayscale(0%)' : 'grayscale(100%)'}">
          </c:otherwise>
          </c:choose>
            <div class="card-body text-center">
              <h5 class="card-title">${crew.title}</h5>
              <p class="card-text">${crew.name} | 지역</p>
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