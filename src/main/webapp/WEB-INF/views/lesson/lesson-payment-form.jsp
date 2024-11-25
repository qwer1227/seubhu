<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<body>
<div class="container-xxl border align-content-center" id="wrap">
    <div class="row text-center mb-5">
        <h1>레슨 예약</h1>
    </div>
    <div class="row d-flex justify-content-center mb-3">
        <div class="col-5 border border-dark">
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
                    <td><a href="/lesson/detail?lessonNo=${lessonDto.lessonNo}">${lessonDto.title}</td>
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
                        ${lessonDto.startDate} ${lessonDto.startTime}
                    </td>
                </tr>
                <tr>
                    <th>결제금액</th>
                    <td><fmt:formatNumber value="${lessonDto.price}" pattern="#,###"/></td>
                </tr>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-1"></div>
        <div class="col">
            <button type="button" id="btn-pay-ready" class="btn btn-dark w-100">결제하기</button>
        </div>
        <div class="col-1"></div>
    </div>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>

<script type="text/javascript">
    $(function () {
        $("#btn-pay-ready").click(function (e) {
            let data = {
                lessonNo: ${lessonDto.lessonNo},
                title: '${lessonDto.title}',    // 카카오페이에 보낼 대표 상품명
                price: ${lessonDto.price},
                quantity: 1, // 총 개수
                userNo: ${lessonDto.userNo}
            };

            $.ajax({
                type: 'POST',
                url: '/order/pay/ready',
                data: JSON.stringify(data),
                contentType: 'application/json',
                success: function (response) {
                    // 팝업 크기 설정
                    let popupWidth = 600;
                    let popupHeight = 800;

                    // 화면 크기 기준 중앙 위치 계산
                    let screenWidth = window.innerWidth || document.documentElement.clientWidth || screen.width;
                    let screenHeight = window.innerHeight || document.documentElement.clientHeight || screen.height;
                    let left = (screenWidth - popupWidth) / 2 + window.screenX;
                    let top = (screenHeight - popupHeight) / 2 + window.screenY;

                    // 팝업창 열기
                    let popup = window.open(
                        response.next_redirect_pc_url, // 카카오페이에서 반환된 URL
                        'KakaoPayPopup',
                        `width=${popupWidth},height=${popupHeight},left=${left},top=${top},resizable=no,scrollbars=yes`
                    );

                    // 팝업 열기 실패 시 경고
                    if (!popup || popup.closed || typeof popup.closed === 'undefined') {
                        alert('팝업이 차단되었습니다. 브라우저 설정을 확인해주세요.');
                    }
                },
                error: function (xhr, status, error) {
                    alert('결제 준비 중 문제가 발생했습니다: ' + error);
                }
            });
        });
    });
</script>


</body>
</html>