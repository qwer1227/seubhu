<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="ko">
<head>
</head>
<body>
<!-- 댓글 작성 -->
<div class="comment-form mb-4">
  <h5 style="text-align: start">댓글 작성</h5>
  <form name="form-reply" method="get" action="add-reply">
    <input type="hidden" name="boardNo" value="">
    <input type="hidden" name="crewNo" value="">
    <input type="hidden" name="userNo" value="${loginUser.no}">
    <div class="row">
      <c:choose>
        <c:when test="${empty loginUser}">
          <div class="form-group col-11">
            <input class="form-control" disabled placeholder="로그인 후 댓글 작성이 가능합니다."/>
          </div>
          <div class="col">
            <button type="button" class="btn btn-outline-success" onclick="goLogin()">등록</button>
          </div>
        </c:when>
        <c:otherwise>
          <div class="form-group col-11">
            <textarea name="content" class="form-control" rows="3" placeholder="댓글을 작성하세요."></textarea>
          </div>
          <div class="col">
            <button type="submit" class="btn btn-success" onclick="submitReply()">등록</button>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </form>
</div>
</body>
</html>