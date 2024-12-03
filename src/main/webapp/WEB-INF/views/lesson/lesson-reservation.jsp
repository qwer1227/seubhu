<%@ page import="static store.seub2hu2.lesson.enums.LessonCategory.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<security:authentication property="principal" var="loginUser"/>
<div class="container-xxl" id="wrap">
    <div class="row text-center mb-3">
        <div class="col">
            <h2>레슨 예약 내역</h2>
        </div>
    </div>
    <form form="condition" method="get" action="/lesson/reservation">
        <input type="hidden" name="userId" value="${loginUser.id}">
        <div class="row mb-3">
            <div class="col-1">
                <label for="subject">과목</label>
                <select name="lessonSubject" class="form-select" id="subject">
                    <option>모두</option>
                    <option>호흡</option>
                    <option>자세</option>
                    <option>운동</option>
                </select>
            </div>
            <div class="col-1">
                <label for="status">예약상태</label>
                <select name="lessonStatus" class="form-select" id="status">
                    <option>모두</option>
                    <option>예약</option>
                    <option>수료</option>
                    <option>취소</option>
                </select>
            </div>
            <div class="col-2">
                <label for="startDate">시작</label>
                <input type="date" id='startDate' name="start" class="form-select">
            </div>
            <div class="col-2">
                <label for="endDate">종료</label>
                <input type="date" id="endDate" name="end" class="form-select">
            </div>
            <div class="col text-end">
                <label for="searchCondition">검색조건</label>
                <select name="searchCondition" id="searchCondition" class="form-select">
                    <option>강사명</option>
                    <option>레슨명</option>
                    <option>과목</option>
                </select>
            </div>
            <div class="col pt-4">
                <input type="text" class="form-control border" name="searchKeyword"/>
            </div>
            <div class="col-1 pt-4">
                <label for="search"> </label>
                <button type="submit" class="btn btn-primary" id="search">검색</button>
            </div>
        </div>
    </form>
    <div class="row">
        <table class="table">
            <colgroup>
                <col width="15%">
                <col width="*">
                <col width="10%">
                <col width="10%">
                <col width="10%">
                <col width="10%">
                <col width="10%">
            </colgroup>
            <tr>
                <th>번호</th>
                <th>레슨명</th>
                <th>강사명</th>
                <th>가격</th>
                <th>상태</th>
                <th>예약날짜</th>
                <th>예약상태</th>
                <th></th>
            </tr>
            <c:forEach var="reservation" items="${lessonReservations}" varStatus="loop">
                <tr>
                    <td>${reservation.no}</td>
                    <td><a href="/lesson/reservation/detail?reservationNo=${reservation.no}"
                           style="text-decoration:none">${reservation.lesson.title}</a></td>
                    <td>${reservation.lesson.lecturer.name}</td>
                    <td><fmt:formatNumber value="${reservation.lesson.price}" pattern="#,###"/></td>
                    <td>${reservation.lesson.status}</td>
                    <fmt:parseDate value="${reservation.reservationCreatedDate }" pattern="yyyy-MM-dd'T'HH:mm"
                                   var="parsedDateTime" type="both"/>
                    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${ parsedDateTime }"/></td>
                    <td>
                        <c:if test="${reservation.status eq '예약'}">
                            <span class="badge bg-success">예약</span>
                        </c:if>
                        <c:if test="${reservation.status eq '취소'}">
                            <span class="badge bg-danger">취소</span>
                        </c:if>
                        <c:if test="${reservation.status eq '환불'}">
                            <span class="badge bg-warning">환불</span>
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${not empty reservation.status and
                             reservation.status ne '취소' and
                             reservation.status ne '환불'}">
                            <form action="/pay/cancel" name="paymentDto" method="POST" style="display: inline;">
                                <input type="hidden" name="paymentId" value="${reservation.payment.id}">
                                    <input type="hidden" name="userId" value="${loginUser.id}">
                                <input type="hidden" name="lessonNo" value="${reservation.lesson.lessonNo}">
                                <input type="hidden" name="totalAmount" value="${reservation.lesson.price}">
                                <button type="submit" id=cancel-btn class="btn btn-sm btn-danger"
                                        onclick="confirmCancel()">취소
                                </button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
<script>
    function confirmCancel() {
        // 사용자에게 취소 확인 메시지 표시
        var confirmResult = confirm("예약을 취소하시겠습니까?");

        // 사용자가 '확인'을 클릭하면 폼을 제출
        if (confirmResult) {
            return true;  // 폼 제출
        } else {
            return false;  // 폼 제출 안 함
        }
    }
</script>
</body>
</html>
