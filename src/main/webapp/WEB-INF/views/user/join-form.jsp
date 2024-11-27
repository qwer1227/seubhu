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
                <div class="has-validation">
                    <form:input type="text" class="form-control" placeholder="아이디*" path="id" required="required"
                                id="user-id" onblur="checkId()"/>
                    <div class="invalid-feedback">아이디는 영소문자와 숫자만 포함하고 4~16자 사이여야 합니다.</div>
                    <div class="valid-feedback">사용 가능한 아이디입니다.</div>
                </div>
                <form:errors path="id" cssClass="text-danger fst-italic"/>
            </div>

            <!-- 비밀번호 -->
            <div class="form-group mb-3">
                <form:password class="form-control" placeholder="비밀번호*" path="password" required="required"
                               id="user-password" onblur="checkPassword()"/>
                <div class="invalid-feedback">비밀번호는 10~16자, 문자, 숫자, 특수문자 조합이어야 합니다."</div>
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
                <div class="has-validation">
                    <form:input class="form-control" placeholder="닉네임" path="nickname" onblur="checkNickname()"
                                id="user-nickname" required="required"/>
                    <div class="invalid-feedback">닉네임 형식이 올바르지 않습니다.</div>
                    <div class="valid-feedback">사용 가능한 닉네임입니다!</div>
                </div>
                <form:errors path="nickname" id="nickname-error" cssClass="text-danger fst-italic"/>
            </div>

            <!-- 이름 -->
            <div class="form-group mb-3">
                <form:input class="form-control" placeholder="이름" path="name"/>
            </div>


            <!-- 휴대전화 -->
            <div class="form-group mb-3">
                <div class="input-group">
                    <!-- 전화번호 입력 필드 -->
                    <input type="text" class="form-control" id="tel" name="tel" maxlength="11" placeholder="전화번호"
                           required="required"/>
                    <!-- 본인인증 버튼 -->
                    <button id="smsCheck" type="button" class="btn btn-outline-dark btn-sm" onclick="smsCheck()">
                        본인인증
                    </button>
                </div>
                <ul class="txtInfo gBlank5 mt-1" id="sendVerifyCode" style="display: none;">
                    <li>인증번호가 발송되었습니다.</li>
                    <li>인증번호를 받지 못하셨다면 휴대폰 번호를 확인해 주세요.</li>
                </ul>
            </div>

            <!-- 이메일 -->
            <div class="form-group mb-3">
                <div class="has-validation">
                    <form:input type="text" class="form-control" id="user-email" placeholder="이메일(example@domain.com)*"
                                path="email" onblur="checkEmail()"
                                required="required"/>
                    <div class="invalid-feedback">이메일 형식이 올바르지 않습니다.</div>
                    <div class="valid-feedback">사용 가능한 이메일입니다!</div>
                </div>
                <form:errors path="email" cssClass="text-danger fst-italic"/>
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
    let isIdValid = false;
    let isPasswordValid = false;
    let isPasswordConfirmed = false;
    let isTelVerified = false;
    let isEmailValid = false;
    let isEmailChecked = false;
    let isNicknameValid = false;
    let isNicknameChecked = false;

    // 아이디 유효성 검사 + 중복 검사 함수
    function checkId() {
        let idInput = document.querySelector("#user-id");
        let id = idInput.value;

        // 아이디 유효성 검사: 공백, 특수문자, 길이 체크
        if (!/^[a-z0-9]{4,16}$/.test(id)) { // 아이디는 소문자 + 숫자, 4~16자
            idInput.classList.add("is-invalid");
            idInput.classList.remove("is-valid");
            isIdValid = false;
            return;
        } else {
            idInput.classList.add("is-valid");
            idInput.classList.remove("is-invalid");
            isIdValid = true;
        }

        // 유효성 검사 통과 후 중복 확인 요청
        fetch(`/user/join/check-id?id=${id}`)
            .then(response => response.json())
            .then(data => {
                if (data.exists) {
                    // 중복된 아이디인 경우
                    idInput.classList.add("is-invalid");
                    idInput.classList.remove("is-valid");
                    isIdValid = false;
                } else {
                    // 사용 가능한 아이디인 경우
                    idInput.classList.add("is-valid");
                    idInput.classList.remove("is-invalid");
                    isIdValid = true;
                }
            })
            .catch(error => {
                console.error("아이디 중복 확인 실패", error);
            });
    }

    // 비밀번호 유효성 검사
    function checkPassword() {
        let passwordInput = document.querySelector("#user-password");
        let password = passwordInput.value;

        // 비밀번호 길이와 복잡성 체크
        if (!/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[^a-zA-Z0-9]).{10,16}$/.test(password)) {
            // 비밀번호는 10~16자, 문자, 숫자, 특수문자 조합
            passwordInput.classList.add("is-invalid");
            passwordInput.classList.remove("is-valid");
            isPasswordValid = false;
        } else {
            passwordInput.classList.add("is-valid");
            passwordInput.classList.remove("is-invalid");
            isPasswordValid = true;
        }
    }

    // 비밀번호 확인 유효성 검사
    function checkPasswordConfirm() {
        let password = document.querySelector("#user-password").value;
        let passwordConfirmInput = document.querySelector("#password-confirm");
        let passwordConfirm = passwordConfirmInput.value;

        if (password !== passwordConfirm) {
            passwordConfirmInput.classList.add("is-invalid");
            passwordConfirmInput.classList.remove("is-valid");
            isPasswordConfirmed = false;
        } else {
            passwordConfirmInput.classList.add("is-valid");
            passwordConfirmInput.classList.remove("is-invalid");
            isPasswordConfirmed = true;
        }
    }

    // 이메일 유효성 검사
    function isEmailValidFormat(email) {
        const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        return emailPattern.test(email);
    }

    function checkEmail() {
        let emailInput = document.querySelector("#user-email");
        let email = emailInput.value;

        // 이메일 형식 검사
        if (!isEmailValidFormat(email)) {
            emailInput.classList.add("is-invalid");
            emailInput.classList.remove("is-valid");
            isEmailValid = false;
            return;
        }

        // 유효성 검사 통과 후 중복 확인 요청
        fetch(`/user/join/check-email?email=${email}`)
            .then(response => response.json())
            .then(data => {
                if (data.exists) {
                    // 중복된 이메일인 경우
                    emailInput.classList.add("is-invalid");
                    emailInput.classList.remove("is-valid");
                    isEmailValid = false;
                } else {
                    // 사용 가능한 이메일인 경우
                    emailInput.classList.add("is-valid");
                    emailInput.classList.remove("is-invalid");
                    isEmailValid = true;
                }
            })
            .catch(error => {
                console.error("이메일 중복 확인 실패", error);
            });
    }

    // 닉네임 유효성 검사
    function checkNickname() {
        let nicknameInput = document.querySelector("#user-nickname");
        let nickname = nicknameInput.value;

        if (!nickname) {
            nicknameInput.classList.add("is-invalid");
            nicknameInput.classList.remove("is-valid");
            isNicknameValid = false;
            return;
        }

        // 유효성 검사 통과 후 중복 확인 요청
        fetch(`/user/join/check-nickname?nickname=${nickname}`)
            .then(response => response.json())
            .then(data => {
                if (data.exists) {
                    // 중복된 닉네임인 경우
                    nicknameInput.classList.add("is-invalid");
                    nicknameInput.classList.remove("is-valid");
                    isNicknameValid = false;
                } else {
                    // 사용 가능한 닉네임인 경우
                    nicknameInput.classList.add("is-valid");
                    nicknameInput.classList.remove("is-invalid");
                    isNicknameValid = true;
                }
            })
            .catch(error => {
                console.error("닉네임 중복 확인 실패", error);
            });
    }

    // 폼 제출 시 유효성 검사
    async function formSubmit() {
// 모든 유효성 검사 호출
        checkId();
        checkPassword();
        checkPasswordConfirm();
        checkEmail();
        checkNickname();

// 이메일 중복체크 미실행 또는 잘못된 이메일 상태 처리
        let email = document.querySelector("#user-email").value;
        if (!isEmailValid(email) || !isEmailChecked) {
            document.querySelector("#user-email").classList.add("is-invalid");
            document.querySelector("#user-email").classList.remove("is-valid");
            return;
        }

// 닉네임 중복체크 미실행 또는 사용 불가 체크
        let nickname = document.querySelector("#user-nickname").value;
        if (!isNicknameChecked || !isNicknameValid) {
            document.querySelector("#user-nickname").classList.add("is-invalid");
            document.querySelector("#user-nickname").classList.remove("is-valid");
            return;
        }

// 비밀번호 확인 검사
        let password = document.querySelector("#user-password").value;
        let passwordConfirm = document.querySelector("#password-confirm").value;
        if (password !== passwordConfirm) {
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
