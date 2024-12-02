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
        <h2>나의 코스 기록</h2>
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
            <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="runner-ranking">런너 랭킹</a>
        </div>
    </div>

    <sec:authorize access="isAuthenticated()">
        <sec:authentication property="principal" var="loginUser" />
    </sec:authorize>

    <%-- 로그인한 사용자의 배지와 코스 기록 표시 --%>
    <div class="row row-cols-1 row-cols-md-1 g-4 mt-3 mb-3">
        <div class="col">
            <c:choose>
                <c:when test="${not empty loginUser}">
                    <table class="table table-bordered">
                        <div class="card">
                            <div class="card-header">나의 배지와 코스 기록</div>
                        </div>
                        <tbody>
                        <tr>
                            <th scope="row">닉네임</th>
                            <td>${loginUser.nickname}</td>
                        </tr>
                        <tr>
                            <th scope="row">현재 배지</th>
                            <td>
                                <c:forEach var="userBadge" items="${userBadges}">
                                    <div>
                                        <img src="/resources/images/badge/${userBadge.badge.image}" width="40px" height="40px">
                                        ${userBadge.badge.name} : ${userBadge.badge.description}
                                    </div>
                                </c:forEach>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">현재 도전 가능한 난이도</th>
                            <td>${userLevel.level}단계</td>
                        </tr>
                        <tr>
                            <th scope="row">나의 완주 기록</th>
                            <td><button class="btn btn-primary" onclick="seeUserFinishRecords(${loginUser.no})">완주 기록 보기</button></td>
                        </tr>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <table class="table table-bordered">
                        <th colspan="4">로그인하면 나의 배지와 코스 기록을 확인할 수 있어요!</th>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<%-- 완주 기록 보기 Modal창 --%>
<div class="modal fade" id="modal-finish-records" tabindex="-1" aria-labelledby="modal-finish-records" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <%-- 완주 기록 목록 --%>
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modal-user-finish-records">${loginUser.nickname}님의 코스 완주 기록</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="table">
                    <thead>
                    <tr class="table-info">
                        <th scope="col">번호</th>
                        <th scope="col">코스 이름</th>
                        <th scope="col">코스 거리</th>
                        <th scope="col">코스 난이도</th>
                        <th scope="col">완주 날짜</th>
                        <th scope="col">완주 시간</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <th><span>1</span></th>
                        <td><span>석촌호수</span></td>
                        <td><span>3KM</span></td>
                        <td><span>1단계</span></td>
                        <td><span>2024년 7월 10일</span></td>
                        <td><span>30분</span></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <%-- 페이징 처리 --%>
            <div class="row mb-3">
                <div class="col-12">
                    <nav>
                        <ul class="pagination justify-content-center">
                            <li class="page-item">
                                <button class="btn btn-primary" onclick="prevModalPage()">이전</button> <%-- 이전 페이지를 클릭하면, 1페이지 이전으로 이동 --%>
                            </li>
                            <li class="page-item">
                                <button class="btn btn-outline-dark" onclick="currentModalPage()">현재 페이지</button> <%-- 현재 페이지를 클릭하면, 현재 페이지로 이동 --%>
                            </li>
                            <li class="page-item">
                                <button class="btn btn-primary" onclick="nextModalPage()">다음</button> <%-- 다음 페이지를 클릭하면, 1페이지 이후로 이동 --%>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>

            <%-- 닫기 버튼 --%>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/views/common/footer.jsp" %>
<script type="text/javascript">
    // 완주 기록 보기 Modal창을 가져온다.
    let myModal = new bootstrap.Modal('#modal-finish-records');

    // 로그인 후 완주 기록 보기 버튼을 클릭하면, 로그인한 사용자의 완주 기록을 확인한다. (Modal창을 열 때마다 항상 1페이지 표시)
    async function seeUserFinishRecords(userNo) {
        // 1. 완주 기록 데이터를 가져온다.
        let response = await fetch("/course/finishRecords");

        // 2. List 데이터를 javascript 객체로 변환한다.

        // 3. 데이터를 완주 기록 목록 안에 저장한다.

        // 페이지를 클릭할 때마다 해당 페이지로 이동한다.

        // 4. Modal창을 화면에 표시한다.
        myModal.show();
    }
</script>
</body>
</html>