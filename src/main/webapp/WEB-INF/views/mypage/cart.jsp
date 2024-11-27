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

    <div class="row m-5">
        <h2>장바구니 (4 개 상품)</h2>
        <p>장바구니에 담긴 상품은 30일동안 보관됩니다.</p>
    </div>
    <hr class="bg-primary border border-1">
    <div class="row mb-3 d-flex align-items-center justify-content-between">
        <div class="col">
            <div class="text-start">
                <input type="checkbox" style="zoom:1.8">
            </div>
        </div>
        <div class="col-auto mn-3">
            <button type="button" class="btn btn-lg">
                <i class="bi bi-trash"></i> 선택 삭제
            </button>
        </div>
        <div class="row">
            <div class="col-12">
                <table class="table align-middle mt-2 md-2">
                    <colgroup>
                        <col width="5%"/>
                        <col width="15%"/>
                        <col width="30%"/>
                        <col width="30%"/>
                        <col width="20%">
                    </colgroup>
                    <tbody>
                    <tr>
                        <td>
                            <input type="checkbox" style="zoom: 1.5"/>
                        </td>
                        <td>
                            <img src="https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/12a2f74f-b392-4ff1-8d15-480de194bd0c/AIR+ZOOM+PEGASUS+41.png" class="rounded mx-auto d-block" width="170">
                        </td>
                        <td>
                            <span>남성 칼데라 7 레몬 (MEDIUM)</span>
                            <p>[레몬/285]</p>
                        </td>
                        <td>
                            <input type="button" value=" - " name="minus">
                            <input type="text" name="stock" value="1" id="stock-\${sizeNo}" size="3" max="" style=" width: 3rem; text-align: center">
                            <input type="button" value=" + " name="plus">
                        </td>
                        <td>
                            <span>169,000 원</span>
                            <button type="button" class="btn btn-lg delete-button" data-target-id="#item-\${sizeNo}"><i class="bi bi-x"></i></button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="checkbox" style="zoom: 1.5"/>
                        </td>
                        <td>
                            <img src="https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/12a2f74f-b392-4ff1-8d15-480de194bd0c/AIR+ZOOM+PEGASUS+41.png" class="rounded mx-auto d-block" width="170">
                        </td>
                        <td>
                            <span>남성 칼데라 7 레몬 (MEDIUM)</span>
                            <p>[레몬/285]</p>
                        </td>
                        <td>
                            <input type="button" value=" - " name="minus">
                            <input type="text" name="stock" value="1"  size="3" max="" style="width: 3rem; text-align: center">
                            <input type="button" value=" + " name="plus">
                        </td>
                        <td>
                            <span>169,000 원</span>
                            <button type="button" class="btn btn-lg delete-button" data-target-id="#item-\${sizeNo}"><i class="bi bi-x"></i></button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="checkbox" style="zoom: 1.5"/>
                        </td>
                        <td>
                            <img src="https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/12a2f74f-b392-4ff1-8d15-480de194bd0c/AIR+ZOOM+PEGASUS+41.png" class="rounded mx-auto d-block" width="170">
                        </td>
                        <td>
                            <span>남성 칼데라 7 레몬 (MEDIUM)</span>
                            <p>[레몬/285]</p>
                        </td>
                        <td>
                            <input type="button" value=" - " name="minus">
                            <input type="text" name="stock" value="1"  size="3" max="" style="width: 3rem; text-align: center">
                            <input type="button" value=" + " name="plus">
                        </td>
                        <td>
                            <span>169,000 원</span>
                            <button type="button" class="btn btn-lg delete-button" data-target-id="#item-\${sizeNo}"><i class="bi bi-x"></i></button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="checkbox" style="zoom: 1.5"/>
                        </td>
                        <td>
                            <img src="https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/12a2f74f-b392-4ff1-8d15-480de194bd0c/AIR+ZOOM+PEGASUS+41.png" class="rounded mx-auto d-block" width="170">
                        </td>
                        <td>
                            <span>남성 칼데라 7 레몬 (MEDIUM)</span>
                            <p>[레몬/285]</p>
                        </td>
                        <td>
                            <input type="button" value=" - " name="minus">
                            <input type="text" name="stock" value="1"  size="3" max="" style="width: 3rem; text-align: center">
                            <input type="button" value=" + " name="plus">
                        </td>
                        <td>
                            <span>169,000 원</span>
                            <button type="button" class="btn btn-lg delete-button" data-target-id="#item-\${sizeNo}"><i class="bi bi-x"></i></button>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!--
            총 금액과 주문하기 버튼
        -->
        <div class="row">
            <div class="col-8">
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
                            <td class="text-end">34,000 원</td>
                        </tr>
                        <tr>
                            <td class="text-start">배송비</td>
                            <td class="text-end">0 원</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td class="text-end text-secondary" style="font-size: 15px;">50,000원 이상 구매 시 무료 배송</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="col-4">
                <div class="bg-light p-4 mb-2">
                    <p><strong class="fs-3">총 결재금액</strong></p>
                    <p><strong class="text-danger fs-2">34,000</strong>원</p>
                </div>
                <div class="d-grid gap-2">
                    <button class="btn btn-dark" type="button">주문하기</button>
                </div>
            </div>
        </div>
    </div>

</div>



<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
