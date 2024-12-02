<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        #wrap {
            width: 90%;
            margin: 0 auto;
            padding-top: 20px;
        }

        .order-section {
            background-color: white;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .order-title {
            font-size: 24px;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .order-date {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .order-summary {
            margin-bottom: 10px;
        }

        .order-summary span {
            font-weight: bold;
        }

        .view-details-btn {
            background-color: #3498db;
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }

        .view-details-btn:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">

    <div class="order-section">
        <div class="order-title">주문내역</div>

        <!-- 주문 1 -->
        <c:forEach var="order" items="${orders}">
        <div class="order-date">${order.orderDate}</div>
        <div class="order-summary">
            <p><span>주문 상품:</span> ${order.productName}</p>
            <p><span>총 주문 금액:</span> ${order.productPrice}원</p>
        </div>
        <a href="/mypage/orderhistorydetail/${order.orderNo}" class="view-details-btn">상세보기</a> <!-- 주문 상세 페이지 링크 -->
        </c:forEach>
    </div>

</div>

<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
