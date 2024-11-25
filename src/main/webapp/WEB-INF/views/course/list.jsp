<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">

    <div class="col m-5">
        <h2>코스</h2>
    </div>
    <%-- 카테고리 --%>
    <div class="row row-cols-2 row-cols-lg-4 g-2 g-lg-3">
        <div class="col " >
            <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="#">나의 코스 기록</a>
        </div>
        <div class="col " >
            <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="list">코스 목록</a>
        </div>
        <div class="col " >
            <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="#">코스 랭킹</a>
        </div>
        <div class="col " >
            <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="#">베스트 런너</a>
        </div>
    </div>

    <%-- 검색 기능 --%>
    <%-- 요청 파라미터(검색 정보) : page, distance, level, keyword --%>
    <div class="row row-cols-1 row-cols-md-1 g-4 mt-3 mb-3">
        <div class="col">
            <form id="form-search" method="get" action="list">
                <input type="hidden" name="page" />
                <div class="row g-3 d-flex justify-content-center">
                    <div class="col-5">
                        <label for="customRange2" class="form-label">거리(0~10KM)</label>
                        <input type="range" class="form-range" min="0" max="10" id="customRange2" name="distance"
                               value="${empty param.distance ? '10' : param.distance}">
                    </div>
                    <div class="col-1">
                        난이도
                        <select class="form-select" name="level">
                            <option value=""> 전체</option>
                            <c:forEach var="num" begin="1" end="5">
                                <option value="${num }" ${param.level eq num ? "selected" : ""}> ${num }단계</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-3">
                        지역 검색<input type="text" class="form-control" name="keyword" value="${param.keyword }">
                    </div>
                    <div class="col-1 pt-4">
                        <button type="button" class="btn btn-outline-primary" onclick="searchKeyword()">검색 버튼</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <%-- 코스 목록 --%>
    <div class="row row-cols-1 row-cols-md-4 g-4 mt-5 mb-3">
        <c:forEach var="course" items="${courses }">
            <div class="col-3">
                <div class="card h-100">
                    <a class="text-decoration-none" href="detail?no=${course.no }">
                        <img src="/resources/images/course/${course.filename }" class="card-img-top" alt="...">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title">${course.name }</h5>
                        <a class="text-decoration-none" href="detail?no=${course.no }">
                            <p class="card-text">${course.region.si } ${course.region.gu } ${course.region.dong }</p>
                        </a>
                    </div>
                    <div class="card-footer bg-transparent border-primary" >
                        <span>난이도 : ${course.level }단계</span><span> / 거리 : ${course.distance }KM</span>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<!-- 페이징 내비게이션 -->
<div class="row mb-3">
    <div class="col-12">
        <nav>
            <ul class="pagination justify-content-center">
                <li class="page-item ${pagination.first ? 'disabled' : '' }">
                    <a class="page-link"
                       onclick="changePage(${pagination.prevPage}, event)"
                       href="list?page=${pagination.prevPage}">이전</a>
                </li>

                <c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
                    <li class="page-item ${pagination.page eq num ? 'active' : '' }">
                        <a class="page-link"
                           onclick="changePage(${num }, event)"
                           href="list?page=${num }">${num }</a>
                    </li>
                </c:forEach>

                <li class="page-item ${pagination.last ? 'disabled' : '' }">
                    <a class="page-link"
                       onclick="changePage(${pagination.nextPage}, event)"
                       href="list?page=${pagination.nextPage}">다음</a>
                </li>
            </ul>
        </nav>
    </div>
</div>


<%@include file="/WEB-INF/views/common/footer.jsp" %>
<script type="text/javascript">
    let form = document.querySelector("#form-search"); // form 태그를 가져온다. (name = page, distance, level, keyword)
    let pageInput = document.querySelector("input[name=page]"); // form 태그의 일부 태그를 가져온다. (name = page)

    // 페이지 번호를 클릭했을 때, 요청 파라미터 정보를 제출한다.
    function changePage(page, event) {
        event.preventDefault();

        pageInput.value = page;
        form.submit();
    }

    // 검색 버튼을 클릭했을 때, 요청 파라미터 정보를 제출한다.
    function searchKeyword() {
        pageInput.value = 1;
        form.submit();
    }
</script>
</body>
</html>