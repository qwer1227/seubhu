<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/common/common.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/common/nav.jsp" %>

<div class="container mt-4">
    <div class="row">
        <div class="col-12">
            <h4 class="text-center">관리자-유저 채팅</h4>
        </div>
    </div>
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card">
                <!-- 채팅 메시지 영역 -->
                <div class="card-body" id="chatRoomContent" style="height: 400px; overflow-y: scroll;">
                    <div class="d-flex flex-column">
                        <!-- 봇 메시지 -->
                        <div class="d-flex align-items-start mb-2" id="chatBotMessage">
                            <div class="bg-light p-2 rounded">
                                <p class="mb-0">안녕하세요! 무엇을 도와드릴까요?</p>
                            </div>
                        </div>
                        <!-- 관리자 메시지 -->
                        <div class="d-flex align-items-start mb-2" id="chatAdminMessage">
                            <div class="bg-warning p-2 rounded">
                                <p class="mb-0">문의 주신 내용을 확인했습니다.</p>
                            </div>
                        </div>
                        <!-- 유저 메시지 -->
                        <div class="d-flex align-items-end justify-content-end mb-2" id="chatUserMessage">
                            <div class="bg-primary text-white p-2 rounded">
                                <p class="mb-0">네, 감사합니다!</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- 메시지 입력 및 파일 업로드 -->
                <div class="card-footer">
                    <form id="chatRoomForm" class="d-flex flex-wrap">
                        <div class="col-12 col-sm flex-grow-1 me-sm-2 mb-2 mb-sm-0">
                            <input type="text" class="form-control" id="chatRoomInput" name="chatMessage" placeholder="메시지를 입력하세요..." required />
                        </div>
                        <div class="col-12 col-sm-auto">
                            <button type="submit" class="btn btn-primary w-100" id="chatRoomSendButton">전송</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>



<%@include file="/WEB-INF/common/footer.jsp" %>
<script type="text/javascript">
document.getElementById('chatRoomForm').addEventListener('submit', function(e) {
e.preventDefault(); // 폼 제출을 방지하여 페이지 리로드를 막음

const chatMessage = document.getElementById('chatRoomInput').value;
if (chatMessage.trim()) {
const userMessage = document.createElement('div');
userMessage.classList.add('d-flex', 'align-items-end', 'justify-content-end', 'mb-2');
userMessage.innerHTML = `<div class="bg-primary text-white p-2 rounded">
    <p class="mb-0">${chatMessage}</p>
</div>`;
document.getElementById('chatRoomContent').appendChild(userMessage);
document.getElementById('chatRoomInput').value = ''; // 입력 필드 초기화
}
});
</script>
</body>
</html>