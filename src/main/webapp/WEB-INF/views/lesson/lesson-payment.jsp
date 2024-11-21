<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<meta charset="UTF-8" />
    <%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<body>
<div>
    <h2>카카오페이연습</h2>

        <button id="btn-pay-ready" type="button">결제</button>
</div>
</body>

<script type="text/javascript">
    // 카카오페이 결제 팝업창 연결
    $(function() {
        $("#btn-pay-ready").click(function(e) {
            // 아래 데이터 외에도 필요한 데이터를 원하는 대로 담고, Controller에서 @RequestBody로 받으면 됨
            let data = {
                name: '상품명',    // 카카오페이에 보낼 대표 상품명
                totalPrice: 20000 // 총 결제금액
            };

            $.ajax({
                type: 'POST',
                url: '/order/pay/ready',
                data: JSON.stringify(data),
                contentType: 'application/json',
                success: function(response) {
                    location.href = response.next_redirect_pc_url;
                }
            });
        });
    });
</script>

<%--<%@include file="/WEB-INF/views/common/tags.jsp" %>--%>
<%--<!doctype html>--%>
<%--<html lang="ko">--%>
<%--<head>--%>

<%--    &lt;%&ndash;    <script src="https://cdn.portone.io/v2/browser-sdk.js"></script>&ndash;%&gt;--%>
<%--    <script src="https://js.tosspayments.com/v2/standard"></script>--%>
<%--    <link rel="stylesheet" type="text/css" href="/resources/css/style.css"/>--%>
<%--</head>--%>
<%--<body>--%>
<%--<%@include file="/WEB-INF/views/common/nav.jsp" %>--%>
<%--<div class="container-xxl" id="wrap">--%>
<%--    <div class="row text-center mb-5">--%>
<%--        <h1>레슨 예약 정보</h1>--%>
<%--    </div>--%>
<%--    <div class="row d-flex justify-content-center mb-3">--%>
<%--        <div class="col-4 border border-dark">--%>
<%--            <img src="${pageContext.request.contextPath}/resources/lessonImg/1.png"--%>
<%--                 alt="Main Image" style="width: 100%; height: 300px;"/>--%>
<%--        </div>--%>
<%--        <div class="col-5 border border-dark border">--%>
<%--            <table class="table">--%>
<%--                <colgroup>--%>
<%--                    <col width="15%">--%>
<%--                    <col width="*%">--%>
<%--                </colgroup>--%>
<%--                <tr>--%>
<%--                    <th>레슨명</th>--%>
<%--                    <td>${lessonDto.title}</td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <th>과정</th>--%>
<%--                    <td>${lessonDto.subject}</td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <th>강사명</th>--%>
<%--                    <td>${lessonDto.lecturerName}</td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <th>레슨날짜</th>--%>
<%--                    <td>--%>
<%--                        &lt;%&ndash;                        <fmt:formatDate value="${lessonDto.startDate}" pattern="yyyy-MM-dd"></fmt:formatDate>&ndash;%&gt;--%>
<%--                        ${lessonDto.startDate}--%>
<%--                    </td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <th>결제금액</th>--%>
<%--                    <td><fmt:formatNumber value="${lessonDto.price}" pattern="#,###"/></td>--%>
<%--                </tr>--%>
<%--            </table>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--&lt;%&ndash;    <div class="row">&ndash;%&gt;--%>
<%--&lt;%&ndash;        <div class="col">&ndash;%&gt;--%>

<%--&lt;%&ndash;        </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;        <div class="col">&ndash;%&gt;--%>

<%--&lt;%&ndash;        </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;        <input type="checkbox" value="">&ndash;%&gt;--%>
<%--&lt;%&ndash;    </div>&ndash;%&gt;--%>
<%--&lt;%&ndash;    <div class="row">&ndash;%&gt;--%>
<%--&lt;%&ndash;        <div>&ndash;%&gt;--%>
<%--&lt;%&ndash;            <input type="checkbox" id="coupon-box"/>&ndash;%&gt;--%>
<%--&lt;%&ndash;            <label for="coupon-box"> 5,000원 쿠폰 적용 </label>&ndash;%&gt;--%>
<%--&lt;%&ndash;        </div>&ndash;%&gt;--%>
<%--        <!-- 결제 UI -->--%>
<%--        &lt;%&ndash;    <div id="payment-method"></div>&ndash;%&gt;--%>
<%--        &lt;%&ndash;    <!-- 이용약관 UI -->&ndash;%&gt;--%>
<%--        &lt;%&ndash;    <div id="agreement"></div>&ndash;%&gt;--%>
<%--        &lt;%&ndash;    <!-- 결제하기 버튼 -->&ndash;%&gt;--%>
<%--        <div>--%>
<%--            &lt;%&ndash;    <button class="button" id="payment-button" style="margin-top: 30px" onclick="openCheckoutPopup()">결제하기</button>&ndash;%&gt;--%>
<%--            <button type="button" id="btn-pay-ready" class="btn btn-dark">결제하기</button>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>
<%--<%@include file="/WEB-INF/views/common/footer.jsp" %>--%>

<%--<script type="text/javascript">--%>
<%--    // 카카오페이 결제 팝업창 연결--%>
<%--    $(function () {--%>
<%--        $("#btn-pay-ready").click(function (e) {--%>
<%--            // 아래 데이터 외에도 필요한 데이터를 원하는 대로 담고, Controller에서 @RequestBody로 받으면 됨--%>
<%--            let data = {--%>
<%--                name: '상품명',    // 카카오페이에 보낼 대표 상품명--%>
<%--                totalPrice: 20000 // 총 결제금액--%>
<%--            };--%>

<%--            $.ajax({--%>
<%--                type: 'POST',--%>
<%--                url: '/order/pay/ready',--%>
<%--                data: JSON.stringify(data),--%>
<%--                contentType: 'application/json',--%>
<%--                success: function (response) {--%>
<%--                    location.href = response.next_redirect_pc_url;--%>
<%--                }--%>
<%--            });--%>
<%--        });--%>
<%--    });--%>
<%--    &lt;%&ndash;function openCheckoutPopup() {&ndash;%&gt;--%>
<%--    &lt;%&ndash;    const popupWidth = 600; // 팝업 창의 너비&ndash;%&gt;--%>
<%--    &lt;%&ndash;    const popupHeight = 800; // 팝업 창의 높이&ndash;%&gt;--%>
<%--    &lt;%&ndash;    const left = (screen.width / 2) - (popupWidth / 2); // 화면 중앙 정렬&ndash;%&gt;--%>
<%--    &lt;%&ndash;    const top = (screen.height / 2) - (popupHeight / 2); // 화면 중앙 정렬&ndash;%&gt;--%>

<%--    &lt;%&ndash;    window.open(&ndash;%&gt;--%>
<%--    &lt;%&ndash;        '/payments/checkout', // 열릴 페이지 경로&ndash;%&gt;--%>
<%--    &lt;%&ndash;        'CheckoutPopup', // 팝업 이름&ndash;%&gt;--%>
<%--    &lt;%&ndash;        `width=${popupWidth},height=${popupHeight},top=${top},left=${left},resizable=no,scrollbars=yes`&ndash;%&gt;--%>
<%--    &lt;%&ndash;    );&ndash;%&gt;--%>
<%--    &lt;%&ndash;}&ndash;%&gt;--%>

<%--</script>--%>
<%--</body>--%>
<%--</html>--%>