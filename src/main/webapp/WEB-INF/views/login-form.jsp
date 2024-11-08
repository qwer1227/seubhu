<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
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
<main class="container my-3">
    <div class="row mb-3">
        <div class="col">
            <div class="row mb-3">
                <div class="col">
                    <div class="border p-2 bg-dark text-white fw-bold">로그인</div>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col">
                    <div class="border p-2 bg-light">
                        <form id="form-login" method="post" action="login" novalidate="novalidate">
                            <!-- 이메일 입력 -->
                            <div class="mb-3">
                                <label class="form-label">이메일</label>
                                <div class="d-flex">
                                    <input type="text" class="form-control w-75" id="user-email" name="email" onchange="validateEmail()"/>
                                    <select class="form-select w-25" id="email-domain" onchange="rollbackEmailCheck()">
                                        <option value="naver.com">naver.com</option>
                                        <option value="gmail.com">gmail.com</option>
                                        <option value="daum.net">daum.net</option>
                                        <option value="etc">기타</option>
                                    </select>
                                </div>
                                <form:errors path="email" cssClass="text-danger fst-italic"/>
                            </div>

                            <!-- 비밀번호 입력 -->
                            <div class="mb-3">
                                <label class="form-label">비밀번호</label>
                                <input type="password" class="form-control" id="user-password" name="pwd" />
                                <form:errors path="password" cssClass="text-danger fst-italic"/>
                            </div>

                            <!-- 로그인 버튼 -->
                            <div class="mb-3 text-end">
                                <a class="btn btn-secondary" href="/">취소</a>
                                <button type="submit" class="btn btn-primary">로그인</button>
                            </div>

                            <!-- 소셜 로그인 버튼 -->
                            <div class="mb-3 text-center">
                                <a href="/auth/google" class="btn btn-danger">구글로 로그인</a>
                                <a href="/auth/kakao" class="btn btn-warning">카카오로 로그인</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- 푸터부 -->
<footer>
    <%@include file="/WEB-INF/views/common/footer.jsp" %>
</footer>

<script type="text/javascript">
    // 이메일 유효성 검사 함수 (간단한 예시)
    function validateEmail() {
        let email = document.querySelector("#user-email").value;
        let domain = document.querySelector("#email-domain").value;
        let fullEmail = email + "@" + domain;

        if (email === "" || domain === "") {
            alert("이메일을 입력하고 도메인을 선택해주세요.");
            return;
        }

        // 서버에서 이메일 중복 검사 또는 다른 검증 로직 추가 가능
        console.log("검증된 이메일: " + fullEmail);
    }

    function rollbackEmailCheck() {
        let emailField = document.querySelector("#user-email");
        emailField.value = ""; // 이메일 입력값 초기화
    }
</script>

</body>
</html>
