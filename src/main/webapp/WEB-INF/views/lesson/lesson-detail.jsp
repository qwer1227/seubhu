<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>

</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
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
                     class="img-fluid" alt="Thumbnail" style="width: 100%; height: 300px;"/>
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
                    <td>ddd</td>
                </tr>
                <tr>
                    <th>결제금액</th>
                    <td>ddd</td>
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
            <a href="/lesson/payment" class="btn btn-primary">수강신청</a>
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
                비고 시도합니다. 저에서도 키보드 탐색은 영향을 받지 않습니다. 따라서 확실하게 하려면 aria-disabled="true" 외에도 이러한 링크에 tabindex="-1" 속성을 포함하여
                키보드
                포커스를 받지 않도록 하고 사용자 지정 JavaScript를 사용하여 해당 기능을 완전히 비활성화해야
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