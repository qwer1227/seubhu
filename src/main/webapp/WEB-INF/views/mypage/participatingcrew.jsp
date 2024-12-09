<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .crew-container {
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 20px;
            margin-top: 20px;
            background-color: #f9f9f9;
        }
        .crew-image {
            width: 100%;
            max-width: 150px;
            height: auto;
            border-radius: 5px;
            margin: 0 auto;
        }
        .crew-title {
            background-color: #dcdcdc;
            padding: 10px;
            margin-bottom: 20px;
            font-weight: bold;
        }
        .delete-btn {
            font-size: 14px;
            color: #fff;
            background-color: #dc3545;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
        }
        .delete-btn:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>

<div class="container" id="wrap">
    <div class="text-center crew-title">
        참여크루
    </div>

    <c:forEach var="c" items="${crews}">
    <div class="crew-container row align-items-center">
        <!-- 왼쪽 이미지 -->
        <div class="col-md-3 text-center">
            <img src="images/community/${c.uploadFile.saveName}" alt="크루 이미지" class="crew-image">
        </div>
        <!-- 오른쪽 정보 -->
        <div class="col-md-9">
            <div class="d-flex justify-content-between mb-3">
                <h5 class="fw-bold">${c.name}</h5>
                <span>${c.memberCnt}</span>
            </div>
            <div class="d-flex justify-content-between align-items-center">
                <p class="mb-0">${c.description}</p>
                <!-- 삭제 버튼 추가 -->
                <button class="delete-btn" onclick="deleteCrew()">삭제</button>
            </div>
        </div>
    </div>
    </c:forEach>

</div>

<%@include file="/WEB-INF/views/common/footer.jsp" %>

<script>
    function deleteCrew() {
        if (confirm('정말로 크루를 삭제하시겠습니까?')) {
            alert('크루가 삭제되었습니다.');
            // 삭제 요청 로직 추가 (예: AJAX 요청)
        }
    }
</script>
</body>
</html>
