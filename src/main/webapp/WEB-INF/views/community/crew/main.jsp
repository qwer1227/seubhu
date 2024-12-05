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
  
  <div>
    <form id="form-search" method="get" action="main">
      <input type="hidden" name="page" value="${param.page != null ? param.page : 1}">
      <input type="hidden" name="category" id="categoryInput" value="${param.category }">
      <div class="category-nav d-flex justify-content-center mb-4">
        <a href="main">전체</a>
        <a href="javascript:void(0)" onclick="changeCategory('Y')">모집중</a>
        <a href="javascript:void(0)" onclick="changeCategory('N')">마감</a>
      </div>
      
      <div class="row row-cols-1 row-cols-md-3 g-4">
        <!-- 카드 1 -->
        <c:forEach var="crew" items="${crews}">
          <div class="col">
            <a href="hit?no=${crew.no}" style="text-decoration-line: none">
              <div class="card">
                <c:choose>
                  <c:when test="${empty crew.thumbnail}">
                    <img src="/resources/images/community/inviting_default_main.jpg" alt="크루 대표 이미지"
                         class="card-img-top"
                         style="height: 200px; filter: ${crew.entered eq 'Y' ? 'grayscale(0%)' : 'grayscale(100%)'}">
                  </c:when>
                  <c:otherwise>
                    <img src="/resources/images/community/${crew.thumbnail.saveName}" alt="크루 대표 이미지"
                         class="card-img-top"
                         style="height: 200px; filter: ${crew.entered eq 'Y' ? 'grayscale(0%)' : 'grayscale(100%)'}">
                  </c:otherwise>
                </c:choose>
                <div class="card-body text-center">
                  <h5 class="card-title">
                      ${crew.title}
                    <c:if test="${crew.replyCnt gt 0}">
                      <span class="badge rounded-pill text-bg-danger">${crew.replyCnt}</span>
                    </c:if>
                  </h5>
                  <p class="card-text">
                      ${crew.name}
                    | <i class="bi bi-eye"></i> ${crew.viewCnt}
                  </p>
                </div>
              </div>
            </a>
          </div>
        </c:forEach>
      </div>
      
      <div class="row p-3 d-flex justify-content-left">
        <div class="col-4">
          <input type="text" class="form-control" name="keyword" value="${param.keyword}">
        </div>
        <div class="col-1">
          <button class="btn btn-outline-primary" onclick="searchKeyword()">검색</button>
        </div>
        <div class="col d-flex justify-content-center">
        
        </div>
        <security:authorize access="isAuthenticated()">
          <security:authentication property="principal" var="loginUser"/>
          <c:if test="${not empty loginUser and loginUser ne null}">
            <div class="col d-flex justify-content-end">
              <a href="form" type="button" class="btn btn-primary">글쓰기</a>
            </div>
          </c:if>
        </security:authorize>
      </div>
    </form>
  </div>
  <%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
<script>
    // 카테고리를 선택했을 때
    function changeCategory(category) {
        let form = document.querySelector("#form-search");
        let catInput = document.querySelector("#categoryInput");
        let pageInput = document.querySelector("input[name=page]");

        catInput.value = category;
        pageInput.value = 1;

        form.submit();
    }
    // 키워드 검색할 때
    function searchKeyword() {
        pageInput.value = 1;
        form.submit();
    }
</script>
</html>