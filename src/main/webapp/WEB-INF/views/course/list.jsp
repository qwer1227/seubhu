<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/common/common.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">

    <div class="col m-5">
        <h2>코스</h2>
    </div>
    <div class="row row-cols-2 row-cols-lg-5 g-2 g-lg-3">
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
    <div class="row row-cols-1 row-cols-md-3 g-4 mt-5 mb-5">
        <div class="col">
            <div class="card h-100">
                <a class="text-decoration-none" href="detail.html">
                    <img src="image1.PNG" class="card-img-top" alt="...">
                </a>
                <div class="card-body">
                    <h5 class="card-title">코스1</h5>
                    <a class="text-decoration-none" href="detail.html">
                        <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                    </a>
                </div>
                <div class="card-footer bg-transparent border-primary" >지역 / 거리 / 난이도 / 등록버튼</div>
            </div>
        </div>
        <div class="col">
            <div class="card h-100">
                <a class="text-decoration-none" href="detail.html">
                    <img src="image1.PNG" class="card-img-top" alt="...">
                </a>
                <div class="card-body">
                    <h5 class="card-title">코스2</h5>
                    <a class="text-decoration-none" href="detail.html">
                        <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                    </a>
                </div>
                <div class="card-footer bg-transparent border-primary" >지역 / 거리 / 난이도 / 등록버튼</div>
            </div>
        </div>
        <div class="col">
            <div class="card h-100">
                <a class="text-decoration-none" href="detail.html">
                    <img src="image1.PNG" class="card-img-top" alt="...">
                </a>
                <div class="card-body">
                    <h5 class="card-title">코스3</h5>
                    <a class="text-decoration-none" href="detail.html">
                        <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                    </a>
                </div>
                <div class="card-footer bg-transparent border-primary" >지역 / 거리 / 난이도 / 등록버튼</div>
            </div>
        </div>
        <div class="col">
            <div class="card h-100">
                <a class="text-decoration-none" href="detail.html">
                    <img src="image1.PNG" class="card-img-top" alt="...">
                </a>
                <div class="card-body">
                    <h5 class="card-title">코스4</h5>
                    <a class="text-decoration-none" href="detail.html">
                        <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
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

<%@include file="/WEB-INF/common/footer.jsp" %>
<script type="text/javascript">

</script>
</body>
</html>