<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <style>
        a:link {
            text-decoration: none;
        }
        a:active {
            text-decoration: none;
        }
        .btn-social {
            width: 100%;
            font-weight: bold;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 10px;
        }
        .btn-social img {
            width: 100%;
        }
        .login-form { max-width: 400px; margin: auto; }
    </style>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
    <title>로그인 폼</title>
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
        <!-- 로그인 제목 -->
        <div class="border p-2 bg-dark text-white fw-bold mb-3">로그인</div>

        <!-- 로그인 폼 -->
        <form method="post" action="login">
            <div class="mb-3">
                <input type="text" class="form-control" placeholder="아이디" name="id" value="qwer12341">
            </div>
            <div class="mb-3">
                <input type="password" class="form-control" placeholder="비밀번호" name="password" value="zxcv1234!@">
            </div>
            <button type="submit" class="btn btn-dark w-100 mb-3">아이디로 로그인</button>

            <!-- 아이디 저장 / 아이디 찾기 / 비밀번호 재설정 -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="rememberMe">
                    <label class="form-check-label" for="rememberMe">아이디 저장</label>
                </div>
                <div>
                    <a href="/find-id" class="text-decoration-none">아이디 찾기</a> |
                    <a href="/find-password" class="text-decoration-none">비밀번호 재설정</a>
                </div>
            </div>
        </form>

        <!-- 간편 로그인 -->
        <div class="mb-3">간편로그인</div>
        <hr class="mb-4">

        <a href="/oauth2/authorization/kakao" class="btn btn-social btn-kakao">
            <img src="/resources/img/login_kakaotalk_wide.jpg" alt="카카오 로그인 아이콘">
        </a>
        <a href="/oauth2/authorization/naver" class="btn btn-social btn-naver">
            <img src="/resources/img/login_naver_wide.png" alt="네이버 로그인 아이콘">
        </a>
        <a href="/oauth2/authorization/google" class="btn btn-social btn-apple">
            <img src="/resources/img/login_apple_wide.jpg" alt="구글 로그인 아이콘">
        </a>

        <!-- 회원가입 -->
        <div class="mt-4">
            <a href="/join" class="color-black text-decoration-none fw-bold">회원가입</a>
        </div>
    </div>
</main>

<!-- 푸터부 -->
<footer>
    <%@include file="/WEB-INF/views/common/footer.jsp" %>
</footer>

    </body>
</html>
