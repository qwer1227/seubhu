<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp"%>
</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp"%>
<div class="container-xxl bg-light" id="wrap">
    <div class="row text-center p-3 ">
        <h2>게시글 작성</h2>
    </div>
    <div class="row p-3">
        <div class="col-1">
            글제목
        </div>
        <div class="col">
            <input type="text" class="form-control">
        </div>
    </div>
    <div class="row p-3">
        <div class="col-1">
            카테고리
        </div>
        <div class="col">
            <select>
                <option>레슨</option>
                <option>운동</option>
                <option>코스</option>
            </select>
            <select>
                <option>레슨</option>
                <option>운동</option>
                <option>코스</option>
            </select>
        </div>
    </div>
    <div class="row row-cols-1 p-3">
        <div class="col-1 pb-3">
            게시글
        </div>
        <div class="col">
            <textarea class="form-control" rows="20"></textarea>
        </div>
    </div>
    <div class="row p-3 ">
        <div class="col-1">
            첨부파일
        </div>
        <div class="col-5">
            <input type="file" class="form-control" name="upfile" />
        </div>
    </div>
    <div class="row p-3">
        <div class="col d-flex justify-content-end">
            <button type="submit" class="btn btn-secondary m-1">취소</button>
            <button type="submit" class="btn btn-primary m-1">등록</button>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>