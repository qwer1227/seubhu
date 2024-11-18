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
                    <a href="/forgot-id" class="text-decoration-none">아이디 찾기</a> |
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
        <a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=kNZVK0mh3eMsIM8BsYrl&state=test&redirect_uri=http://localhost:80/auth/naver/callback" class="btn btn-social btn-naver">
            <img src="/resources/img/login_naver_wide.png" alt="네이버 로그인 아이콘">
        </a>
        <a href="https://accounts.google.com/o/oauth2/v2/auth?client_id=80851257702-0csbqcd37spa4qc1rqn735n44pt3s2f1.apps.googleusercontent.com&redirect_uri=http://localhost:80/auth/google/callback&response_type=code&scope=email profile" class="btn btn-social btn-apple">
            <img src="/resources/img/login_apple_wide.jpg" alt="Apple 로그인 아이콘">
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

<script type="text/javascript">

    // 로그인 시 아이디 저장
    const rememberMe = document.querySelector("#rememberMe");

    if (rememberMe.checked) {
        // 아이디 저장
        localStorage.setItem("savedId", id);
    } else {
        // 아이디 저장하지 않음
        localStorage.removeItem("savedId");
    }


    // 아이디 유효성 검사 함수 (간단한 예시)
    function validateId() {
        let id = document.querySelector("#id").value;

        if (id === "") {
            alert("아이디를 입력해주세요.");
            return;
        }
        // 서버에서 아이디 중복 검사 또는 다른 검증 로직 추가 가능
        console.log("검증된 아이디: " + fullId);
    }

    function rollbackIdCheck() {
        let idField = document.querySelector("#id");
        idField.value = ""; // 아이디 입력값 초기화
    }
</script>

    </body>
</html>
