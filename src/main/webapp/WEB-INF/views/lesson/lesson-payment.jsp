<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
<%--    <script src="https://cdn.portone.io/v2/browser-sdk.js"></script>--%>
    <script src="https://js.tosspayments.com/v2/standard"></script>
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
        <div class="col-5 border border-dark border">
            <table class="table">
                <colgroup>
                    <col width="15%">
                    <col width="*%">
                </colgroup>
                <tr>
                    <th>레슨명</th>
                    <td>${lessonDto.title}</td>
                </tr>
                <tr>
                    <th>과정</th>
                    <td>${lessonDto.subject}</td>
                </tr>
                <tr>
                    <th>강사명</th>
                    <td>${lessonDto.lecturerName}</td>
                </tr>
                <tr>
                    <th>레슨날짜</th>
                    <td>
<%--                        <fmt:formatDate value="${lessonDto.startDate}" pattern="yyyy-MM-dd"></fmt:formatDate>--%>
                        ${lessonDto.startDate}
                    </td>
                </tr>
                <tr>
                    <th>결제금액</th>
                    <td><fmt:formatNumber value="${lessonDto.price}" pattern="#,###" /></td>
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
        div>
        <input type="checkbox" id="coupon-box" />
        <label for="coupon-box"> 5,000원 쿠폰 적용 </label>
    </div>
    <!-- 결제 UI -->
    <div id="payment-method"></div>
    <!-- 이용약관 UI -->
    <div id="agreement"></div>
    <!-- 결제하기 버튼 -->
    <button class="button" id="payment-button" style="margin-top: 30px">결제하기</button>
<%--        <button type="button" id="payment-button" class="btn btn-dark">결제하기</button>--%>
    </div>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>

<script>
    main();

    async function main() {
        const button = document.getElementById("payment-button");
        const coupon = document.getElementById("coupon-box");
        // ------  결제위젯 초기화 ------
        const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
        const tossPayments = TossPayments(clientKey);
        // 회원 결제
        const customerKey = "VSyHx-Wm6kHs-fCxJGo2C";
        const widgets = tossPayments.widgets({
            customerKey,
        });
        // 비회원 결제
        // const widgets = tossPayments.widgets({ customerKey: TossPayments.ANONYMOUS });

        // ------ 주문의 결제 금액 설정 ------
        await widgets.setAmount({
            currency: "KRW",
            value: 50000,
        });

        await Promise.all([
            // ------  결제 UI 렌더링 ------
            widgets.renderPaymentMethods({
                selector: "#payment-method",
                variantKey: "DEFAULT",
            }),
            // ------  이용약관 UI 렌더링 ------
            widgets.renderAgreement({ selector: "#agreement", variantKey: "AGREEMENT" }),
        ]);

        // ------  주문서의 결제 금액이 변경되었을 경우 결제 금액 업데이트 ------
        coupon.addEventListener("change", async function () {
            if (coupon.checked) {
                await widgets.setAmount({
                    currency: "KRW",
                    value: 50000 - 5000,
                });

                return;
            }

            await widgets.setAmount({
                currency: "KRW",
                value: 50000,
            });
        });

        // ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
        button.addEventListener("click", async function () {
            await widgets.requestPayment({
                orderId: "hIO96V98QLSeSDovjnx_P132132",
                orderName: "토스 티셔츠 외 2건",
                successUrl: window.location.origin + "/success.html",
                failUrl: window.location.origin + "/fail.html",
                customerEmail: "customer123@gmail.com",
                customerName: "김토스",
                customerMobilePhone: "01012341234",
            });
        });
    }
</script>
</body>
</html>