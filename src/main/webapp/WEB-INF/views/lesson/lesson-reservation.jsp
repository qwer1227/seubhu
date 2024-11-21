<%@ page import="static store.seub2hu2.lesson.enums.LessonCategory.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/locales/bootstrap-datepicker.ko.min.js"
            integrity="sha512-L4qpL1ZotXZLLe8Oo0ZyHrj/SweV7CieswUODAAPN/tnqN3PA1P+4qPu5vIryNor6HQ5o22NujIcAZIfyVXwbQ=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <style>
        .datepicker td, .datepicker th {
            width: 2.5rem;
            height: 2.5rem;
            font-size: 0.85rem;
        }

        body {
            background-color: #fafafa;
        }
    </style>
</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl" id="wrap">
    <div class="row text-center mb-3">
        <div class="col">
            <h2>레슨 예약 내역</h2>
        </div>
    </div>
    <form form="condition" method="get" action="/lesson/reservation">
        <input type="hidden" name="userNo" value="11">
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
                <input type="date" id='startDate' name="startDate" class="form-select">
            </div>
            <div class="col-2">
                <label for="endDate">종료</label>
                <input type="date" id="endDate" name="startDate" class="form-select">
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
                <col width="15%">
                <col width="15%">
                <col width="15%">
                <col width="15%">
            </colgroup>
            <tr>
                <th>번호</th>
                <th>레슨명</th>
                <th>강사명</th>
                <th>가격</th>
                <th>상태</th>
                <th>예약날짜</th>
            </tr>
            <c:forEach var="reservation" items="${lessons}" varStatus="loop">
                <tr>
                    <td>${reservation.no}</td>
                    <td><a href="/lesson/detail?lessonNo=${reservation.lesson.lessonNo}"
                           style="text-decoration:none">${reservation.lesson.title}</a></td>
                    <td>${reservation.lesson.lecturer.name}</td>
                    <td><fmt:formatNumber value="${reservation.lesson.price}" pattern="#,###"/></td>
                    <td>${reservation.lesson.status}</td>
                    <td><fmt:formatDate value="${reservation.reservationCreatedDate}" pattern="yyyy-MM-dd"/></td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
<script>
    $(function () {
        $('.datepicker').datepicker({
            clearBtn: true,
            format: "dd/mm/yyyy"
        });

        $('#reservationDate').on('change', function () {
            var pickedDate = $('input').val();
            $('#pickedDate').html(pickedDate);
        });
    });
</script>
</body>
</html>
