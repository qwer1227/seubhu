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
                <colgroup>
                    <col width="20%"/>
                    <col width="50%"/>
                    <col width="25%">
                </colgroup>
                <tbody>
                    <tr>
                        <th><a href="#" class="text-secondary">최신 배송지</a></th>
                        <th><a href="#" class="text-secondary">신규 입력</a></th>
                    </tr>
                    <tr>
                        <th>받으실 분</th>
                        <td>
                            <input type="text" class="form-control me-2" placeholder="이름을 입력하세요" required>
                        </td>
                    </tr>
                    <tr>
                        <th>주소</th>
                        <td>
                            <div class="d-flex align-items-center mb-2">
                                <input type="text" class="form-control me-2" id="postcode" placeholder="우편번호" required readonly>
                                <input type="button" onclick="openPostcode()" class="btn btn-secondary" value="우편번호검색">
                            </div>
                                <input type="text" id="address" class="form-control mb-2" placeholder="기본주소"/>
                                <input type="text" id="address-detail" class="form-control mb-2" placeholder="나머지 주소(선택입력 가능)"/>
                                <input type="text" id="address-extra" class="form-control mb-2" placeholder="참고항목"/>

                        </td>
                    </tr>
                    <tr>
                        <th><label>휴대폰 번호</label></th>
                        <td>
                            <div class="d-flex">
                                <input type="text" class="form-control">
                                <input type="text" class="form-control">
                                <input type="text" class="form-control">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th><label>이메일</label></th>
                        <td>
                            <div class="d-flex">
                                <input type="email" class="form-control"> @
                                <input type="email" class="form-control">
                                <select class="form-control" name="email">
                                    <option>선택하세요</option>
                                    <option>직접입력</option>
                                    <option>gmail.com</option>
                                    <option>naver.com</option>
                                    <option>hanmail.net</option>
                                </select>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th><label>배송 메모</label></th>
                        <td>
                            <input type="text" class="form-control">
                        </td>
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
                    <tr>
                        <th><label>쿠폰</label></th>
                        <td>
                            <input type="text" class="form-control mb-3">
                        </td>
                    </tr>
                    <tr>
                        <th><label>적립금</label></th>
                        <td>
                            <div class="d-flex align-items-center mb-3">
                                <input type="text" class="form-control me-2"/>
                                <input type="button" class="btn btn-secondary" value="모두 사용">
                            </div>
                        </td>
                    </tr>
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
                <thead class="table-secondary">
                <tr class="text-start">
                    <th colspan="12">결제 정보</th>
                </tr>
                </thead>
                <tbody>
                    <tr>
                        <th><label>결제 수단</label></th>
                        <td><input type="radio"><img src="https://ecimg.cafe24img.com/pg90b05313110010/brooksrunning/web/upload/icon_202210121023113100.png" /></td>
                        <td><input type="radio" checked><img src="https://ecimg.cafe24img.com/pg90b05313110010/brooksrunning/web/upload/icon_202210121022402200.png"/></td>
                        <td><input type="radio"><img src="https://img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_payco_disabled.gif" /></td>
                        <td><input type="radio"><img src="https://img.echosting.cafe24.com/skin/admin_ko_KR/order/admin_naverpay_disabled.gif" /></td>
                    </tr>
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
    <script>

        // 카카오 주소 api
        function openPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var addr = ''; // 주소 변수
                    var extraAddr = ''; // 참고항목 변수

                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }

                    // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                    if(data.userSelectedType === 'R'){
                        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                            extraAddr += data.bname;
                        }
                        // 건물명이 있고, 공동주택일 경우 추가한다.
                        if(data.buildingName !== '' && data.apartment === 'Y'){
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                        if(extraAddr !== ''){
                            extraAddr = ' (' + extraAddr + ')';
                        }
                        // 조합된 참고항목을 해당 필드에 넣는다.
                        document.getElementById("address-extra").value = extraAddr;

                    } else {
                        document.getElementById("address-extra").value = '';
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('postcode').value = data.zonecode;
                    document.getElementById("address").value = addr;
                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById("address-detail").focus();
                }
            }).open();
        }
    </script>

<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
