<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/common/common.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/common/nav.jsp" %>
<div class="container-xxl" id="wrap">
    <div class="row mb-5">
        <div class="col-2"></div>
        <div class="col-3">
            <a href="/lesson" class="btn btn-dark" style="text-decoration: none"><strong>일정보기</strong></a>
        </div>
    </div>
    <div class="row mb-3 d-flex justify-content-center">
        <h1 class="text-center mb-5 bg-black text-white">개인 자세교정 4회과정</h1>
        <div class="col-4 border ">
            <h1>이미지</h1>
        </div>
        <div class="col-4">
            <table class="table text-start">
                <tr>
                    <td class="badge bg-info">신규</td>
                </tr>
                <tr class="m-3">
                    <td>개인 자세교정 4회과정 | am 09시</td>
                </tr>
                <tr>
                    <td>강사 명 :홍길동</td>
                </tr>
                <tr>
                    <td>장소 :중앙HTA</td>
                </tr>
                <tr>
                    <td colspan="2">클래스 일정 :중앙HTA</td>
                </tr>
                <tr>
                    <td colspan="2">클래스 요일 :중앙HTA</td>
                </tr>
                <tr>
                    <td colspan="2">클래스 시간 :09:00</td>
                </tr>
                <tr>
                    <td colspan="2">신청인원 :0/1</td>
                </tr>
            </table>
        </div>
    </div>
    <div class="row text-white text-start mb-3">
        <div class="col-2"></div>
        <div class="col-4 bg-black">개인 자세교정 4회과정 | am 09시</div>
        <div class="col-1 bg-black">결제 금액</div>
        <div class="col-1 bg-black">50, 000원</div>
        <div class="col-2 bg-black"></div>
        <div class="col-2"></div>
    </div>
    <div class="row text-end mb-3">
        <div class="col-2"></div>
        <div class="col border-bottom border-2 pb-3"><button class="btn btn-primary">수강신청</button></div>
        <div class="col-2"></div>
    </div>
    <div class="row">
        <div class="col-2"></div>
        <div class="col text-center"><h1>강의 계획 및 커리큘럼</h1></div>
        <div class="col-2"></div>
    </div>
    <div class="row">
        <div class="col-2"></div>
        <div class="col text-center">비고 시도합니다. 저에서도 키보드 탐색은 영향을 받지 않습니다. 따라서 확실하게 하려면 aria-disabled="true" 외에도 이러한 링크에 tabindex="-1" 속성을 포함하여 키보드 포커스를 받지 않도록 하고 사용자 지정 JavaScript를 사용하여 해당 기능을 완전히 비활성화해야 합니다.</div>
        <div class="col-2"></div>
    </div>
</div>
<%@include file="/WEB-INF/common/footer.jsp" %>
</body>
</html>