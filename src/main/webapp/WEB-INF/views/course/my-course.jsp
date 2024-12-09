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
    <div class="row row-cols-1 row-cols-md-1 g-4 mt-3">
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
                                <c:choose>
                                    <c:when test="${not empty userBadges}">
                                        <c:forEach var="userBadge" items="${userBadges}">
                                            <div>
                                                <img src="/resources/images/badge/${userBadge.badge.image}" width="40px" height="40px">
                                                    ${userBadge.badge.name} : ${userBadge.badge.description}
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div>획득한 배지가 없습니다.</div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">현재 도전 가능한 난이도</th>
                            <td>${userLevel.level}단계</td>
                        </tr>
                        <tr>
                            <th scope="row">나의 완주 기록</th>
                            <td><button class="btn btn-primary" onclick="showFinishRecords()">완주 기록 보기</button></td>
                        </tr>
                        </tbody>
                    </table>

                    <div class="card">
                        <div class="card-header">도전할 코스 목록</div>
                    </div>
                    <table class="table">
                        <thead>
                        <tr class="table-info">
                            <th scope="col">번호</th>
                            <th scope="col">이름</th>
                            <th scope="col">지역</th>
                            <th scope="col">거리</th>
                            <th scope="col">난이도</th>
                            <th scope="col"></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="courseToChallenge" items="${coursesToChallenge}" varStatus="loop">
                            <tr>
                                <td><span>${pagination.begin + loop.index}</span></td>
                                <td><a href="detail?no=${courseToChallenge.no}"><span>${courseToChallenge.name}</span></a></td>
                                <td><span>${courseToChallenge.region.si} ${courseToChallenge.region.gu} ${courseToChallenge.region.dong}</span></td>
                                <td><span>${courseToChallenge.distance}KM</span></td>
                                <td><span>${courseToChallenge.level}단계</span></td>
                                <td>
                                    <span>
                                        <a href="cancelChallenge?courseNo=${courseToChallenge.no}&page=${pagination.page}"
                                         class="btn btn-danger" onclick="cancelChallenge(event)">삭제</a>
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
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

<!-- 페이징 내비게이션 -->
<div class="row mb-3">
    <div class="col-12">
        <nav>
            <form id="form-myCoursesToChallenge" method="get" action="my-course">
                <input type="hidden" name="page"/>
                <ul class="pagination justify-content-center">
                    <li class="page-item ${pagination.first ? 'disabled' : '' }">
                        <a class="page-link"
                           onclick="changePage(${pagination.prevPage}, event)"
                           href="my-course?page=${pagination.prevPage}">이전</a>
                    </li>

                    <c:forEach var="num" begin="${pagination.beginPage }" end="${pagination.endPage }">
                        <li class="page-item ${pagination.page eq num ? 'active' : '' }">
                            <a class="page-link"
                               onclick="changePage(${num }, event)"
                               href="my-course?page=${num }">${num }</a>
                        </li>
                    </c:forEach>

                    <li class="page-item ${pagination.last ? 'disabled' : '' }">
                        <a class="page-link"
                           onclick="changePage(${pagination.nextPage}, event)"
                           href="my-course?page=${pagination.nextPage}">다음</a>
                    </li>
                </ul>
            </form>
        </nav>
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
                <table class="table" id="finish-records">
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
                    <tbody></tbody>
                </table>
            </div>

            <%-- 페이징 처리 --%>
            <div class="row mb-3">
                <div class="col-12">
                    <nav>
                        <ul class="pagination justify-content-center" id="current-paging"></ul>
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
    // 도전할 코스 목록 페이지 번호를 클릭했을 때, 요청 파라미터 정보를 제출한다.
    function changePage(page, event) {
        event.preventDefault();

        let form = document.querySelector("#form-myCoursesToChallenge");
        let pageInput = document.querySelector("input[name=page]");

        pageInput.value = page;
        form.submit();
    }

    // 등록 취소 버튼을 클릭하면, 확인창이 표시된다.
    function cancelChallenge(event) {
        if (confirm("도전할 코스 목록에서 제외하시겠습니까?")) {
            alert("도전할 코스 목록에서 제외되었습니다!");
        } else {
            event.preventDefault();
        }
    }

    // 완주 기록 보기 Modal창을 가져온다.
    let myModal = new bootstrap.Modal('#modal-finish-records');

    // 완주 기록 보기 버튼을 클릭하면, 완주 기록을 보여준다.
    function showFinishRecords() {
        getFinishRecords(1);
    }

    // 완주 기록 보기 버튼을 클릭하면, 로그인한 사용자의 완주 기록을 확인한다.
    async function getFinishRecords(page, event) {
        // 1. 페이지 클릭 시 링크 이동을 방지한다.
        if (event) {
            event.preventDefault();
        }

        // 2. 완주 기록, 페이징 처리 정보 데이터를 가져온다.
        let response = await fetch("/course/finishRecords?page=" + page);

        // 3. 데이터를 javascript 객체로 변환하고, 변수에 저장한다.
        let result = await response.json();
        let records = result.data;
        let paging = result.paging;
        let num = paging.begin;

        // 4. 완주 기록 목록을 화면에 표시한다.
        let rows = "";

        for (let record of records) {
            rows += `
                <tr>
                    <th><span>\${num}</span></th>
                    <td><a href="detail?no=\${record.course.no}"><span>\${record.course.name}</span></a></td>
                    <td><span>\${record.course.distance}KM</span></td>
                    <td><span>\${record.course.level}단계</span></td>
                    <td><span>\${record.finishedDate}</span></td>
                    <td><span>\${record.finishedTime}분</span></td>
                </tr>
            `;
            num++;
        }

        document.querySelector("#finish-records tbody").innerHTML = rows;

        // 5. 페이징 처리 기능을 화면에 표시한다.
        let pages = "";

        pages += `
            <li class="page-item \${paging.first ? 'disabled' : ''}">
                <a class="page-link" href="" onclick="getFinishRecords(\${paging.prevPage}, event)">이전</a>
            </li>
        `

        for (let num = paging.beginPage; num <= paging.endPage; num++) {
            pages += `
                <li class="page-item ">
                    <a class="page-link \${paging.page == num ? 'active' : ''}"
                        href="" onclick="getFinishRecords(\${num}, event)">\${num}</a>
                </li>
            `;
        }

        pages += `
            <li class="page-item \${paging.last ? 'disabled' : ''}">
                <a class="page-link" href="" onclick="getFinishRecords(\${paging.nextPage}, event)">다음</a>
            </li>
        `;

        document.querySelector("#current-paging").innerHTML = pages;

        // 6. Modal창을 화면에 표시한다.
        myModal.show();
    }

</script>
</body>
</html>