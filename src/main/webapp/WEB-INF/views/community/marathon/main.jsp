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

    .overlay-text {
        position: absolute; /* 부모 기준으로 절대 위치 설정 */
        top: 40%; /* 컨테이너의 세로 중심 */
        left: 50%; /* 컨테이너의 가로 중심 */
        transform: translate(-50%, -50%); /* 정확히 중앙으로 이동 */
        color: white; /* 텍스트 색상 */
        font-size: 1.5rem; /* 텍스트 크기 */
        font-weight: bold; /* 텍스트 굵기 */
        text-align: center; /* 텍스트 가운데 정렬 */
        background-color: rgba(0, 0, 0, 0.5); /* 텍스트 배경 반투명 설정 */
        padding: 10px; /* 텍스트 주변 여백 추가 */
        border-radius: 5px; /* 배경의 모서리 둥글게 처리 (선택 사항) */
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
        <a href="hit?no=${marathon.no}" style="text-decoration-line: none">
          <div class="card">
            <img src="${marathon.thumbnail}" class="card-img-top" alt="마라톤 이미지"
                style="height: 200px; filter: ${crew.entered eq 'Y' ? 'grayscale(0%)' : 'grayscale(100%)'};">
            <c:if test="${marathon.marathonDate.time < now.time}">
              <div class="overlay-text ">종료</div>
            </c:if>
            <div class="card-body text-center">
              <h5 class="card-title">${marathon.title}</h5>
              <p class="card-text"><fmt:formatDate value="${marathon.marathonDate}" pattern="yyyy-MM-dd"/></p>
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