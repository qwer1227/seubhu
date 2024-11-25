<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>

</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<security:authentication property="principal" var="loginUser"/>
<div class="container-xxl" id="wrap">
    <div class="row mb-5">
        <div class="col-2"></div>
        <div class="col">
            <h1 class="text-center mb-5 bg-black text-white">${lesson.title}</h1>
            <a href="/lesson" class="btn btn-dark" style="text-decoration: none"><strong>일정보기</strong></a>
        </div>
        <div class="col-2"></div>
    </div>
    <div class="row mb-3 d-flex justify-content-center">
        <div class="col-4 border">
            <c:if test="${not empty images['THUMBNAIL']}">
                <img src="${pageContext.request.contextPath}/resources/lessonImg/${images['THUMBNAIL']}"
                     class="img-fluid" alt="Thumbnail" id="Thumbnail" style="width: 100%; height: 500px;"/>
            </c:if>
        </div>
        <div class="col-4">
            <table class="table">
                <colgroup>
                    <col width="20%">
                    <col width="*%">
                </colgroup>
                <tr>
                    <th>레슨명</th>
                    <td>${lesson.title}</td>
                </tr>
                <tr>
                    <th>강사명</th>
                    <td>${lesson.lecturer.name}</td>
                </tr>
                <tr>
                    <th>레슨날짜</th>
                    <td>${startDate} ${startTime}</td>
                </tr>
                <tr>
                    <th>참여인원</th>
                    <td>${lesson.participant}/5</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="row text-white text-start mb-3">
        <div class="col-2"></div>
        <div class="col-4 bg-black">${lesson.title}</div>
        <div class="col-1 bg-black">결제 금액</div>
        <div class="col-1 bg-black">${lesson.price}</div>
        <div class="col-2 bg-black"></div>
        <div class="col-2"></div>
    </div>
    <div class="row text-end mb-3">
        <div class="col-2"></div>
        <div class="col border-bottom border-dark border-2 pb-3">
            <form name="lessonDto" method="get" action="/order/pay/form" id="hidden-form">
                <input type="hidden" name="lessonNo" value="${lesson.lessonNo}">
<%--                <input type="hidden" name="userNo" value="${loginUser.no}" />--%>
                <input type="hidden" name="title" value="${lesson.title}">
                <input type="hidden" name="price" value="${lesson.price}">
                <input type="hidden" name="lecturerName" value="${lesson.lecturer.name}">
                <input type="hidden" name="startDate" value="${startDate}">
                <input type="hidden" name="startTime" value="${startTime}">
                <input type="hidden" name="subject" value="${lesson.subject}">
                <button type="submit" class="btn btn-primary">수강신청</button>
            </form>
        </div>
        <div class="col-2"></div>
    </div>
    <div class="row">
        <div class="col-2"></div>
        <div class="col text-center"><h1>강의 계획 및 커리큘럼</h1></div>
        <div class="col-2"></div>
    </div>
    <div class="row">
        <div class="col-2"></div>
        <div class="col text-center border-bottom border-dark border-2 pb-3 mb-3 ">
            <p>
                ${lesson.plan}
            </p>
            <p>
                <c:if test="${not empty images.MAIN_IMAGE}">
                    <img src="${pageContext.request.contextPath}/resources/lessonImg/${images['MAIN_IMAGE']}"
                         alt="Main Image"/>
                </c:if>
            </p>
        </div>
        <div class="col-2"></div>
    </div>
    <div class="row">
        <div class="col-2"></div>
        <div class="col text-end">
            <a href="/lesson/editForm?lessonNo=${lessonNo}" class="btn btn-primary">수정</a>
        </div>
        <div class="col-2"></div>
    </div>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
<script>

</script>
</body>
</html>