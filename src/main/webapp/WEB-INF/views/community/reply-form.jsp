<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="ko">
<div class="comment-form mb-4">
  <h5 style="text-align: start">댓글 작성</h5>
  <form method="post" action="add-reply">
    <input type="hidden" name="userNo" value="${loginUser.no}">
    <input type="hidden" name="type" value="board">
    <input type="hidden" name="typeNo" value="${board.no}">
    <div class="row">
      <c:choose>
        <c:when test="${empty loginUser}">
          <div class="form-group col-11">
            <input class="form-control" disabled placeholder="로그인 후 댓글 작성이 가능합니다."/>
          </div>
          <div class="col" style="text-align: end">
            <button type="button" class="btn btn-outline-success" style="width: 85px" onclick="goLogin()">등록
            </button>
          </div>
        </c:when>
        <c:otherwise>
          <div class="form-group col-11">
            <textarea name="content" class="form-control" rows="3" placeholder="댓글을 작성하세요."></textarea>
          </div>
          <div class="col" style="text-align: end">
            <button type="submit" id="add" class="btn btn-success" style="width: 85px" onclick="submitReply()">등록</button>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </form>
</div>

<script>
  function goLogin() {
    let result = confirm("로그인하시겠습니까?");
    if (result) {
      window.location.href = "/login";
    }
  }
  
  /* 댓글 제출(/community/add-reply로 데이터 전달) */
  document.querySelector("#add").addEventListener("click", function () {
    let type = document.querySelector("input[name=type]").value;
    let typeNo = document.querySelector("input[name=no]").value;
    let content = document.querySelector("textarea[name=content]").value;
    let userNo = document.querySelector("input[name=userNo]").value;
    
    fromData.append(("type"), type);
    fromData.append(("typeNo"), typeNo);
    fromData.append(("content"), content);
    fromData.append(("userNo"), userNo);
    
    $.ajax({
      method: "post",
      url: "add-reply",
      data: formData,
      processData: false,
      contentType: false,
      success: function () {
        window.location.href = returnUrl; // 성공 시 리다이렉트
      }
    })
  });
</script>
</html>