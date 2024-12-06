<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<style>
    #content-title:hover {
        text-decoration: underline;
        font-weight: bold;
    }
</style>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center my-4">
    <div class="row p-3 justify-content-center">
        <div class="col mb-3">
            <h2>받은 쪽지함</h2>
        </div>
    </div>

    <div class="row d-flex justify-content-between mb-4">
        <div class="col">
            <a class="nav-link p-3 border-start border-4 border-secondary bg-light" href="/message/list">받은 쪽지</a>
        </div>
        <div class="col">
            <a class="nav-link p-3 border-start border-4 border-secondary bg-light" href="/message/sent">보낸 쪽지</a>
        </div>
    </div>


    <!-- 쪽지 리스트 -->
    <div class="p-1 d-flex justify-content-between align-items-center mb-4">
        <!-- 좌측: 일괄 삭제 및 읽음 처리 버튼 -->
        <div class="d-flex">
            <button type="button" class="btn btn-dark me-2" onclick="deleteSelectedMessages()">일괄 삭제</button>
            <button type="button" class="btn btn-dark" onclick="markAllAsRead()">일괄 읽음</button>
        </div>

        <!-- 우측: 정렬 옵션 -->
        <div class="d-flex align-items-center">
            <!-- 정렬 옵션 -->
            <div class="me-3">
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="sort" value="asc" onchange="changeSort()"
                    ${empty param.sort or param.sort eq 'asc' ? 'checked' : ''}>
                    <label class="form-check-label">최신순</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="sort" value="desc" onchange="changeSort()"
                    ${param.sort eq 'desc' ? 'selected' : ''}>
                    <label class="form-check-label">오래된순</label>
                </div>
            </div>

            <!-- 행 수 선택 -->
            <div>
                <select class="form-select form-select-sm" name="rows" onchange="changeRows()">
                    <option value="5" ${param.rows eq 5 ? 'selected' : ''}>5개씩 보기</option>
                    <option value="10" ${empty param.rows or param.rows eq 10 ? 'selected' : ''}>10개씩 보기</option>
                    <option value="20" ${param.rows eq 20 ? 'selected' : ''}>20개씩 보기</option>
                    <option value="30" ${param.rows eq 30 ? 'selected' : ''}>30개씩 보기</option>
                </select>
            </div>
        </div>
    </div>


    <div class="row p-3">
        <table class="table table-hover">
            <colgroup>
                <col width="5%">
                <col width="5%">
                <col width="10%">
                <col width="*%">
                <col width="5%">
                <col width="5%">
                <col width="5%">
                <col width="5%">
            </colgroup>
            <thead class="text-center">
            <tr>
                <th><input type="checkbox" onclick="toggleSelectAll(this)"></th>  <!-- 일괄 선택 체크박스 -->
                <th>번호</th>
                <th>보낸사람</th>
                <th class="text-start">제목</th>
                <th>받은날</th>
                <th>읽음</th>
                <th>읽은날</th>
                <th>파일</th>
            </tr>
            </thead>
            <tbody class="text-center">
            <c:forEach var="message" items="${messages}">
                <tr>
                    <td><input type="checkbox" name="messageNo" value="${message.messageNo}"></td> <!-- 개별 체크박스 -->
                    <td>${message.messageNo}</td>
                    <td>${message.senderNickname}</td>
                    <td id="content-title" class="text-start">
                        <a href="/message/detail?messageNo=${message.messageNo}"
                           style="text-decoration-line: none; color: black">
                                ${message.title}
                        </a>
                    </td>

                    <td>
                        <fmt:formatDate value="${message.createdDate}" pattern="yyyy-MM-dd"/>
                    </td>
                    <td>${message.readStatus eq 'Y' ? '읽음' : '미읽음'}</td>
                    <td>
                        <c:choose>
                            <c:when test="${message.readStatus eq 'Y'}">
                                <fmt:formatDate value="${message.readDate}" pattern="yyyy-MM-dd"/>
                            </c:when>
                            <c:otherwise>
                                -
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${not empty message.messageFile}">
                            <i class="bi bi-file-earmark-text"></i> <!-- 파일 첨부 아이콘 -->
                        </c:if>
                        <c:if test="${empty message.messageFile}">
                            <i class="bi bi-file-earmark-x"></i> <!-- 파일 첨부 없음 아이콘 -->
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <form id="form-search" action="list" method="get">
        <div class="row p-3 d-flex justify-content-left">
            <div class="col-2">
                <select class="form-select" name="opt">
                    <option value="title" ${param.opt eq 'title' ? 'selected' : ''}>제목</option>
                    <option value="content" ${param.opt eq 'content' ? 'selected' : ''}>내용</option>
                    <option value="senderNickname" ${param.opt eq 'senderNickname' ? 'selected' : ''}>보낸사람</option>
                </select>
            </div>

            <div class="col-2">
                <input type="text" class="form-control" name="keyword" value="${param.keyword}">
            </div>
            <div class="col-1">
                <button type="submit" class="btn btn-outline-dark" onclick="searchKeyword()">검색</button>
            </div>
            <div class="col d-flex justify-content-center">
            </div>
            <!-- 메시지 작성 버튼 -->
            <div class="col d-flex justify-content-end">
                <a href="/message/add" type="button" class="btn btn-dark">쪽지 작성</a>
            </div>
        </div>

        <!-- 페이징 처리 -->
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
    </form>
</div>


<script>
    function deleteSelectedMessages() {
        const selectedMessages = Array.from(document.querySelectorAll('input[name="messageNo"]:checked')).map(checkbox => checkbox.value);
        if (selectedMessages.length === 0) {
            alert("삭제할 메시지를 선택해주세요.");
            return;
        }

        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '/message/delete';

        selectedMessages.forEach(messageNo => {
            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'messageNo';
            input.value = messageNo;
            form.appendChild(input);
        });

        document.body.appendChild(form);
        form.submit();
    }

    function markAllAsRead() {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '/message/markAllAsRead';
        document.body.appendChild(form);
        form.submit();
    }

    function toggleSelectAll(source) {
        const checkboxes = document.querySelectorAll('input[name="messageNo"]');
        checkboxes.forEach(checkbox => checkbox.checked = source.checked);
    }

    // form 태그를 가져온다.
    let form = document.querySelector("#form-search");
    let pageInput = document.querySelector("input[name=page]");

    // 검색 버튼을 클릭했을 때, 요청 파라미터 정보를 제출한다.
    function searchKeyword() {
        pageInput.value = 1;
        form.submit();
    }

    // 페이지 번호 링크를 클릭했을 때 변화
    function changePage(page, event) {
        event.preventDefault();

        pageInput.value = page;
        form.submit();
    }

    // 검색어를 입력하고 검색버튼을 클릭 했을 때
    function searchValue() {
        let pageInput = form.querySelector("input[name=page]");
        pageInput.value = 1;
        form.submit();
    }

    // 정렬방식이 변경될 때
    function changeSort() {
        let form = document.querySelector("#form-search");
        let sortInput = document.querySelector("input[name=sort]");
        sortInput.value = 1;
        form.submit();
    }

    // 한 화면에 표기할 행의 갯수가 변경될 때
    function changeRows() {
        // 페이지 갯수를 클릭했다면 해당 페이징 요청
        let form = document.querySelector("#form-search");
        // 페이지 번호 input 요소 선택
        let rowsInput = document.querySelector("input[name=rows]");
        // 새로 요청하는 페이지는 1로 초기화
        let pageInput = form.querySelector("input[name=page]");
        pageInput.value = 1;
        // 폼 제출
        form.submit();
    }

</script>
</body>
</html>
