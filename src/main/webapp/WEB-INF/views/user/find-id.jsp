<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
    <title>아이디 찾기 폼</title>
</head>
<body>
<!-- 헤더부 -->
<header>
    <c:set var="menu" value="home"/>
    <%@include file="/WEB-INF/views/common/nav.jsp" %>
</header>

<!-- 메인 컨텐츠부 -->
<main class="container">
    <div class="container mt-5">
        <div class="login-form mx-auto text-center" style="max-width: 400px;">
            <!-- 아이디 찾기 제목 -->
            <div class="border p-2 bg-dark text-white fw-bold mb-3">아이디 찾기</div>

            <!-- 아이디 찾기 폼 -->
            <form id="forgotIdForm">
                <div class="mb-3">
                    <h6>가입 시 등록하신 이메일을 입력해 주세요.</h6>
                </div>
                <div class="mb-3">
                    <input type="email" class="form-control" placeholder="이메일" id="email">
                </div>
                <button type="submit" class="btn btn-dark w-100">확인</button>
            </form>

            <!-- 결과 표시 영역 -->
            <div id="resultMessage" class="alert d-none"></div>
        </div>
    </div>
</main>

<!-- 푸터부 -->
<footer>
    <%@include file="/WEB-INF/views/common/footer.jsp" %>
</footer>

<script type="text/javascript">

</script>

    </body>
</html>
