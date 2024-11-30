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

    .order-details {
      margin-bottom: 20px;
    }

    .order-details p {
      font-size: 18px;
    }

    .order-item {
      display: flex;
      align-items: center;
      margin-bottom: 15px;
    }

    .order-item img {
      width: 80px;
      height: 80px;
      object-fit: cover;
      margin-right: 20px;
    }

    .order-item-details {
      flex-grow: 1;
    }

    .order-item-details p {
      margin: 5px 0;
    }

    .order-item-details span {
      font-weight: bold;
    }

    .payment-info {
      font-size: 18px;
      margin-top: 20px;
      font-weight: bold;
    }

    .payment-details {
      margin-top: 10px;
    }
  </style>
</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">

  <div class="order-section">
    <div class="order-title">주문 상세</div>

    <!-- 주문 상세 내역 -->
    <div class="order-details">
      <p><span>주문일:</span> ${orderDetail.orders.orderDate}</p>
      <p><span>주문 상태:</span> ${orderDetail.orders.orderStatus}</p>
      <p><span>총 금액:</span> ${orderDetail.orders.orderPrice}원</p>
    </div>

    <!-- 상품 목록 -->
    <c:forEach var="item" items="${orderDetail.products}">
      <div class="order-item">
        <img src="${item.prodImgUrl}" alt="상품 이미지">
        <div class="order-item-details">
          <p><span>상품명:</span> ${item.prodName}</p>
          <p><span>옵션:</span> ${item.sizeName} / ${item.colorName}</p>
          <p><span>수량:</span> ${item.orderQty}개</p>
          <p><span>가격:</span> ${item.prodPrice}원</p>
        </div>
      </div>
    </c:forEach>

    <div class="payment-info">결제 정보</div>
    <div class="payment-details">
      <p><span>결제 ID:</span> ${orderDetail.payments.payId}</p>
      <p><span>결제 방법:</span> ${orderDetail.payments.payMethod}</p>
      <p><span>결제 금액:</span> ${orderDetail.payments.payAmount}원</p>
      <p><span>결제일:</span> ${orderDetail.payments.payDate}</p>
      <p><span>결제 상태:</span> ${orderDetail.payments.payType}</p>
      <p><span>환불 여부:</span> ${orderDetail.payments.refund}</p>
    </div>
  </div>

</div>

<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
