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
            <div class="border p-2 bg-dark text-white fw-bold mb-3">회원가입 완료</div>

        <!-- 로그인 폼 -->
            <div class="mb-3">
                <div class="row">
                        <h1>회원가입이 완료되었습니다.</h1>
                </div>
            </div>
        <div class="mt-4 col-2">
            <a href="/main" class="color-black text-decoration-none fw-bold">메인으로 돌아가기</a>
        </div>
        <div class="mt-4 col-2">
            <a href="/login" class="color-black text-decoration-none fw-bold">로그인하러 가기</a>
        </div>
    </div>

</main>

<!-- 푸터부 -->
<footer>
    <%@include file="/WEB-INF/views/common/footer.jsp" %>
</footer>

</body>
</html>
