<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>

    <style>
        /* 폼의 너비를 제한하고, 중앙 정렬 */
        .form-container {
            max-width: 600px; /* 최대 너비 설정 */
            margin: 0 auto; /* 중앙 정렬 */
        }
        .valid-feedback {
            color: green;
            font-size: 0.9em;
        }
        .invalid-feedback {
            color: red;
            font-size: 0.9em;
        }
    </style>

</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">
    <h2>내 정보 수정</h2>

    <div class="form-container">
        <form action="/mypage/edit" method="post" class="form-group">
            <!-- 비밀번호 -->
            <div class="mb-3">
                <label for="password" class="form-label">비밀번호</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="새 비밀번호" required>
                <div id="passwordFeedback"></div> <!-- 피드백 영역 -->
            </div>

            <!-- 재 입력 -->
            <div class="mb-3">
                <label for="confirmPassword" class="form-label">비밀번호 확인</label>
                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="새 비밀번호 확인" required>
                <div id="confirmPasswordFeedback"></div> <!-- 피드백 영역 -->
            </div>

            <!-- 닉네임 -->
            <div class="mb-3">
                <label for="nickname" class="form-label">닉네임</label>
                <div class="d-flex">
                    <input type="text" id="nickname" name="nickname" class="form-control me-2" value="${user.nickname}" required>
                    <!-- 중복 확인 버튼 -->
                    <button type="button" id="checkNickname" class="btn btn-outline-primary flex-shrink-0" style="min-width: 100px;">중복 확인</button>
                </div>
                <div id="nicknameFeedback"></div> <!-- 피드백 영역 -->
            </div>

            <!-- 전화번호 -->
            <div class="mb-3">
                <label for="phone" class="form-label">전화번호</label>
                <input type="text" id="phone" name="phone" class="form-control" value="${user.phone}" required>
                <div id="phoneFeedback"></div> <!-- 피드백 영역 -->
            </div>

            <!-- 이메일 -->
            <div class="mb-3">
                <label for="email" class="form-label">이메일</label>
                <input type="email" id="email" name="email" class="form-control" value="${user.email}" required>
                <div id="emailFeedback"></div> <!-- 피드백 영역 -->
            </div>

            <!-- 수정 버튼 -->
            <button type="submit" class="btn btn-primary">수정하기</button>
        </form>
    </div>
</div>

<%@include file="/WEB-INF/views/common/footer.jsp" %>

<script>
    // 유효성 검사 규칙
    const validators = {
        password: (value) => value.length >= 8,  // 비밀번호 길이 8자 이상
        confirmPassword: (value) => value === document.getElementById("password").value, // 비밀번호 확인 일치 여부
        nickname: (value) => /^[가-힣a-zA-Z0-9]{2,10}$/.test(value),  // 닉네임 2~10자 한글, 영문, 숫자만
        phone: (value) => /^01[0-9]{8,9}$/.test(value),  // 전화번호 형식 (010으로 시작하는 10~11자리)
        email: (value) => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value),  // 이메일 형식
    };

    // 유효성 검사 피드백 출력 함수
    function validateInput(input) {
        const value = input.value.trim();
        const id = input.id;
        const isValid = validators[id](value);
        const feedbackElement = document.getElementById(id + "Feedback");

        if (isValid) {
            feedbackElement.textContent = "✔ 유효한 입력입니다.";
            feedbackElement.style.color = "green";
        } else {
            feedbackElement.textContent = getErrorMessage(id);
            feedbackElement.style.color = "red";
        }
    }

    // 오류 메시지 반환 함수
    function getErrorMessage(id) {
        switch (id) {
            case "password":
                return "비밀번호는 8자 이상이어야 합니다.";
            case "confirmPassword":
                return "비밀번호가 일치하지 않습니다.";
            case "nickname":
                return "닉네임은 2~10자의 한글, 영문, 숫자만 가능합니다.";
            case "phone":
                return "전화번호는 01012345678 형식이어야 합니다.";
            case "email":
                return "유효한 이메일 주소를 입력하세요.";
            default:
                return "유효하지 않은 입력입니다.";
        }
    }

    // 각 입력 필드에 keyup 이벤트 처리
    document.getElementById("password").addEventListener("keyup", function () {
        validateInput(this);
    });
    document.getElementById("confirmPassword").addEventListener("keyup", function () {
        validateInput(this);
    });
    document.getElementById("nickname").addEventListener("keyup", function () {
        validateInput(this);
    });
    document.getElementById("phone").addEventListener("keyup", function () {
        validateInput(this);
    });
    document.getElementById("email").addEventListener("keyup", function () {
        validateInput(this);
    });

    $(document).ready(function () {
        // 중복 확인 버튼 클릭 이벤트
        $('#checkNickname').click(function () {
            const nickname = $('#nickname').val().trim(); // 닉네임 값 가져오기

            if (nickname === "") {
                $('#nicknameFeedback').text('닉네임을 입력해주세요.').css('color', 'red');
                return;
            }

            $.ajax({
                url: '/mypage/edit/nickname', // REST 컨트롤러 URL
                type: 'GET', // 요청 방식
                data: { nickname: nickname }, // 쿼리 파라미터로 닉네임 전달
                success: function (response) {
                    // 서버 응답 처리
                    if (response.isAvailable) {
                        $('#nicknameFeedback').text('사용 가능한 닉네임입니다.').css('color', 'green');
                    } else {
                        $('#nicknameFeedback').text('이미 사용 중인 닉네임입니다.').css('color', 'red');
                    }
                },
                error: function (xhr, status, error) {
                    console.error('AJAX 요청 실패:', error);
                    $('#nicknameFeedback').text('중복 확인 중 오류가 발생했습니다.').css('color', 'red');
                }
            });
        });

        // 비밀번호 비교 이벤트 (비밀번호 입력 필드에서 포커스가 떠날 때)
        $('#password').on('blur', function () {
            const newPassword = $(this).val().trim();

            // 새 비밀번호가 비어있지 않을 때만 요청
            if (newPassword !== "") {
                $.ajax({
                    url: '/mypage/edit/password/check', // REST 컨트롤러 URL
                    type: 'POST', // 요청 방식
                    contentType: 'application/json', // JSON 데이터 전송
                    data: JSON.stringify({ newPassword: newPassword }), // 요청 데이터
                    success: function (response) {
                        // 서버 응답 처리
                        if (response.isSameAsOldPassword) {
                            $('#passwordFeedback').text('이전 비밀번호와 같습니다. 다른 비밀번호를 입력해주세요.').css('color', 'red');
                        } else {
                            $('#passwordFeedback').text('✔ 유효한 비밀번호입니다.').css('color', 'green');
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error('AJAX 요청 실패:', error);
                        $('#passwordFeedback').text('비밀번호 확인 중 오류가 발생했습니다.').css('color', 'red');
                    }
                });
            }
        });
    });

</script>
</body>


</html>
