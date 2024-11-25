<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">
    <div>
        <h2>주문결제</h2>
    </div>
    <hr class="bg-primary border border-1">

    <div class="row mb-3">
        <div class="col">
            <table class="table align-middle mt-2 md-2">
                <colgroup>
                    <col width="5%"/>
                    <col width="80%"/>
                    <col width="15%">
                </colgroup>
                <thead class="table-secondary">
                    <tr class="text-start">
                        <th colspan="3">주문상품</th>
                    </tr>
                </thead>
                <tbody>
                <tr>
                    <td>
                        <img src="https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/12a2f74f-b392-4ff1-8d15-480de194bd0c/AIR+ZOOM+PEGASUS+41.png" class="rounded mx-auto d-block" width="90">
                    </td>
                    <td>
                        <span>남성 칼데라 7 레몬 (MEDIUM)</span>
                        <p class="text-secondary">[레몬/285] / 1 개</p>

                    </td>
                    <td class="text-end">
                        <span>169,000 원</span>
                        <button type="button" class="btn btn-lg delete-button" data-target-id="#item-\${sizeNo}"><i class="bi bi-x"></i></button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!--
        배송지 정보
    -->
    <div class="row mb-3">
        <div class="col">
            <table class="table align-middle mt-2 md-2">
                <thead class="table-secondary">
                <tr class="text-start">
                    <th colspan="3">배송지 정보</th>
                </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>받으실 분 <input type="text"></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <!--
        쿠폰 적립금
    -->
    <div class="row mb-3">
        <div class="col">
            <table class="table align-middle mt-2 md-2">
                <colgroup>
                    <col width="5%"/>
                    <col width="50%"/>
                    <col width="45%">
                </colgroup>
                <thead class="table-secondary">
                <tr class="text-start">
                    <th colspan="3">쿠폰 적립금</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!--
    결제 정보
    -->
    <div class="row mb-3">
        <div class="col">
            <table class="table align-middle mt-2 md-2">
                <colgroup>
                    <col width="5%"/>
                    <col width="50%"/>
                    <col width="45%">
                </colgroup>
                <thead class="table-secondary">
                <tr class="text-start">
                    <th colspan="3">결제 정보</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <hr class="bg-dark border-dark border-4">
    <div class="row">
        <div class="col">
            <table class="table table-borderless">
                <colgroup>
                    <col width="50%">
                    <col width="50%">
                </colgroup>
                <thead class="table-secondary">
                <tr class="text-start">
                    <th colspan="2">주문예정 금액</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td class="text-start">상품금액</td>
                    <td class="text-end">169,000 원</td>
                </tr>
                <tr>
                    <td class="text-start">배송비</td>
                    <td class="text-end">0 원</td>
                </tr>
                <tr>
                    <td class="text-start">총 할인금액</td>
                    <td class="text-end">0 원</td>
                </tr>
                <tr>
                    <td class="text-start">
                        <strong>총결제 금액</strong>
                    </td>
                    <td class="text-end">
                        <strong class="text-danger fs-4">169,000 원</strong>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="d-grid gap-2">
                <button class="btn btn-dark" type="button">결제하기</button>
            </div>
        </div>

</div>

<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
