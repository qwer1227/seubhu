<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">

    <h2> 쪽지 상세 </h2>

    <div>
        <div class="col d-flex justify-content-left">
            <div>
                <a href="" style="text-decoration-line: none">받은 쪽지</a>
            </div>
        </div>
        <div class="title h4 d-flex justify-content-between align-items-center">
            <div>
                ${message.title}
            </div>
            <div class="ml-auto">
                ${message.createdDate}
            </div>
        </div>
        <div class="meta d-flex justify-content-between mb-3">
            <span>보낸사람: ${message.senderNickname}</span>
        </div>

        <div class="content mb-4">
            <p>${message.content}</p>
        </div>

        <div class="actions d-flex justify-content-end mb-4">
            <div>
                <!-- 삭제 버튼 -->
                <form action="/message/delete" method="post" style="display: inline;">
                    <input type="hidden" name="messageNo" value="${message.messageNo}"/>
                    <button type="submit" class="btn btn-danger">삭제</button>
                </form>

                <!-- 답장 버튼 -->
                <a type="button" href="/message/add?receiver=${message.senderNickname}" class="btn btn-outline-dark">답장</a>

                <!-- 목록 버튼 -->
                <a type="button" href="/message/list" class="btn btn-dark">목록</a>
            </div>
        </div>

    </div>
    <%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>