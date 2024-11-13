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
            <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="#">코스 목록</a>
        </div>
        <div class="col " >
            <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="#">코스 랭킹</a>
        </div>
        <div class="col " >
            <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="#">베스트 런너</a>
        </div>
    </div>

    <%-- 검색 기능 --%>
    <%-- 요청 파라미터(검색 정보) : page, distance, level, si, gu, keyword --%>
    <div class="row row-cols-1 row-cols-md-1 g-4 mt-3 mb-3">
        <div class="col">
            <form id="form-search" method="get" action="list">
                <input type="hidden" name="page" />
                <div class="row g-3 d-flex justify-content-center">
                    <div class="col-4">
                        거리
                    </div>
                    <div class="col-1">
                        난이도
                        <select class="form-select" name="level">
                            <option value="1" ${param.opt eq '1' ? 'selected' : '' }> 1단계</option>
                            <option value="2" ${param.opt eq '2' ? 'selected' : '' }> 2단계</option>
                            <option value="3" ${param.opt eq '3' ? 'selected' : '' }> 3단계</option>
                            <option value="4" ${param.opt eq '4' ? 'selected' : '' }> 4단계</option>
                            <option value="5" ${param.opt eq '5' ? 'selected' : '' }> 5단계</option>
                        </select>
                    </div>
                    <div class="col-1">
                        시
                        <select class="form-select col" name="si">
                            <option value="1" ${param.opt eq '1' ? 'selected' : '' }> 서울시</option>
                            <option value="2" ${param.opt eq '2' ? 'selected' : '' }> 경기도</option>
                        </select>
                    </div>
                    <div class="col-2">
                        구
                        <select class="form-select col" name="gu">
                            <option value="1" ${param.opt eq '1' ? 'selected' : '' }> 성동구</option>
                            <option value="2" ${param.opt eq '2' ? 'selected' : '' }> 동대문구</option>
                            <option value="2" ${param.opt eq '2' ? 'selected' : '' }> 은평구</option>
                        </select>
                    </div>
                    <div class="col-3">
                        검색어<input type="text" class="form-control" name="keyword" value="${param.keyword }">
                    </div>
                    <div class="col-1">
                        <button type="button" class="btn btn-outline-primary" onclick="searchKeyword()">검색 버튼</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <%-- 코스 목록 --%>
    <div class="row row-cols-1 row-cols-md-3 g-4 mt-5 mb-5">
        <div class="col">
            <div class="card h-100">
                <a class="text-decoration-none" href="detail.html">
                    <img src="image1.PNG" class="card-img-top" alt="...">
                </a>
                <div class="card-body">
                    <h5 class="card-title">코스1</h5>
                    <a class="text-decoration-none" href="detail.html">
                        <p class="card-text">코스 사진</p>
                    </a>
                </div>
                <div class="card-footer bg-transparent border-primary" >지역 / 거리 / 난이도 / 등록버튼</div>
            </div>
        </div>
    </div>
</div>

<!-- 페이징 내비게이션 -->
<div class="row mb-3">
    <div class="col-12">
        <nav>
            <ul class="pagination justify-content-center">
                <li class="page-item ${paging.first ? 'disabled' : '' }">
                    <a class="page-link" onclick="changePage(${paging.prevPage }, event)" href="list?page=${paging.prevPage }">이전</a>
                </li>

                <c:forEach var="num" begin="${paging.beginPage }" end="${paging.endPage }">
                    <li class="page-item ${paging.page eq num ? 'active' : '' }">
                        <a class="page-link" onclick="changePage(${num }, event)" href="list?page=${num }">${num }</a>
                    </li>
                </c:forEach>

                <li class="page-item ${paging.last ? 'disabled' : '' }">
                    <a class="page-link" onclick="changePage(${paging.nextPage }, event)" href="list?page=${paging.nextPage }">다음</a>
                </li>
            </ul>
        </nav>
    </div>
</div>

<%@include file="/WEB-INF/views/common/footer.jsp" %>
<script type="text/javascript">
    // 페이지 번호를 클릭했을 때
    function changePage(page, event) {
        event.preventDefault(); // 클릭해서 링크를 이동하면 안 되기 때문에, 사전에 링크 이동 방지

        let form = document.querySelector("#form-search");
        let input = document.querySelector("input[name=page]");

        input.value = 1; // page의 값으로 1을 저장한 후,
        form.submit(); // <form id="form-search" ...> 태그의 name(page, opt, keyword)을 서버에 요청 파라미터 정보로 제출한다.
    }

    // 검색 버튼을 클릭했을 때
    function searchKeyword() {
        let form = document.querySelector("#form-search");
        let input = document.querySelector("input[name=page]");

        input.value = 1; // page의 값으로 1을 저장한 후,
        form.submit(); // <form id="form-search" ...> 태그의 name(page, opt, keyword)을 서버에 요청 파라미터 정보로 제출한다.
    }
</script>
</body>
</html>