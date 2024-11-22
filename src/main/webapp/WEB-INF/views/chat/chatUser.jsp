<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/common/common.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/common/nav.jsp" %>
<div class="container">
    <div class="row">
        <div class="col-12">
            <h1>상담 페이지</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-12">
            <div class="card" id="card-chat">
                <div class="card-header">상담내용</div>
                <div class="card-body" style="height: 500px; overflow-y:scroll;"></div>
                <div class='card-footer'>
                    <div class="row">
                        <div class="col-10">
                            <input type="text" class="form-control" name="message"/>
                        </div>
                        <div class="col-2"><button class="btn btn-secondary">전송</button></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/common/footer.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script type="text/javascript">
    $(function() {
        // 웹소켓 객체를 저장하는 변수다.
        let ws = null;
        // 현재 상담중인 직원아이디가 저장되는 변수ㅏ.
        let roomId = null;
        let employeeId = null;
        let customerId = '${LOGIN_ID}';

        // 웹소켓 연결요청을 보내는 메소드다.
        function connect() {
            // 웹소켓 객체를 생성하고, 지정된 URI로 웹소켓 연결요청을 보낸다.
            ws = new SockJS("/chat");
            // onopen이벤트(웹소켓서버와 연결이 완료되면 발생하는 이벤트다) 발생시 실행될 콜백함수를 등록한다.
            ws.onopen = function() {
                // 상담용 채팅방 생성을 요청하는 메세지를 보낸다.
                openChat();
            }
            // onmessage이벤트(웹소켓서버가 보낸 메세지를 수신하면 발생하는 이벤트다.) 발생시 실행될 콜백함수를 등록한다.
            ws.onmessage = function(message) {
                let data = JSON.parse(message.data);

                if (data.cmd == "chat-open-success") {
                    roomId = data.roomId;
                    employeeId = data.employeeId;
                    appendChatMessage(data.text, 'float-start', 'alert-success', 'text-start');
                } else if (data.cmd == 'chat-message') {
                    appendChatMessage(data.text, 'float-start', 'alert-warning', 'text-start');
                } else if (data.cmd == 'chat-error') {
                    appendChatMessage(data.text, 'float-start', 'alert-danger', 'text-start');
                }
            }
        }
        // 웹소켓 연결요청을 보낸다.
        connect();

        // 웹소켓 연결을 해제한다.
        function disconnect() {
            if (ws != null) {
                ws.clos();
            }
        }

        // 상담시작 요청을 웹소켓으로 보낸다.
        function openChat() {
            let message = {
                cmd: 'chat-open',
                customerId: customerId,
                senderType: "고객"
            }
            send(message);
        }

        // 상담중단 요청을 웹소켓으로 보낸다.
        function closeChat() {
            let message = {
                cmd: 'chat-close',
                roomId: roomId,
                customerId: customerId,
                employeeId: employeeId,
                senderType: '고객'
            }
            send(message);
        }

        // 상담메세지를 웹소켓으로 보낸다.
        function chat() {
            let inputMessage = $(":input[name='message']").val();

            if (inputMessage) {
                let message = {
                    cmd: 'chat-message',
                    roomId: roomId,
                    customerId: customerId,
                    employeeId: employeeId,
                    senderType: '고객',
                    text: inputMessage
                }
                send(message);
                appendChatMessage(inputMessage, 'float-end', 'alert-info', 'text-end');
                $(":input[name='message']").val("");
            }
        }

        function send(message) {
            ws.send(JSON.stringify(message));
        }

        function appendChatMessage(message, floating, style, align) {
            let content = `
			<div class="w-75 \${floating}">
				<div class="alert \${style} \${align}">
					\${message}
				</div>
			</div>
		`;
            $("#card-chat .card-body").append(content);
        }

        $("#card-chat .card-footer button").click(function() {
            chat();
        });

        $(":input[name='message']").keydown(function(event) {
            if (event.which == 13) {
                chat();
            }
        })
    })
</script>
</body>
</html>