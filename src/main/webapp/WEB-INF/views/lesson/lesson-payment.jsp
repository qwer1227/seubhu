<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
    <script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl" id="wrap">
    <div class="row text-center mb-5">
        <h1>레슨 예약 정보</h1>
    </div>
    <div class="row d-flex justify-content-center mb-3">
        <div class="col-4 border border-dark">
                    <img src="${pageContext.request.contextPath}/resources/lessonImg/1.png"
                         alt="Main Image" style="width: 100%; height: 300px;"/>
        </div>
        <div class="col-5 border border-dark border d-flex justify-content-center">
            <table class="table">
                <colgroup>
                    <col width="15%">
                    <col width="*%">
                </colgroup>
                <tr>
                    <th>레슨명</th>
                    <td>ddd</td>
                </tr>
                <tr>
                    <th>강사명</th>
                    <td>ddd</td>
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
    <div class="row">
        <div class="col">

        </div>
        <div class="col">

        </div>
        <input type="checkbox" value="">
    </div>
    <div class="row">
        <button type="button" class="btn btn-dark" onclick="requestPay()">결제하기</button>
    </div>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>

<script>
    function requestPay() {
        PortOne.requestPayment({
            storeId: "store-217dbe0f-fbb7-4d16-bfff-f4a47ce92b0f",
            paymentId: "testm3o7667l",
            orderName: "짜장면 1개",
            totalAmount: 30000,
            currency: "KRW",
            channelKey: "channel-key-ccf24b7f-9a39-41a2-940e-c394c6a8dee0",
            productType: "REAL",
            payMethod: "CARD",
            card: {},
        });
    }
</script>
</body>
</html>