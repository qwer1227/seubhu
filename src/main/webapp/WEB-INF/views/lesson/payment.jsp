<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/tags.jsp" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <script src="https://js.tosspayments.com/v2/standard"></script>
</head>
<body>
<!-- 할인 쿠폰 -->
<div>
    <input type="checkbox" id="coupon-box" />
    <label for="coupon-box"> 5,000원 쿠폰 적용 </label>
</div>
<!-- 결제 UI -->
<div id="payment-method"></div>
<!-- 이용약관 UI -->
<div id="agreement"></div>
<!-- 결제하기 버튼 -->
<button class="button" id="payment-button" style="margin-top: 30px">결제하기</button>

<script>
    // 스크립트 태그 연동방식
    const tossPayments = TossPayments("test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm"); // 결제위젯 연동 키
    const tossPayments = TossPayments("test_ck_D5GePWvyJnrK0W0k6q8gLzN97Eoq");  // API 개별 연동 키
    // 모듈 임포트 연동방식
    import { loadTossPayments } from "@tosspayments/tosspayments-sdk"
    const tossPayments = await loadTossPayments("test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm");

    // 회원 결제
    const widgets = tossPayments.widgets({ customerKey });
    // 비회원 결제
    // 스크립트 태그 연동방식
    const widgets = tossPayments.widgets({ customerKey: TossPayments.ANONYMOUS });
    // 모듈 임포트 연동방식
    import { ANONYMOUS } from "@tosspayments/tosspayments-sdk";
    const widgets = tossPayments.widgets({ customerKey: ANONYMOUS });

    widgets.setAmount({
        currency: 'KRW',
        value: amount,
    });

    main();

    async function main() {
        const button = document.getElementById("payment-button");
        const coupon = document.getElementById("coupon-box");
        // ------  결제위젯 초기화 ------
        const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
        const tossPayments = TossPayments(clientKey);
        // 회원 결제
        const customerKey = "ZiGpAe6yAPZJvhKtUviNO";
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
                orderId: "jNk4E35EZJjiI7SYQ11_S",
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