<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
  <%@include file="/WEB-INF/common/common.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">
  
  <h2> 공지사항 글 상세 </h2>
  
  <div>
    <div class="col d-flex justify-content-left">
      <div>
        <a href="" style="text-decoration-line: none">공지사항</a>
      </div>
    </div>
    <div class="title h4 d-flex justify-content-between align-items-center">
      <div>
        게시글 제목
      </div>
      <div class="ml-auto">
        2024-11-11
      </div>
    </div>
    <div class="meta d-flex justify-content-between mb-3">
      <span>작성자 이름</span>
      <span><i class="bi bi-eye"></i> 100  <i class="bi bi-hand-thumbs-up"></i> 10</span>
    </div>
    
    <div class="content mb-4">
      <p>여기에 본문 내용이 들어갑니다. 본문은 여러 줄로 작성할 수 있으며, 원하는 만큼 길게 작성할 수 있습니다.</p>
    </div>
    
    <div class="actions d-flex justify-content-between mb-4">
      <div>
        <!-- 관리자만 볼 수 있는 버튼 -->
        <button class="btn btn-warning">수정</button>
        <button class="btn btn-danger">삭제</button>
      </div>
      <div>
        <button class="btn btn-outline-dark">
          <i class="bi bi-hand-thumbs-up"></i>
          <i class="bi bi-hand-thumbs-up-fill"></i>
        </button>
        <a type="button" href="main" class="btn btn-secondary">목록</a>
      </div>
    </div>
</div>
<%@include file="/WEB-INF/common/footer.jsp" %>
</body>
</html>