<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<%--<!DOCTYPE html>--%>
<%--<html lang="ko">--%>
<%--<head>--%>
<%--    <meta charset="utf-8" />--%>
<%--    <script src="https://js.tosspayments.com/v2/standard"></script>--%>
<%--    <title>결제 성공</title>--%>
<%--</head>--%>
<%--<body>--%>
<%--<h2>결제 성공</h2>--%>
<%--<p id="paymentKey">결제 키: </p>--%>
<%--<p id="orderId">주문 번호: </p>--%>
<%--<p id="amount">결제 금액: </p>--%>

<%--<script>--%>
<%--    // URL의 쿼리 파라미터에서 값 가져오기--%>
<%--    const urlParams = new URLSearchParams(window.location.search);--%>
<%--    const paymentKey = urlParams.get("paymentKey");--%>
<%--    const orderId = urlParams.get("orderId");--%>
<%--    const amount = urlParams.get("amount");--%>

<%--    async function confirm() {--%>
<%--        const requestData = {--%>
<%--            paymentKey: paymentKey,--%>
<%--            orderId: orderId,--%>
<%--            amount: amount,--%>
<%--        };--%>

<%--        try {--%>
<%--            const response = await fetch("/payments/confirm", {--%>
<%--                method: "POST",--%>
<%--                headers: {--%>
<%--                    "Content-Type": "application/json",--%>
<%--                },--%>
<%--                body: JSON.stringify(requestData),--%>
<%--            });--%>

<%--            const json = await response.json();--%>

<%--            if (response.ok) {--%>
<%--                // 결제 성공 시 데이터 표시--%>
<%--                document.getElementById("paymentKey").textContent = "결제 키: " + json.paymentKey;--%>
<%--                document.getElementById("orderId").textContent = "주문 번호: " + json.orderId;--%>
<%--                document.getElementById("amount").textContent = "결제 금액: " + json.amount;--%>
<%--            } else {--%>
<%--                // 실패 시 처리--%>
<%--                console.error(json);--%>
<%--                window.location.href = `/fail?message=${json.message}&code=${json.code}`;--%>
<%--            }--%>
<%--        } catch (error) {--%>
<%--            console.error("Error during payment confirmation:", error);--%>
<%--            alert("결제 확인 중 문제가 발생했습니다.");--%>
<%--        }--%>
<%--    }--%>

<%--    confirm();--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <link rel="icon" href="https://static.toss.im/icons/png/4x/icon-toss-logo.png" />
    <link rel="stylesheet" type="text/css" href="style.css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>토스페이먼츠 샘플 프로젝트</title>
</head>

<body>
<div class="box_section text-center" style="width: 600px">
    <img width="100px" src="https://static.toss.im/illusts/check-blue-spot-ending-frame.png" />
    <h2>결제를 완료했어요</h2>

    <div class="p-grid typography--p" style="margin-top: 50px">
        <div class="p-grid-col text--left"><b>결제금액</b></div>
        <div class="p-grid-col text--right" id="amount"></div>
    </div>
    <div class="p-grid typography--p" style="margin-top: 10px">
        <div class="p-grid-col text--left"><b>주문번호</b></div>
        <div class="p-grid-col text--right" id="orderId"></div>
    </div>
    <div class="p-grid typography--p" style="margin-top: 10px">
        <div class="p-grid-col text--left"><b>paymentKey</b></div>
        <div class="p-grid-col text--right" id="paymentKey" style="white-space: initial; width: 250px"></div>
    </div>
    <div class="p-grid" style="margin-top: 30px">
        <button class="button p-grid-col5" onclick="location.href='https://docs.tosspayments.com/guides/v2/payment-widget/integration';">연동 문서</button>
        <button class="button p-grid-col5" onclick="location.href='https://discord.gg/A4fRFXQhRu';" style="background-color: #e8f3ff; color: #1b64da">실시간 문의</button>
    </div>
</div>

<div class="box_section" style="width: 600px; text-align: left">
    <b>Response Data :</b>
    <div id="response" style="white-space: initial"></div>
</div>

<script>
    // 쿼리 파라미터 값이 결제 요청할 때 보낸 데이터와 동일한지 반드시 확인하세요.
    // 클라이언트에서 결제 금액을 조작하는 행위를 방지할 수 있습니다.
    const urlParams = new URLSearchParams(window.location.search);

    // 서버로 결제 승인에 필요한 결제 정보를 보내세요.
    async function confirm() {
        var requestData = {
            paymentKey: urlParams.get("paymentKey"),
            orderId: urlParams.get("orderId"),
            amount: urlParams.get("amount"),
        };

        const response = await fetch("/payments/confirm", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify(requestData),
        });

        const json = await response.json();

        if (!response.ok) {
            // TODO: 결제 실패 비즈니스 로직을 구현하세요.
            console.log(json);
            window.location.href = `/payments/fail?message=${json.message}&code=${json.code}`;
        }

        // TODO: 결제 성공 비즈니스 로직을 구현하세요.
        // console.log(json);
        return json;
    }
    confirm().then(function (data) {
        document.getElementById("response").innerHTML = `<pre>${JSON.stringify(data, null, 4)}</pre>`;
    });

    const paymentKeyElement = document.getElementById("paymentKey");
    const orderIdElement = document.getElementById("orderId");
    const amountElement = document.getElementById("amount");

    orderIdElement.textContent = urlParams.get("orderId");
    amountElement.textContent = urlParams.get("amount") + "원";
    paymentKeyElement.textContent = urlParams.get("paymentKey");
</script>
</body>
</html>
