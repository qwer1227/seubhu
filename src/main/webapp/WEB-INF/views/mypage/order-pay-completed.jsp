<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <style>
        .table th, .table td {
            border: none;
        }
    </style>

    <%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">

    <div class="row mb-3">
        <div>
            <h1>주문이 완료되었습니다.</h1>
        </div>
        <div>
            <h3>주문 번호: 20241205-0080000</h3>
        </div>
    </div>
    <div class="row mb-3">
        <div class="col">
            <table class="table align-middle mt-2 md-2">
                <colgroup>
                    <col width="50%"/>
                    <col width="55%">
                </colgroup>
                <thead class="table-secondary">
                <tr class="text-start">
                    <th colspan="3">주문상품 정보</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <th><label>주문 상품</label></th>
                    <td>${orderDetail.product.prodName} 블랙 260 외 2개</td>
                </tr>
                <tr>
                    <th><label>주문 수량</label></th>
                    <td>5개</td>
                </tr>
                </tbody>
            </table>
            <table class="table align-middle mt-2 md-2">
                <colgroup>
                    <col width="50%"/>
                    <col width="55%">
                </colgroup>
                <thead class="table-secondary">
                <tr class="text-start">
                    <th colspan="3">배송지 정보</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <th><label>받으시는 분</label></th>
                    <td>홍길동</td>
                </tr>
                <tr>
                    <th><label>우편번호</label></th>
                    <td>07776</td>
                </tr>
                <tr>
                    <th><label>배송지</label></th>
                    <td>서울시 영등포구 여의대로 6길 17 A동 1202호</td>
                </tr>
                <tr>
                    <th><label>휴대폰 번호</label></th>
                    <td>010-1234-5678</td>
                </tr>
                </tbody>
            </table>
            <table class="table align-middle mt-2 md-2">
                <colgroup>
                    <col width="50%"/>
                    <col width="55%">
                </colgroup>
                <thead class="table-secondary">
                <tr class="text-start">
                    <th colspan="3">결제 정보</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <th><label>결제 수단</label></th>
                    <td>카카오페이</td>
                </tr>
                <tr>
                    <th><label>결제 금액</label></th>
                    <td>169,000</td>
                </tr>
                </tbody>
            </table>
            <table class="table align-middle mt-2 md-2">
                <colgroup>
                    <col width="50%"/>
                    <col width="55%">
                </colgroup>
                <thead class="table-secondary">
                <tr class="text-start">
                    <th colspan="3">배송 정보</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <th><label>배송 상태</label></th>
                    <td>상품 준비중</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>


<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
