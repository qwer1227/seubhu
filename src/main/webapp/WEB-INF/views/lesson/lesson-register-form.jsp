<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>

<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Chrome, Safari, Edge, Opera */
        input::-webkit-outer-spin-button,
        input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        /* Firefox  */
        input[type='number'] {
            -moz-appearance: textfield;
        }
    </style>
</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl bg-light" id="wrap">
    <form name="form" action="/lesson/form" enctype="multipart/form-data" method="post">
        <div class="row text-center p-3 ">
            <h2>게시글 작성</h2>
        </div>
        <div class="row p-3">
            <div class="col">
                <label for="title">레슨명</label>
                <input type="text" class="form-control" name="title" id="title">
            </div>
        </div>
        <div class="row p-3">
            <div class="col-1">
                <label for="category">과정</label>
                <select name="category" class="form-select" id="category">
                    <option>호흡</option>
                    <option>자세</option>
                    <option>운동</option>
                </select>
            </div>
            <div class="col-2">
                <label for="lecturerName">강사명</label>
                <input type="text" class="form-control" name="lecturerName" id="lecturerName">
            </div>
            <div class="col-2">
                <label for="price">가격</label>
                <input type="number" class="form-control" name="price" id="price">
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
        <div class="row p-3">
            <div class="col-3">
                <label for="startDate">시작 시간</label>
                <input type="datetime-local" class="form-control" name="startDate" id="startDate">
            </div>
            <div class="col-3">
                <label for="endDate">종료 시간</label>
                <input type="datetime-local" class="form-control" name="endDate" id="endDate">
            </div>
        </div>
        <div class="row p-3 ">
            <div class="col-5">
                <label for="thumbnail">썸네일 이미지</label>
                <input type="file" class="form-control" name="thumbnail" id="thumbnail"/>
            </div>
        </div>
        <div class="row p-3 ">
            <div class="col-5">
                <label for="mainImage">본문 이미지</label>
                <input type="file" class="form-control" name="mainImage" id="mainImage"/>
            </div>
        </div>
        <div class="row p-3">
            <div class="col d-flex justify-content-end">
                <a href="/lesson" class="btn btn-secondary m-1">취소</a>
                <button type="submit" class="btn btn-primary m-1">등록</button>
            </div>
        </div>
    </form>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>