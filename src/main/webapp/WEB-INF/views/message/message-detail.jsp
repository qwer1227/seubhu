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

    <h2> 쪽지 상세 </h2>

    <div>
        <div class="col d-flex justify-content-left">
            <div>
                <a href="" style="text-decoration-line: none">받은 쪽지</a>
            </div>
        </div>
        <div class="title h4 d-flex justify-content-between align-items-center">
            <div>
                아몬드가 죽으면?
            </div>
            <div class="ml-auto">
                2024-11-27
            </div>
        </div>
        <div class="meta d-flex justify-content-between mb-3">
            <span>깔깔유머</span>
            <span><i class="bi bi-eye"></i> 100  <i class="bi bi-hand-thumbs-up"></i> 10</span>
        </div>

        <div class="content mb-4">
            <p>다이아몬드</p>
        </div>

        <div class="actions d-flex justify-content-between mb-4">
            <div>
                <!-- 관리자만 볼 수 있는 버튼 -->
                <button class="btn btn-warning">수정</button>
                <button class="btn btn-danger">삭제</button>
            </div>
            <div>
                <button class="btn btn-outline-dark">
                    <i class="bi bi-hand-thumbs-up"></i>
                    <i class="bi bi-hand-thumbs-up-fill"></i>
                </button>
                <a type="button" href="message-list.jsp" class="btn btn-secondary">목록</a>
            </div>
        </div>
    </div>
    <%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>