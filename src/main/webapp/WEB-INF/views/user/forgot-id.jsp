<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <style>
        a:link {
            color : black;
            text-decoration: none;
        }
        a:active {
            color : black;
            text-decoration: none;
        }
        .login-form { max-width: 400px; margin: auto; }
    </style>
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
    <div class="login-form text-center mt-5">
        <!-- 아이디 찾기 제목 -->
        <div class="border p-2 bg-dark text-white fw-bold mb-3">아이디 찾기</div>

        <!-- 아이디 찾기 폼 -->
        <form method="post" action="login">
            <div class="mb-3">
                 가입 시 등록하신 이메일을 입력해 주세요.
            </div>
            <div class="mb-3">
                <input type="text" class="form-control" placeholder="이메일" name="email">
            </div>
            <button type="submit" class="btn btn-dark w-100 mb-3">확인</button>
        </form>
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
