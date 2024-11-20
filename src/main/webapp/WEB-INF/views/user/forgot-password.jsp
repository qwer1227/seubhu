<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
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
    <div class="login-form text-center mt-5">
        <!-- 비밀번호 찾기 제목 -->
        <div class="border p-2 bg-dark text-white fw-bold mb-3">비밀번호 찾기</div>

        <!-- 비밀번호 찾기 폼 -->
        <form method="post" action="sendPwd">
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
</main>

<%@include file="/WEB-INF/views/common/footer.jsp" %>

<script>
    const emailCheckBtn = document.getElementById('emailCheckBtn');
    const authNumBtn = document.getElementById('authNumBtn');
    const findPwdBtn = document.getElementById('findPwdBtn');

    //아이디 이메일이 있는지 확인
    emailCheckBtn.addEventListener("click", function () {
        const id = document.getElementById('id').value;
        const email = document.getElementById('email').value;

        $.ajax({
            url: "/checkIdEmail",
            data: {"id": id, "email": email},
            success: (data) => {
                if (data === 'true') {

                    //아이디와 이메일이 일치할 경우 인증번호 발송
                    $.ajax({
                        url: "/emailCheck",
                        data: {"email": email},
                        success: (data) => {
                            console.log(data);
                            emailCheckWarn.innerText = '인증번호가 발송되었습니다.';
                            emailCheckWarn.style.color = "black";
                            document.getElementById('authNum').value = data;
                        },
                        error: (error) => {
                            emailCheckWarn.innerText = '인증번호 발송에 실패하였습니다.';
                            emailCheckWarn.style.color = "red";
                        }
                    })

                } else {
                    emailCheckWarn.innerText = "아이디와 이메일 주소를 다시 확인해주세요.";
                    emailCheckWarn.style.color = "red";
                }
            },
            error: (error) => {
                console.log(error);
            }
        })

    });

    //유효성 검사 변수
    let check_email = false;

    //인증번호 일치여부 확인
    authNumBtn.addEventListener("click", function () {
        const auth = document.getElementById('auth').value; //사용자가 입력한 인증번호
        const authNum = document.getElementById('authNum').value; //실제 발송된 인증번호

        if (authNum == "") {
            authCheckWarn.innerText = "인증을 진행해주세요.";
            authCheckWarn.style.color = "red";
            check_email = false;
        } else {
            if (auth == "") {
                authCheckWarn.innerText = "인증번호를 입력해주세요.";
                authCheckWarn.style.color = "red";
                check_email = false;
            } else {
                if (auth == authNum) {
                    // 인증 번호가 맞을때 실행할거
                    authCheckWarn.innerText = "인증번호가 일치합니다.";
                    authCheckWarn.style.color = "black";
                    check_email = true;
                } else {
                    // 인증 번호가 맞지 않을때 실행할거
                    authCheckWarn.innerText = "인증번호가 일치하지 않습니다.";
                    authCheckWarn.style.color = "red";
                    check_email = false;
                }
            }
        }
    });

    //유효성 검사
    findPwdBtn.addEventListener("click", function () {
        const id = document.getElementById('id').value;
        const formId = document.getElementById('formId');

        if (!check_email) {
            alert("이메일 인증을 완료해주세요!");
        } else {
            alert("고객님 이메일로 임시 비밀번호를 전송하였습니다.");
            formId.submit();
        }
    });

</script>

</body>
</html>