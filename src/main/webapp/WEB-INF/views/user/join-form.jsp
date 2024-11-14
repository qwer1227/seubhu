<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <style>
        a:link {
            color: black;
            text-decoration: none;
        }

        a:active {
            color: black;
            text-decoration: none;
        }

        .login-form {
            max-width: 400px;
            margin: auto;
        }
    </style>
    <%@ include file="/WEB-INF/views/common/common.jsp" %>
    <title>회원가입 폼</title>
</head>
<body>
<!-- 헤더부 -->
<header>
    <c:set var="menu" value="home"/>
    <%@ include file="/WEB-INF/views/common/nav.jsp" %>
</header>

<!-- http://localhost:80/user/login -->

<!-- 메인 컨텐츠부 -->
<main class="container">
    <div class="login-form text-center mt-5 mb-3">
        <!-- 회원가입 제목 -->
        <div class="border p-2 bg-dark text-white fw-bold mb-3">회원가입</div>

        <!-- 회원가입 폼 -->
        <form:form id="joinForm" method="POST" action="/join" modelAttribute="joinForm"
                   novalidate="novalidate">
            <!-- 아이디 -->
            <div class="form-group mb-3">
                <div class="input-group has-validation">
                    <form:input type="text" class="form-control" placeholder="아이디*" path="username" required="required"
                                id="user-username" onblur="checkUsername()"/>
                    <button type="button" class="btn btn-outline-primary btn-sm" onclick="checkUsername()">중복확인
                    </button>
                    <div class="invalid-feedback">아이디는 영문 소문자와 숫자만 사용할 수 있으며 4~16자로 입력해 주세요.</div>
                    <div class="valid-feedback">사용 가능한 아이디입니다!</div>
                </div>
                <form:errors path="username" cssClass="text-danger fst-italic"/>
            </div>

            <!-- 비밀번호 -->
            <div class="form-group mb-3">
                <form:password class="form-control" placeholder="비밀번호*" path="password" required="required"
                               id="user-password" onblur="checkPassword()"/>
                <div class="invalid-feedback">비밀번호는 10~16자로 영문, 숫자, 특수문자 중 2가지 이상을 포함해 주세요.</div>
                <div class="valid-feedback">비밀번호가 유효합니다.</div>
                <form:errors path="password" cssClass="text-danger fst-italic"/>
            </div>

            <!-- 비밀번호 확인 -->
            <div class="form-group mb-3">
                <form:password class="form-control" placeholder="비밀번호 확인*" path="passwordConfirm" required="required"
                               id="password-confirm" onblur="checkPasswordConfirm()"/>
                <div class="invalid-feedback">비밀번호가 일치하지 않습니다.</div>
                <div class="valid-feedback">비밀번호가 일치합니다!</div>
                <form:errors path="passwordConfirm" cssClass="text-danger fst-italic"/>
            </div>

            <!-- 닉네임 -->
            <div class="form-group mb-3">
                <div class="input-group has-validation">
                    <form:input class="form-control" placeholder="닉네임" path="nickname" onblur="checkNickname()"
                                id="user-nickname" required="required"/>
                    <button type="button" class="btn btn-outline-primary btn-sm" onclick="checkNickname()">중복확인
                    </button>
                    <div class="invalid-feedback">닉네임 형식이 올바르지 않거나 이미 사용 중입니다.</div>
                    <div class="valid-feedback">사용 가능한 닉네임입니다!</div>
                </div>
                <form:errors path="nickname" id="nickname-error" cssClass="text-danger fst-italic"/>
            </div>

            <!-- 이름 -->
            <div class="form-group">
                <form:input class="form-control" placeholder="이름" path="name"/>
            </div>


            <!-- 휴대전화 -->
            <div class="form-group mb-3">
                <label for="mobile1" class="form-label"></label>
                <div class="input-group has-validation">
                    <select id="mobile1" name="mobile[]" class="form-select">
                        <option value="010">010</option>
                        <option value="011">011</option>
                        <option value="016">016</option>
                        <option value="017">017</option>
                        <option value="018">018</option>
                        <option value="019">019</option>
                    </select>
                    <input id="mobile2" name="mobile[]" maxlength="4" placeholder="" type="text" class="form-control"
                           required>
                    <input id="mobile3" name="mobile[]" maxlength="4" placeholder="" type="text" class="form-control"
                           required>
                    <button type="button" id="btn_action_verify_mobile" class="btn btn-outline-primary btn-sm"
                            onclick="memberVerifyMobile.joinSendVerificationNumber(); return false;">인증번호 받기
                    </button>
                    <div class="invalid-feedback">휴대전화 번호를 올바르게 입력해주세요.</div>
                    <div class="valid-feedback">유효한 휴대전화 번호입니다!</div>
                </div>
                <ul class="txtInfo gBlank5 displaynone mt-1" id="result_send_verify_mobile_success"
                    style="display: none;">
                    <li>인증번호가 발송되었습니다.</li>
                    <li>인증번호를 받지 못하셨다면 휴대폰 번호를 확인해 주세요.</li>
                </ul>
            </div>


