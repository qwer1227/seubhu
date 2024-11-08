<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/common.jsp" %>
    <title>회원 가입 폼</title>
</head>
<body>
<!-- 헤더부 -->
<header>
    <c:set var="menu" value="home"/>
    <%@ include file="/WEB-INF/views/common/nav.jsp" %>
</header>

<!-- 메인 컨텐츠부 -->
<main class="container my-3">
    <div class="row mb-3">
        <div class="col">
            <div class="row mb-3">
                <div class="col">
                    <div class="border p-2 bg-dark text-white fw-bold">회원가입</div>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col">
                    <div class="border p-2 bg-light">
                        <!-- Spring form:form 사용 -->
<form:form id="form-register" method="POST" action="/register" modelAttribute="user" novalidate="novalidate">
    <!-- 이름 입력 -->
    <div class="mb-3">
        <label class="form-label">이름</label>
        <form:input class="form-control" id="user-username" path="username"/>
        <form:errors path="username" cssClass="text-danger fst-italic"/>
    </div>

    <!-- 이메일 입력 -->
    <div class="mb-3">
        <label class="form-label">이메일</label>
        <div class="d-flex justify-content-between">
            <form:input class="form-control w-75" id="user-email" path="email" onchange="rollbackEmailCheck()"/>
            <select class="form-select w-25" id="email-domain" onchange="rollbackEmailCheck()">
                <option value="naver.com">naver.com</option>
                <option value="gmail.com">gmail.com</option>
                <option value="daum.net">daum.net</option>
                <option value="etc">기타</option>
            </select>
            <button onclick="checkEmail()" type="button" class="btn btn-outline-primary btn-sm">중복체크</button>
        </div>
        <form:errors path="email" cssClass="text-danger fst-italic"/>
    </div>

    <!-- 닉네임 입력 -->
    <div class="mb-3">
        <label class="form-label">닉네임</label>
        <form:input class="form-control" id="user-nick-name" path="nickname" onchange="checkNickname()"/>
        <form:errors path="nickname" cssClass="text-danger fst-italic"/>
        <span id="nickname-error" class="text-danger fst-italic"></span>
    </div>

    <!-- 비밀번호 입력 -->
    <div class="mb-3">
        <label class="form-label">비밀번호</label>
        <form:password class="form-control" id="user-password" path="password"/>
        <form:errors path="password" cssClass="text-danger fst-italic"/>
    </div>

    <!-- 비밀번호 확인 -->
    <div class="mb-3">
        <label class="form-label">비밀번호 확인</label>
        <form:password class="form-control" id="user-password-confirm" path="passwordConfirm"/>
        <form:errors path="passwordConfirm" cssClass="text-danger fst-italic"/>
    </div>

    <!-- 전화번호 입력 -->
    <div class="mb-3">
        <label class="form-label">전화번호</label>
        <div class="d-flex">
            <select class="form-select w-25" id="phone-area" path="phoneArea">
                <option value="010">010</option>
                <option value="011">011</option>
                <option value="016">016</option>
            </select>
            <form:input class="form-control w-50" id="user-phone" path="tel"/>
            <button type="button" class="btn btn-outline-primary btn-sm" onclick="checkPhoneNumber()">인증하기</button>
        </div>
        <form:errors path="tel" cssClass="text-danger fst-italic"/>
    </div>

    <!-- 회원가입 버튼 -->
    <div class="mb-3 text-end">
        <a class="btn btn-secondary" href="/home">취소</a>
        <button type="button" class="btn btn-primary" onclick="formSubmit()">회원가입</button>
    </div>

    <!-- 소셜 로그인 버튼 -->
    <div class="mb-3 text-center">
        <a href="/auth/google" class="btn btn-danger">구글로 로그인</a>
        <a href="/auth/kakao" class="btn btn-warning">카카오로 로그인</a>
    </div>
</form:form>

                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- 푸터부 -->
<footer>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</footer>

<script type="text/javascript">
    let isEmailChecked = false;
    let isEmailPassed = false;
    let isNicknameChecked = false;
    let isNicknameAvailable = true;

    // 이메일 중복 체크
    function rollbackEmailCheck() {
        isEmailChecked = false;
        isEmailPassed = false;
    }

    async function checkEmail() {
        // 이메일과 도메인 결합
        let email = document.querySelector("#user-email").value;
        let domain = document.querySelector("#email-domain").value;
        let fullEmail = email + "@" + domain;

        if (email === "" || domain === "") {
            alert("이메일을 입력하고 도메인을 선택해주세요.");
            return;
        }

        isEmailChecked = true;
        let response = await fetch("/ajax/check-email?email=" + fullEmail);
        if (response.ok) {
            let result = await response.json();
            if (result.data === 'none') {
                isEmailPassed = true;
                alert("사용가능한 이메일입니다.");
            } else if (result.data === "exists") {
                isEmailPassed = false;
                alert("이미 사용중인 이메일입니다.");
            }
        }
    }

    // 닉네임 중복 검사
    function checkNickname() {
        let nickname = document.querySelector("#user-nick-name").value;

        if (nickname === "") {
            document.querySelector("#nickname-error").textContent = "닉네임을 입력해주세요.";
            isNicknameAvailable = false;
            return;
        }

        fetch(`/ajax/check-nickname?nickname=${nickname}`)
            .then(response => response.json())
            .then(data => {
                if (data.exists) {
                    document.querySelector("#nickname-error").textContent = "이미 사용 중인 닉네임입니다.";
                    isNicknameAvailable = false;
                } else {
                    document.querySelector("#nickname-error").textContent = "";
                    isNicknameAvailable = true;
                }
            });
    }

    function formSubmit() {
        if (!isEmailChecked || !isEmailPassed) {
            alert("이메일 중복체크를 수행하지 않았거나, 이미 사용 중인 이메일입니다.");
            return;
        }

        if (!isNicknameAvailable) {
            alert("닉네임을 확인해주세요.");
            return;
        }

        document.querySelector("#form-register").submit();
    }

    // 전화번호 인증 버튼 (간단히 알림만 띄우는 예시)
    function checkPhoneNumber() {
        alert("전화번호 인증이 완료되었습니다.");
    }
</script>

</body>
</html>
