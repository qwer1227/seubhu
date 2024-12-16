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
          <div class="form-group col-11 border rounded">
            <textarea name="content" class="form-control auto-resize" rows="3" placeholder="댓글을 작성하세요."></textarea>
          </div>
          <div class="col" style="text-align: end">
            <button type="button" id="add" class="btn btn-success" style="width: 85px" onclick="submitReply()">등록</button>
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
  async function submitReply() {
    let type = document.querySelector("input[name=type]").value;
    let boardNo = document.querySelector("input[name=typeNo]").value;
    let content = document.querySelector("textarea[name=content]").value.trim();
    let userNo = document.querySelector("input[name=userNo]").value;
    
    if (content === "") {
      alert("댓글 내용을 입력해주세요.");
      return;
    }
    
    let data = {
      type,
      boardNo,
      content,
      userNo
    }
    
    // 자바스크립트 객체를 json형식의 텍스트로 변환한다.
    let jsonText = JSON.stringify(data);
    
    // POST 방식으로 객체를 JSON 형식의 데이터를 서버로 보내기
    let response = await fetch("/community/board/add-reply", {
      // 요청방식을 지정한다.
      method: "POST",
      // 요청메세지의 바디부에 포함된 컨텐츠의 형식을 지정한다.
      headers: {
        "Content-Type": "application/json"
      },
      // 요청메세지의 바디부에 서버로 전달할 json형식의 텍스트 데이터를 포함시킨다.
      body: jsonText
    });
    // 서버가 보낸 응답데이터를 받는다.
    if (response.ok) {
      // 응답으로 새로 추가된 코멘트를 추가한다.
      let reply = await response.json();
    }
  }
</script>
</html>