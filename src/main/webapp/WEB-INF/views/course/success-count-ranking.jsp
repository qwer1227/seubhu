<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
        <h2>런너 랭킹</h2>
    </div>
    <%-- 카테고리 --%>
    <div class="row row-cols-2 row-cols-lg-4 g-2 g-lg-3 justify-content-center">
        <div class="col " >
            <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="my-course">나의 코스 기록</a>
        </div>
        <div class="col " >
            <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="list">코스 목록</a>
        </div>
        <div class="col " >
            <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="shortest-record-ranking">런너 랭킹</a>
        </div>
    </div>

    <%-- 런너 순위를 종류별로 선택한다. --%>
    <div class="mt-5">
        <a class="btn btn-primary" href="success-count-ranking" role="button">코스 달성 수 순위</a>
        <a class="btn btn-primary" href="shortest-record-ranking" role="button">최단 기록 순위</a>
    </div>

    <%-- 나의 코스 달성 수 순위 --%>
    <%-- 기록이 없는 경우, 기록이 없다고 표시한다. / 로그인하지 않은 경우, 로그인해야 확인 가능하다고 표시한다. --%>
    <table class="table mt-4">
        <sec:authorize access="isAuthenticated()">
            <sec:authentication property="principal" var="loginUser"/>
            <c:if test="${!empty loginUser}">
                <c:choose>
                    <c:when test="${successCountRank != null}">
                        <thead>
                        <tr class="table-warning">
                            <th scope="col">나의 순위</th>
                            <th scope="col">나의 닉네임</th>
                            <th scope="col">나의 코스 달성 수</th>
                            <th scope="col">달성한 코스</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <th>${successCountRank.ranking}</th>
                            <td>${successCountRank.nickName}</td>
                            <td>${successCountRank.successCount}</td>
                            <td><button class="btn btn-primary">달성한 코스 목록</button></td>
                        </tr>
                        </tbody>
                    </c:when>
                    <c:otherwise>
                        <thead>
                        <tr class="table-warning">
                            <th scope="col">나의 순위</th>
                            <th scope="col">나의 닉네임</th>
                            <th scope="col">나의 코스 달성 수</th>
                            <th scope="col">달성한 코스</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <th colspan="4">완주한 코스가 없어서 기록이 존재하지 않습니다!</th>
                        </tr>
                        </tbody>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </sec:authorize>
        <c:if test="${empty loginUser}">
            <tr>
                <td>로그인 후 나의 순위를 확인할 수 있습니다!</td>
            </tr>
        </c:if>
    </table>

    <%-- 모든 사용자의 코스 달성 수 순위 --%>
    <table class="table mt-5">
        <thead>
            <tr class="table-info">
                <th scope="col">순위</th>
                <th scope="col">닉네임</th>
                <th scope="col">코스 달성 수</th>
                <th scope="col">달성한 코스</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="successCountRank" items="${successCountRanks}">
                <tr>
                    <th>${successCountRank.ranking}</th>
                    <td>${successCountRank.nickName}</td>
                    <td>${successCountRank.successCount}</td>
                    <td><button class="btn btn-primary">달성한 코스 목록</button></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <%-- 페이징 처리 --%>
    <div class="row mb-3">
        <div class="col-12">
            <nav>
                <form id="form-pagination" method="get" action="success-count-ranking">
                    <input type="hidden" name="page"/>
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
                </form>
            </nav>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/views/common/footer.jsp" %>
<script type="text/javascript">
    let form = document.querySelector("#form-pagination");
    let pageInput = document.querySelector("input[name=page]");

    // 페이지를 선택할 때마다 해당 페이지로 이동한다.
    function changePage(page, event) {
        event.preventDefault();

        pageInput.value = page;
        form.submit();
    }
</script>
</body>
</html>