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

        .inquiry-detail {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        .inquiry-detail h3 {
            margin: 0 0 15px;
            font-size: 24px;
            color: #333;
        }

        .inquiry-detail p {
            color: #666;
            line-height: 1.5;
        }

        .btn-back {
            background-color: #3498db;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/nav.jsp" %>
<div id="wrap">

    <!-- Header -->
    <div class="inquiry-header">
        <h2>문의 상세보기</h2>
    </div>

    <!-- Inquiry Detail -->
    <div class="inquiry-detail">
        <h3>${qna.qnaTitle}</h3>
        <p>${qna.qnaContent}</p>
        <p><strong>작성일:</strong> ${qna.qnaCreatedDate}</p>
        <p><strong>문의 상태:</strong> ${qna.qnaStatus}</p>
        <p><strong>카테고리:</strong> ${qna.qnaCategory.categoryName}</p>
    </div>

    <!-- Back Button -->
    <a href="/qna" class="btn-back">목록으로 돌아가기</a>

</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>