<!-- 이메일 -->
<div class="form-group mb-3">
    <div class="input-group has-validation">
        <form:input type="text" class="form-control" id="user-email" placeholder="이메일(example@domain.com)*" path="email"
                    required="required" />
        <button onclick="checkEmail()" type="button" class="btn btn-outline-primary btn-sm">중복확인</button>
        <div class="invalid-feedback">이메일 형식이 올바르지 않거나 이미 사용 중입니다.</div>
        <div class="valid-feedback">사용 가능한 이메일입니다!</div>
    </div>
    <form:errors path="email" cssClass="text-danger fst-italic"/>
</div>



            <!-- 추천인 아이디 -->
            <div class="form-group mb-3">
                <form:input class="form-control" placeholder="추천인 아이디" path="referrer"/>
            </div>

            <!-- 이용약관 동의 -->
            <div class="form-group text-start mb-3">
                <form:checkbox path="terms" required="required"/>
                <label for="terms"><a href="/terms" target="_blank">이용약관*</a>에 동의합니다.</label>
                <form:errors path="terms" cssClass="text-danger fst-italic"/>
            </div>

            <!-- 개인정보 수집 및 이용 동의 -->
            <div class="form-group text-start mb-3">
                <form:checkbox path="privacy" required="required"/>
                <label for="privacy"><a href="/privacy" target="_blank">개인정보 수집 및 이용*</a>에 동의합니다.</label>
                <form:errors path="privacy" cssClass="text-danger fst-italic"/>
            </div>

            <!-- 가입하기 버튼 -->
            <button type="submit" class="btn btn-dark w-100">가입하기</button>

        </form:form>
    </div>
</main>

<!-- 푸터부 -->
<footer>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</footer>

