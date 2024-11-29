message-list.jsp<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<style>
    #content-title:hover{
        text-decoration: black underline;
        font-weight: bold;
    }
</style>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">
    <div class="row p-3 justify-content-center">
        <div class="col mb-3">
            <h2> 보낸 쪽지함 </h2>
        </div>
    </div>


    <div class="row d-flex justify-content-between">
        <div class="col " >
            <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="#">받은 쪽지</a>
        </div>
        <div class="col " >
            <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="#">보낸 쪽지</a>
        </div>
    </div>


    <div class="row p-3">
        <table class="table">
            <colgroup>
                <col width="5%">
                <col width="10%">
                <col width="*%">
                <col width="10%">
                <col width="10%">
            </colgroup>
            <thead>
            <tr style="text-align: center">
                <th>번호</th>
                <th>제목</th>
                <th>보낸사람</th>
                <th>받은날짜</th>
                <th>읽음여부</th>
                <th>읽은날짜</th>
            </tr>
            </thead>
            <tbody style="text-align: center">
            <tr>
                <td>1</td>
                <td>아몬드가 죽으면?</td>
                <td>깔깔유머</td>
                <td>2024-11-27</td>
                <td>Y</td>
                <td>2024-11-29</td>
            </tr>
            <tr>
                <td>1</td>
                <td>배치고사 안내</td>
                <td>Riot Games</td>
                <td>2024-11-27</td>
                <td>N</td>
                <td>-</td>
            </tr>
            </tbody>

        </table>
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
    <!-- 페이징 처리 -->
            <div class="row mb-3">
				<div class="col-12">
                    <nav>
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${paging.first? 'disabled' : ''}">
                                <a class="page-link"
                                onclick="changePage(${paging.prevPage}, event)"
                                href="list?page=${paging.prevPage}">이전</a>
                            </li>
                            <c:forEach var="num" begin="${paging.beginPage}" end="${paging.endPage}">
                                <li class="page-item ${paging.page eq num ? 'active' : ''}">
                                    <a class="page-link"
                                    onclick="changePage(${num}, event)"
                                    href="list?page=${num}">${num}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${paging.last ? 'disabled' : ''}" >
                                <a class="page-link"
                                onclick="changePage(${paging.nextPage}, event)"
                                href="list?page=${paging.nextPage}">다음</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
</div>

<script type="text/javascript">
    const form = document.querySelector("#form-search")
    const pageInput = document.querySelector("input[name=page]");

    // 페이지 번호 링크를 클릭했을 때 변화
    function changePage(page, event) {
        event.preventDefault();
        // 페이지 번호 링크를 클릭했다면 해당 페이징 요청
        pageInput.value = page;

        form.submit();
    }
</script>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>