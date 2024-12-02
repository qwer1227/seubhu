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
        <h2>코스</h2>
    </div>
    <%-- 카테고리 --%>
    <div class="row row-cols-2 row-cols-lg-4 g-2 g-lg-3 justify-content-center">
        <div class="col " >
            <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="list">코스 목록</a>
        </div>
        <div class="col " >
            <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="best-runner">런너 랭킹</a>
        </div>
    </div>

    <%-- 코스를 선택하면, 해당 코스에 대한 완주자 기록 목록이 화면에 나타난다. --%>
    <form id="form-select" method="get" action="best-runner">
        <div class="row justify-content-center mt-5">
            <input type="hidden" name="page"/>
            <select class="form-select" aria-label="Default select example" style="width: 300px"
                    name="courseNo" onchange="changeCourse()">
                <option selected value="">코스 선택</option>
                <c:forEach var="course" items="${courses}">
                    <option value="${course.no}" ${param.courseNo eq course.no ? 'selected' : ''}>
                        ${course.name}
                    </option>
                </c:forEach>
            </select>
        </div>
    </form>

    <%-- 나의 현재 코스 완주 기록 및 순위 --%>
    <%-- 해당 코스에 대한 기록이 없다면, 기록이 없다고 표시한다. --%>
    <table class="table mt-4">
        <thead>
            <tr class="table-warning">
                <th scope="col">나의 순위</th>
                <th scope="col">나의 닉네임</th>
                <th scope="col">나의 완주 날짜</th>
                <th scope="col">나의 완주 기록</th>
            </tr>
        </thead>
        <tbody>
            <sec:authorize access="isAuthenticated()">
                <sec:authentication property="principal" var="loginUser" />
            </sec:authorize>

            <c:choose>
                <%-- 로그인했다면, 나의 코스 완주 기록을 화면에 표시한다. --%>
                <c:when test="${not empty loginUser}">
                    <c:choose>
                        <%-- 나의 코스 완주 기록이 존재하면, 나의 코스 완주 기록을 화면에 표시한다. --%>
                        <c:when test="${not empty myRecord}">
                            <c:forEach var="record" items="${myRecord}">
                                <tr>
                                    <th scope="row">${record.no}</th>
                                    <td>${record.user.nickname}</td>
                                    <td><fmt:formatDate value="${record.finishedDate}" pattern="yyyy년 M월 d일" /> </td>
                                    <td>${record.finishedTime}분</td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <%-- 나의 코스 완주 기록이 존재하지 않다면, 문구를 표시한다. --%>
                        <c:otherwise>
                            <tr>
                                <th colspan="4">기록이 존재하지 않습니다!</th>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <%-- 로그인하지 않았다면, 문구를 표시한다. --%>
                <c:otherwise>
                    <tr>
                        <th colspan="4">로그인하여 기록을 확인해보아요!</th>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <%-- 사용자 순위 목록 (10개씩 표시) --%>
    <%-- 해당 코스에 대한 기록이 없다면, 기록이 없다고 표시한다. --%>
    <table class="table mt-5">
        <thead>
            <tr class="table-info">
                <th scope="col">순위</th>
                <th scope="col">닉네임</th>
                <th scope="col">완주 날짜</th>
                <th scope="col">완주 기록</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty records}">
                    <c:forEach var="record" items="${records}">
                        <tr>
                            <th scope="row">${record.no}</th>
                            <td>${record.user.nickname}</td>
                            <td><fmt:formatDate value="${record.finishedDate}" pattern="yyyy년 M월 d일" /> </td>
                            <td>${record.finishedTime}분</td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <th colspan="4">기록이 존재하지 않습니다!</th>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
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
    // form 태그를 가져온다.
    let form = document.querySelector("#form-select");
    let pageInput = document.querySelector("input[name=page]");

    // 페이지 번호를 클릭했을 때, 요청 파라미터 정보를 제출한다.
    function changePage(page, event) {
        event.preventDefault();

        pageInput.value = page;
        form.submit();
    }

    // 코스를 선택할 때마다 1페이지를 요청한다.
    function changeCourse() {
        pageInput.value = 1;
        form.submit();
    }
</script>
</body>
</html>