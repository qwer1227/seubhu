<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>

    <style>
        /* 폼의 너비를 제한하고, 중앙 정렬 */
        .form-container {
            max-width: 600px; /* 최대 너비 설정 */
            margin: 0 auto; /* 중앙 정렬 */
        }
    </style>
</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">
    <h2>내 정보 수정</h2>

    <div class="form-container">
    <form action="/mypage/edit" method="post" class="form-group">
        <!-- 이름 -->
        <div class="mb-3">
            <label for="name" class="form-label">이름</label>
            <input type="text" id="name" name="name" class="form-control" value="${user.name}" required>
        </div>

        <!-- 비밀번호 -->
        <div class="mb-3">
            <label for="password" class="form-label">비밀번호</label>
            <input type="password" id="password" name="password" class="form-control" placeholder="새 비밀번호" required>
        </div>

        <!-- 재 입력 -->
        <div class="mb-3">
            <label for="password" class="form-label">비밀번호 확인</label>
            <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="새 비밀번호" required>
        </div>

        <!-- 닉네임 -->
        <div class="mb-3">
            <label for="nickname" class="form-label">닉네임</label>
            <input type="text" id="nickname" name="nickname" class="form-control" value="${user.nickname}" required>
        </div>

        <!-- 전화번호 -->
        <div class="mb-3">
            <label for="phone" class="form-label">전화번호</label>
            <input type="text" id="phone" name="phone" class="form-control" value="${user.phone}" required>
        </div>

        <!-- 이메일 -->
        <div class="mb-3">
            <label for="email" class="form-label">이메일</label>
            <input type="email" id="email" name="email" class="form-control" value="${user.email}" required>
        </div>

        <!-- 수정 버튼 -->
        <button type="submit" class="btn btn-primary">수정하기</button>
    </form>
</div>
</div>

<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
