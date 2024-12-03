<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/common.jsp" %>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        #wrap {
            width: 90%;
            max-width: 1200px;
            margin: 30px auto;
        }

        .inquiry-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .category-tabs {
            display: flex;
            gap: 15px;
        }

        .category-tab {
            padding: 10px 20px;
            background-color: #f0f0f0;
            border-radius: 5px;
            text-decoration: none;
            color: #333;
            font-weight: bold;
            cursor: pointer;
        }

        .category-tab.active {
            background-color: #3498db;
            color: white;
        }

        .inquiry-list {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        .inquiry-item {
            padding: 15px 0;
            border-bottom: 1px solid #e0e0e0;
        }

        .inquiry-item:last-child {
            border-bottom: none;
        }

        .inquiry-item h4 {
            margin: 0 0 5px;
            font-size: 18px;
            color: #333;
        }

        .inquiry-item p {
            margin: 0;
            color: #666;
        }

        .no-inquiry {
            text-align: center;
            color: #888;
            padding: 20px 0;
        }

        .btn-detail {
            background-color: #3498db;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            cursor: pointer;
        }

        .btn-create {
            background-color: #27ae60;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            margin-top: 20px;
            display: block;
            width: fit-content;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/nav.jsp" %>
<div id="wrap">

    <!-- Header -->
    <div class="inquiry-header">
        <h2>문의 내역</h2>
        <div class="category-tabs">
            <a href="?category=all" class="category-tab active">전체</a>
            <a href="?category=rent" class="category-tab">대여</a>
            <a href="?category=order" class="category-tab">주문</a>
            <a href="?category=lesson" class="category-tab">레슨</a>
            <a href="?category=suggestion" class="category-tab">건의</a>
        </div>
    </div>

    <!-- Inquiry List -->
    <div class="inquiry-list">
        <c:if test="${empty qna}">
            <div class="no-inquiry">등록된 문의가 없습니다.</div>
        </c:if>
        <c:forEach var="qna" items="${qna}">
            <div class="inquiry-item">
                <h4>${qna.qnaTitle}</h4>
                <p>${qna.qnaContent}</p>
                <c:choose>
                    <c:when test="${qna.qnaUpdatedDate != null}">
                        <p><small><fmt:formatDate value="${qna.qnaUpdatedDate}" pattern="yyyy-MM-dd" timeZone="Asia/Seoul" /></small></p>
                    </c:when>
                    <c:otherwise>
                        <p><small><fmt:formatDate value="${qna.qnaCreatedDate}" pattern="yyyy-MM-dd" timeZone="Asia/Seoul" /></small></p>
                    </c:otherwise>
                </c:choose>
                <br>
                <a href="qna/detail/${qna.qnaNo}" class="btn-detail">상세보기</a>
            </div>
        </c:forEach>
    </div>

    <!-- 문의 작성 버튼 -->
    <a href="/mypage/qna/create" class="btn-create">문의 작성</a>

</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
