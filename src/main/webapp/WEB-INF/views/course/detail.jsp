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
    <%-- 코스 상세 정보 --%>
    <%-- 요청 파라미터 정보 : no --%>
    <div class="row">
        <div class="col-5">
            <table class="table table-bordered">
                <div class="card">
                    <div class="card-header">${course.name}</div>
                </div>
                <tbody>
                    <tr>
                        <th scope="row">코스 지역</th>
                        <td>${course.region.si} ${course.region.gu} ${course.region.dong}</td>
                    </tr>
                    <tr>
                        <th scope="row">코스 거리</th>
                        <td>${course.distance}KM</td>
                    </tr>
                    <tr>
                        <th scope="row">평균 완주 시간</th>
                        <td>${course.time}분</td>
                    </tr>
                    <tr>
                        <th scope="row">코스 난이도</th>
                        <td>${course.level}단계</td>
                    </tr>
                </tbody>
            </table>
            <button type="button" class="btn btn-primary">
                <i class="bi bi-hand-thumbs-up"></i> 좋아요!
            </button>
            <span>좋아요 수 : ${course.likeCnt}개</span>
        </div>
        <div class="col-1"></div> <%-- 빈칸 --%>
        <div class="col-6">
            <div class="card">
                <div class="card-body">
                    <div class="row mb-1">
                        <div class="col">
                            <img src="/resources/images/course/${course.filename}" class="img-thumbnail">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="card mt-5" id="review">
        <div class="card-header">
            <span>코스 리뷰</span>
            <button class="text-end">리뷰 작성</button>
        </div>
        <div class="card-body">

        </div>
    </div>
</div>

<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>