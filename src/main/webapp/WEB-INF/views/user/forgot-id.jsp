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
                    가입 시 등록하신 이메일을 입력해 주세요.
                </div>
                <div class="mb-3">
                    <input type="email" class="form-control" placeholder="이메일" id="email">
                </div>
                <button type="button" id="submitBtn" class="btn btn-dark w-100 mb-3">확인</button>
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
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.getElementById("forgotIdForm");
        const emailInput = document.getElementById("email");
        const resultMessage = document.getElementById("resultMessage");

        document.getElementById("submitBtn").addEventListener("click", function () {
            const email = emailInput.value.trim();

            // 이메일 유효성 검사
            if (!email) {
                showMessage("이메일을 입력해주세요.", "alert-danger");
                return;
            }

            // XMLHttpRequest를 사용해 AJAX 요청 전송
            const xhr = new XMLHttpRequest();
            xhr.open("POST", "/forgot-id", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            xhr.onreadystatechange = function () {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        showMessage(xhr.responseText, "alert-success");
                    } else {
                        showMessage(xhr.responseText, "alert-danger");
                    }
                }
            };

            xhr.send("email=" + encodeURIComponent(email));
        });

        function showMessage(message, alertClass) {
            resultMessage.className = `alert ${alertClass}`;
            resultMessage.textContent = message;
            resultMessage.classList.remove("d-none");
        }
    });
</script>

    </body>
</html>
