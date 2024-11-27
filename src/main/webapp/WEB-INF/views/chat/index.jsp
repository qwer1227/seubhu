<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/common/common.jsp" %>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        #chatbox {
            width: 300px;
            height: 400px;
            border: 1px solid #ccc;
            padding: 10px;
            overflow-y: scroll;
            margin-bottom: 10px;
        }

        #userInput {
            width: 300px;
            padding: 10px;
            margin-top: 5px;
        }

        /* 모달 스타일 */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }

        .modal-content {
            background-color: transparent; /* 배경 투명 설정 */
            margin: 15% auto;
            padding: 20px;
            border: none; /* 테두리 제거 */
            width: 80%;
            text-align: center; /* 내용 중앙 정렬 */
        }

        /* 스피너 스타일 */
        .spinner {
            border: 3px solid #f3f3f3; /* 회전 원 테두리 색상 */
            border-top: 3px solid #3498db; /* 회전 원의 윗 부분 색상 */
            border-radius: 50%;
            width: 30px;
            height: 30px;
            animation: spin 1s linear infinite; /* 애니메이션 지정 */
            margin: 0 auto;
        }

        @keyframes spin {
            0% {
                transform: rotate(0deg);
            }
            100% {
                transform: rotate(360deg);
            }
        }
    </style>
</head>
<body>
<%@include file="/WEB-INF/common/nav.jsp" %>
<body>
<div class="container mt-5">
    <h1 class="text-center mb-4">고객센터 챗봇</h1>

    <div id="chatbox" class="border rounded p-3 mb-3"
         style="height: 400px; overflow-y: auto; background-color: #f8f9fa;">
        <!-- 메시지가 여기에 추가됩니다 -->
    </div>

    <div class="input-group">
        <input type="text" id="userInput" name="userInput" class="form-control"
               placeholder="메시지를 입력하세요..." required
               onkeydown="if(event.keyCode===13){ enterQuestion(); return false; }">
        <button class="btn btn-primary" onclick="enterQuestion()">전송</button>
    </div>
</div>

<%@include file="/WEB-INF/common/footer.jsp" %>

<script>
    const chatbox = $('#chatbox');
    const userInput = $('#userInput');

    function enterQuestion() {
        const data = {
            userInput: userInput.val()
        }

        chatbox.append('<p class="text-end"><span class="badge bg-primary">' + userInput.val() + '</span></p>');
        scrollToBottom();
        userInput.val('');
        openModal();
        postApi('/chat', data, onSuccessResponse, onApiError);
    }

    function onSuccessResponse(data) {
        closeModal();
        chatbox.append('<p><strong>BOT : </strong><span class="badge bg-success">' + data.value + '</span></p>');
        scrollToBottom();
    }

    function scrollToBottom() {
        chatbox.scrollTop(chatbox[0].scrollHeight);
    }

    function postApi(url, params, successCallback, errorCallback) {
        $.ajax({
            type: 'POST',
            url: url,
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            data: JSON.stringify(params),
            success: function (data) {
                if (typeof successCallback === 'function') {
                    successCallback(data);
                }
            },
            error: function (err) {
                if (typeof errorCallback === 'function') {
                    errorCallback(err);
                }
            }
        });
    }

    function onApiError(err) {
        closeModal();
        alert(err);
    }

    function openModal() {
        document.querySelector('.modal').style.display = 'block';
    }

    // 모달 닫기
    function closeModal() {
        document.querySelector('.modal').style.display = 'none';
    }
</script>
</body>
</html>