<script type="text/javascript">
    // 상태 플래그
    let isUsernameChecked = false;
    let isUsernameAvailable = false;
    let isPasswordValid = false;
    let isPasswordConfirmed = false;
    let isEmailChecked = false;
    let isEmailPassed = false;
    let isNicknameChecked = false;
    let isNicknameAvailable = false;


    // 아이디 유효성 검사
    function checkUsername() {
        let usernameInput = document.querySelector("#user-username");
        let username = usernameInput.value;

        // 아이디 유효성 검사: 공백, 특수문자, 길이 체크
        if (/\s/.test(username) || /[^a-z0-9]/.test(username) || username.length < 4 || username.length > 16) {
            usernameInput.classList.add("is-invalid");
            usernameInput.classList.remove("is-valid");
            isUsernameAvailable = false;
            isUsernameChecked = false;
            return;
        }

        // 아이디 중복 검사 (서버와 통신)
        fetch(`/ajax/check-username?username=${username}`)
            .then(response => response.json())
            .then(data => {
                if (data.exists) {
                    alert("이미 사용 중인 아이디입니다.");
                    isUsernameAvailable = false;
                } else {
                    alert("사용 가능한 아이디입니다.");
                    isUsernameAvailable = true;
                }

                // 유효한 아이디일 경우 스타일 적용
                usernameInput.classList.add(isUsernameAvailable ? "is-valid" : "is-invalid");
                usernameInput.classList.remove(isUsernameAvailable ? "is-invalid" : "is-valid");
                isUsernameChecked = true;
            });
    }

    // 비밀번호 유효성 검사
    function checkPassword() {
        let password = document.querySelector("#user-password").value;

        // 비밀번호 길이 체크
        if (password.length < 10 || password.length > 16) {
            alert("비밀번호는 10~16자로 입력해 주세요.");
            isPasswordValid = false;
            return;
        }

        // 비밀번호 조합 체크 (영문, 숫자, 특수문자 중 2가지 이상)
        if (!/(?=.*[a-zA-Z])(?=.*[0-9])|(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])|(?=.*[0-9])(?=.*[^a-zA-Z0-9])/.test(password)) {
            alert("비밀번호는 영문/특수문자/숫자 중 2가지 이상으로 조합해 주세요.");
            isPasswordValid = false;
            return;
        }

        isPasswordValid = true;
    }

    // 비밀번호 확인 유효성 검사
    function checkPasswordConfirm() {
        let password = document.querySelector("#user-password").value;
        let passwordConfirm = document.querySelector("#password-confirm").value;

        if (password !== passwordConfirm) {
            alert("비밀번호가 일치하지 않습니다.");
            isPasswordConfirmed = false;
        } else {
            isPasswordConfirmed = true;
        }
    }

    // 이메일 유효성 검사 함수
    function isValidEmail(email) {
        const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        return emailPattern.test(email);
    }

    // 이메일 중복 체크 함수
    async function checkEmail() {
        const emailInput = document.querySelector("#user-email");
        const email = emailInput.value;

        // 이메일 형식 검사
        if (!isValidEmail(email)) {
            alert("이메일 형식이 올바르지 않습니다.");
            emailInput.classList.add("is-invalid");
            emailInput.classList.remove("is-valid");
            return;
        }
        // 이메일 형식이 올바를 경우
        emailInput.classList.remove("is-invalid");

        // 이메일 중복 체크 API 호출
        const response = await fetch(`/ajax/check-email?email=${email}`);
        if (response.ok) {
            const result = await response.json();

            if (result.data === 'none') {
                alert("사용 가능한 이메일입니다.");
                emailInput.classList.add("is-valid");
                emailInput.classList.remove("is-invalid");
                isEmailPassed = true;
            } else {
                alert("이미 사용중인 이메일입니다.");
                emailInput.classList.add("is-invalid");
                emailInput.classList.remove("is-valid");
                isEmailPassed = false;
            }
        }
    }



    // 닉네임 유효성 검사 및 중복 체크
    function checkNickname() {
        let nickname = document.querySelector("#user-nickname").value;

        // 닉네임이 빈 문자열일 경우
        if (nickname === "") {
            document.querySelector("#nickname-error").textContent = "닉네임을 입력해주세요.";
            document.querySelector("#user-nickname").classList.add("is-invalid");
            document.querySelector("#user-nickname").classList.remove("is-valid");
            isNicknameAvailable = false;
            return;
        } else {
            // 닉네임이 공백이 아니면 is-invalid 클래스 제거
            document.querySelector("#user-nickname").textContent = "";
            document.querySelector("#user-nickname").classList.remove("is-invalid");
        }

        // 닉네임 중복 체크 API 호출
        fetch(`/ajax/check-nickname?nickname=${nickname}`)
            .then(response => response.json())
            .then(data => {
                if (data.exists) {
                    document.querySelector("#nickname-error").textContent = "이미 사용 중인 닉네임입니다.";
                    document.querySelector("#user-nickname").classList.add("is-invalid");
                    document.querySelector("#user-nickname").classList.remove("is-valid");
                    isNicknameAvailable = false;
                } else {
                    document.querySelector("#user-nickname").textContent = "";
                    document.querySelector("#user-nickname").classList.add("is-valid");
                    document.querySelector("#user-nickname").classList.remove("is-invalid");
                    isNicknameAvailable = true;
                }

                isNicknameChecked = true;
            });
    }


    // 폼 제출 시 유효성 검사
    async function formSubmit() {
        // 모든 유효성 검사 호출
        checkUsername();
        checkPassword();
        checkPasswordConfirm();
        checkEmail();
        checkNickname();

        // 이메일 중복체크 미실행 또는 잘못된 이메일 상태 처리
        let email = document.querySelector("#user-email").value;
        if (!isValidEmail(email) || !isEmailChecked || !isEmailPassed) {
            alert("이메일 중복체크를 수행하지 않았거나, 이메일 형식이 잘못되었거나, 이미 사용 중인 이메일입니다.");
            document.querySelector("#user-email").classList.add("is-invalid");
            document.querySelector("#user-email").classList.remove("is-valid");
            return;
        }

        // 닉네임 중복체크 미실행 또는 사용 불가 체크
        let nickname = document.querySelector("#user-nickname").value;
        if (!isNicknameChecked || !isNicknameAvailable) {
            alert("닉네임 중복체크를 수행하지 않았거나, 이미 사용 중인 닉네임입니다.");
            document.querySelector("#user-nickname").classList.add("is-invalid");
            document.querySelector("#user-nickname").classList.remove("is-valid");
            return;
        }

        // 비밀번호 확인 검사
        let password = document.querySelector("#user-password").value;
        let passwordConfirm = document.querySelector("#password-confirm").value;
        if (password !== passwordConfirm) {
            alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
            document.querySelector("#user-password").classList.add("is-invalid");
            document.querySelector("#password-confirm").classList.add("is-invalid");
            return;
        }

        // 모든 유효성 검사를 통과한 경우 폼 제출
        document.querySelector("#joinForm").submit();
    }


    // DOMContentLoaded 이벤트 리스너 추가
    document.addEventListener("DOMContentLoaded", function () {
        // 초기화나 추가적인 설정이 필요한 경우 여기에 추가
    });

</script>


</body>
</html>
