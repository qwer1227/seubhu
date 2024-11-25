<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
    <title>비밀번호 찾기 폼</title>
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
            <div class="border p-2 bg-dark text-white fw-bold mb-3">비밀번호 찾기</div>

        <!-- 비밀번호 찾기 폼 -->
        <form method="post" action="/find-password">
            <div class="mb-3">
                가입 시 등록하신 이름, 아이디, 이메일을 입력하시면<br>
                임시 비밀번호가 이메일로 발송됩니다.
            </div>
            <div class="mb-3">
                <input type="text" class="form-control" placeholder="아이디" id="id" name="id">
            </div>
            <div class="mb-3 input-group">
                <input type="text" class="form-control" placeholder="이메일" id="email" name="email">
                <button type="button" id="emailCheckBtn" class="btn btn-outline-dark btn-sm">전송</button>
            </div>
            <div class="mt-1 form-text" id="emailCheckWarn" style="font-weight: bolder;"></div>
            <div class="mb-3 input-group">
                <input type="text" class="form-control" placeholder="인증번호" id="auth" name="auth">
                <button type="button" id="authNumBtn" class="btn btn-outline-dark btn-sm">확인</button>
            </div>
            <div class="mt-1 form-text" id="authCheckWarn" style="font-weight: bolder;"></div>
            <div>
                <button type="submit" class="btn btn-dark w-100 mb-3">확인</button>
            </div>
        </form>
    </div>
    </div>
</main>

<%@include file="/WEB-INF/views/common/footer.jsp" %>

<script>
    document.getElementById('emailCheckBtn').addEventListener('click', function () {
        const email = document.getElementById('email').value;

        // 인증번호 요청
        fetch('/auth/send-email', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: `email=${email}`
        })
            .then(response => response.text())
            .then(authCode => {
                alert('인증번호가 이메일로 발송되었습니다.');
                document.getElementById('authCode').value = authCode; // 서버에서 받은 인증번호 저장
            })
            .catch(error => console.error('Error:', error));
    });

    document.getElementById('authNumBtn').addEventListener('click', function () {
        const inputCode = document.getElementById('auth').value;
        const sentCode = document.getElementById('authCode').value;

        // 인증번호 검증
        fetch('/auth/verify-email', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: `inputCode=${inputCode}&sentCode=${sentCode}`
        })
            .then(response => response.json())
            .then(isValid => {
                if (isValid) {
                    alert('인증번호가 확인되었습니다.');
                } else {
                    alert('인증번호가 일치하지 않습니다.');
                }
            })
            .catch(error => console.error('Error:', error));
    });
</script>

</body>
</html>