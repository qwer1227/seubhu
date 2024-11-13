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
                <input type="text" class="form-control" placeholder="아이디" name="id">
            </div>
            <div class="mb-3">
                <input type="password" class="form-control" placeholder="비밀번호" name="password">
            </div>
            <button type="submit" class="btn btn-dark w-100 mb-3">아이디로 로그인</button>

            <!-- 아이디 저장 / 아이디 찾기 / 비밀번호 재설정 -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" value="" id="rememberMe">
                    <label class="form-check-label" for="rememberMe">아이디 저장</label>
                </div>
                <div>
                    <a href="/forgot-username" class="text-decoration-none">아이디 찾기</a> |
                    <a href="/forgot-password" class="text-decoration-none">비밀번호 재설정</a>
                </div>
            </div>
        </form>

        <!-- 간편 로그인 -->
        <div class="mb-3">간편로그인</div>
        <hr class="mb-4">

        <a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=c6212e324efa9f98ed4eae72535d96ec&redirect_uri=http://localhost:80/auth/kakao/callback" class="btn btn-social btn-kakao">
            <img src="/resources/img/login_kakaotalk_wide.jpg" alt="카카오 로그인 아이콘">
        </a>
        <a href="/auth/naver" class="btn btn-social btn-naver">
            <img src="/resources/img/login_naver_wide.png" alt="네이버 로그인 아이콘">
        </a>
        <a href="/auth/apple" class="btn btn-social btn-apple">
            <img src="/resources/img/login_apple_wide.jpg" alt="Apple 로그인 아이콘">
        </a>

        <!-- 회원가입 -->
        <div class="mt-4">
            <a href="user/join-form" class="color-black text-decoration-none fw-bold">회원가입</a>
        </div>
    </div>
</main>

<!-- 푸터부 -->
<footer>
    <%@include file="/WEB-INF/views/common/footer.jsp" %>
</footer>

<script type="text/javascript">

    // 로그인 시 아이디 저장
    const rememberMe = document.querySelector("#rememberMe");

    if (rememberMe.checked) {
        // 아이디 저장
        localStorage.setItem("savedUsername", username);
    } else {
        // 아이디 저장하지 않음
        localStorage.removeItem("savedUsername");
    }


    // 아이디 유효성 검사 함수 (간단한 예시)
    function validateUsername() {
        let username = document.querySelector("#username").value;
        let domain = document.querySelector("#email-domain").value;
        let fullUsername = username + "@" + domain;

        if (username === "" || domain === "") {
            alert("아이디를 입력하고 도메인을 선택해주세요.");
            return;
        }

        // 서버에서 아이디 중복 검사 또는 다른 검증 로직 추가 가능
        console.log("검증된 아이디: " + fullUsername);
    }

    function rollbackUsernameCheck() {
        let usernameField = document.querySelector("#username");
        usernameField.value = ""; // 아이디 입력값 초기화
    }
</script>


    </body>
</html>
