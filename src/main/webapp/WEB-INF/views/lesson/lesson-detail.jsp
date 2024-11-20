<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
    <script src="https://js.tosspayments.com/v2/standard"></script>
    <script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
    <style>
        body {
            background: #fafafa;
        }
    </style>
</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl bg-white" id="wrap">
    <div class="row mb-5">
        <h1 class="text-center mb-5 bg-black text-white">${lesson.title}</h1>
        <div class="col-2"></div>
        <div class="col-3">
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
            <table class="table text-start">
                <tr>
                    <td class="badge bg-info">신규</td>
                </tr>
                <tr class="m-3">
                    <td>${lesson.title}</td>
                </tr>
                <tr>
                    <td>강사 명 : ${lesson.lecturer.username}</td>
                </tr>
                <tr>
                    <td>장소 :중앙HTA</td>
                </tr>
                <tr>
                    <td colspan="2">클래스 일정 :중앙HTA</td>
                </tr>
                <tr>
                    <td colspan="2">클래스 요일 :목요일</td>
                </tr>
                <tr>
                    <td colspan="2">클래스 시간 :09:00</td>
                </tr>
                <tr>
                    <td colspan="2">신청인원 :${lesson.participant}/5</td>
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
            <a href="/payments/checkout" class="btn btn-danger">수강신청</a>
            <button class="btn btn-primary" id="pay" onclick="requestPay()">수강신청</button>
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

    // function requestPay() {
    //     PortOne.requestPayment({
    //         storeId: "store-217dbe0f-fbb7-4d16-bfff-f4a47ce92b0f",
    //         paymentId: "testm3o7667l",
    //         orderName: "짜장면 1개",
    //         totalAmount: 30000,
    //         currency: "KRW",
    //         channelKey: "channel-key-ccf24b7f-9a39-41a2-940e-c394c6a8dee0",
    //         productType: "REAL",
    //         payMethod: "CARD",
    //         card: {},
    //     });
    // }

    document.getElementById("pay").addEventListener("click", function () {
        const popupWidth = 600;
        const popupHeight = 800;
        const popupLeft = (window.screen.width / 2) - (popupWidth / 2);
        const popupTop = (window.screen.height / 2) - (popupHeight / 2);

        const popupWindow = window.open(
            '/payments/checkout',
            '결제 팝업',
            `width=${popupWidth},height=${popupHeight},top=${popupTop},left=${popupLeft},resizable=no,scrollbars=yes`
        );

        if (popupWindow) {
            popupWindow.onload = function() {
                popupWindow.resizeTo(popupWidth, popupHeight); // 로드 후 크기 조정
                popupWindow.moveTo(popupLeft, popupTop); // 위치 조정
            };
            popupWindow.focus();
        }
    });

</script>
</body>
</html>