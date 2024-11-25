<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<body>
<div class="container-xxl border align-content-center" id="wrap">
    <div class="row text-center mb-5">
        <h1>레슨 예약 완료</h1>
    </div>
    <div class="row d-flex justify-content-center mb-3">
        <div class="col-5 border border-dark">
            <img src="${pageContext.request.contextPath}/resources/lessonImg/1.png"
                 alt="Main Image" style="width: 100%; height: 300px;"/>
        </div>
        <div class="col-5 border border-dark border">
            <table class="table">
                <colgroup>
                    <col width="15%">
                    <col width="*%">
                </colgroup>
                <tr>
                    <th>레슨명</th>
                    <td><a href="/lesson/detail?lessonNo=${lesson.lessonNo}">${lesson.title}</td>
                </tr>
                <tr>
                    <th>과정</th>
                    <td>${lesson.subject}</td>
                </tr>
                <tr>
                    <th>강사명</th>
                    <td>${lesson.lecturer.name}</td>
                </tr>
                <tr>
                    <th>레슨날짜</th>
                    <td>
                        ${lesson.startDate}
                    </td>
                </tr>
                <tr>
                    <th>결제금액</th>
                    <td><fmt:formatNumber value="${lesson.price}" pattern="#,###"/></td>
                </tr>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-1"></div>
        <div class="col">
            <a href="lesson/reservation" class="btn btn-dark w-100">예약 내역</a>
        </div>
        <div class="col-1"></div>
    </div>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>

<script type="text/javascript">
</script>

</body>
</html>