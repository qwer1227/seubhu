<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>

<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl bg-light" id="wrap">
    <form name="form" action="/lesson/form" enctype="multipart/form-data" method="post">
        <div class="row text-center p-3 ">
            <h2>게시글 작성</h2>
        </div>
        <div class="row p-3">
            <div class="col-1">
                글제목
            </div>
            <div class="col">
                <input type="text" class="form-control" name="title">
            </div>
        </div>
        <div class="row p-3">
            <div class="col-1">
                카테고리
            </div>
            <div class="col">
                <select name="category">
                    <option>호흡</option>
                    <option>자세</option>
                    <option>운동</option>
                </select>
            </div>
        </div>
        <div class="row p-3">
            <div class="col-1">
                강사
            </div>
            <div class="col-2">
                <input type="text" class="form-control" name="lecturerName">
            </div>
            <div class="col-1">
                가격
            </div>
            <div class="col-2">
                <input type="number" class="form-control" name="price">
            </div>
        </div>
        <div class="row row-cols-1 p-3">
            <div class="col-1 pb-3">
                게시글
            </div>
            <div class="col">
                <textarea class="form-control" rows="20" name="plan"></textarea>
            </div>
        </div>
        <div class="row">
            <div class="col-2">
                레슨 날짜
                <input type="date" class="form-control" name="date">
            </div>
        </div>
        <div class="row p-3 ">
            <div class="col-1">
                썸네일 이미지
            </div>
            <div class="col-5">
                <input type="file" class="form-control" name="thumbnail"/>
            </div>
        </div>
        <div class="row p-3 ">
            <div class="col-1">
                본문 이미지
            </div>
            <div class="col-5">
                <input type="file" class="form-control" name="mainImage" />
            </div>
        </div>
        <div class="row p-3">
            <div class="col d-flex justify-content-end">
                <button type="submit" class="btn btn-secondary m-1">취소</button>
                <button type="submit" class="btn btn-primary m-1">등록</button>
            </div>
        </div>
    </form>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>