<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
  <%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<style>
  /* 툴팁 스타일 (처음에는 숨겨져 있음) */
  #hover-box {
    display: none; /* 기본적으로 툴팁 숨김 */
    position: absolute;
    top: 100%; /* 버튼 바로 아래에 위치 */
    right: 0%;
    transform: translateX(-50%); /* 툴팁을 버튼의 중앙에 맞춤 */
    background-color: rgba(0, 0, 0, 0.7); /* 배경 색상 */
    color: white; /* 글씨 색상 */
    padding: 5px 10px;
    border-radius: 5px;
    font-size: 12px;
    white-space: nowrap; /* 내용이 길어도 줄바꿈 하지 않음 */
    z-index: 10; /* 툴팁을 다른 요소 위에 표시 */
  }
  
  /* 버튼에 마우스를 올렸을 때 툴팁 표시 */
  .btn-outline-primary:hover + #hover-box {
    display: block;
  }
  
  /* 툴팁이 나타날 때 다른 콘텐츠가 영향을 받지 않도록 */
  #fileDown:hover {
    z-index: 20; /* 버튼과 툴팁 위로 다른 요소들이 오지 않도록 설정 */
    position: relative; /* 툴팁을 버튼을 기준으로 설정 */
  }
</style>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">
  
  <h2> 커뮤니티 글 상세 </h2>
  <div>
    <div class="col d-flex justify-content-left">
      <div>
        <a href="main?category=${board.catName}" style="text-decoration-line: none">${board.catName}</a>
      </div>
    </div>
    <div class="title h4 d-flex justify-content-between align-items-center">
      <div>
        ${board.title}
      </div>
      <div class="ml-auto">
        <%--        <c:if test="${empty board.updatedDate}">--%>
        <%--          ${board.createdDate}--%>
        <%--        </c:if>--%>
        <%--        ${board.updatedDate}--%>
      </div>
    </div>
    <div class="meta d-flex justify-content-between mb-3">
      <span>
        ${board.user.nickname} | <fmt:formatDate value="${board.createdDate}"
                                                 pattern="yyyy.MM.dd hh:mm:ss"></fmt:formatDate>
      </span>
      <span>
        <i class="bi bi-eye"></i> ${board.viewCnt}
        <i class="bi bi-hand-thumbs-up"></i> ${board.like}
        <i class="bi bi-chat-square-text"></i> 5
      </span>
    </div>
    
    <c:if test="${not empty board.uploadFile}">
      <div class="content mb-4" id="fileDown" style="text-align: end">
        <a href="filedown?no=${board.no}" class="btn btn-outline-primary btn-sm">첨부파일 다운로드</a>
        <span id="hover-box">${board.uploadFile.originalName}</span>
      </div>
    </c:if>
    
    <div class="content mb-4" style="text-align: start">
      <p>${board.content}</p>
    </div>
    
    <div class="actions d-flex justify-content-between mb-4">
      <div>
        <%--      <c:if test="${empty LOGIN_USER ? '' : 'disabled'}">--%>
        <%--        <c:choose>--%>
        <%--          <c:when test="${LOGINED_USER eq board.user.no ? '' : 'disabled'}">--%>
        <button class="btn btn-warning" onclick="updateBoard(${board.no})">수정</button>
        <button class="btn btn-danger" onclick="deleteBoard(${board.no})">삭제</button>
        <%--          </c:when>--%>
        <%--          <c:otherwise>--%>
        <button class="btn btn-danger">신고</button>
        <%--          </c:otherwise>--%>
        <%--        </c:choose>--%>
        <%--      </c:if>--%>
      </div>
      <div>
        <button class="btn btn-outline-dark">
          <i class="bi bi-hand-thumbs-up"></i>
          <i class="bi bi-hand-thumbs-up-fill"></i>
        </button>
        <a type="button" href="main" class="btn btn-secondary">목록</a>
      </div>
    </div>
    
    <!-- 댓글 작성 기능 -->
    <div class="comment-form mb-4">
      <h5 style="text-align: start">댓글 작성</h5>
      <form method="post" action="/community/addReply">
        <div class="row">
          <input type="hidden" name="boardNo" value="${board.no}">
          <div class="form-group col-11">
            <%--        <c:choose>--%>
            <%--          <c:when test="${empty LOGIN_USER}">--%>
            <%--            <input class="form-control" disabled rows="3" placeholder="로그인 후 댓글 작성이 가능합니다." />--%>
            <%--          </c:when>--%>
            <%--          <c:otherwise>--%>
            <textarea name="reply" class="form-control" rows="3" placeholder="댓글을 작성하세요."></textarea>
            <%--          </c:otherwise>--%>
            <%--        </c:choose>--%>
          </div>
        <div class="col">
          <button class="btn btn-success" onclick="submitReply()">등록</button>
        </div>
        </div>
      </form>
    </div>
    
    <!-- 댓글 목록 -->
    <div class="row comments rounded" style="background-color: #f2f2f2">
      <!--댓글 내용 -->
      <div class="comment pt-3">
        <div class="row">
          <div class="col">
            <div class="col d-flex justify-content-between">
              <div class="col-1">
                <img src="https://github.com/mdo.png" alt="" style="width: 50px" class="rounded-circle">
              </div>
              <div class="col" style="text-align: start">
                <strong>모모랜드</strong><br/>
                <%--              <span><fmt:formatDate value="" pattern="yyyy.MM.dd hh:mm:ss"></span>--%>
                <button type="button" class="btn"
                        style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">신고
                </button>
              </div>
              <div style="text-align: end">
                <%--              <c:if test="${LOGIN_USER eq board.review.user.no}">--%>
                <a href="modify-form" type="button" class="btn btn-warning btn-sm">수정</a>
                <button class="btn btn-danger btn-sm" onclick="deleteReply()">삭제</button>
                <%--              </c:if>--%>
              </div>
            </div>
          </div>
        </div>
        
        <div class="comment-item mt-1 rounded" style="border: 1px solid gray;">
          댓글 내용이오
        </div>
        <c:if test="${not empty LOGIN_USER}">
          <button class="btn btn-outline-dark btn-sm d-flex justify-content-start">답글</button>
        </c:if>
      </div>
      
      <!-- 답글 내용 -->
      <div class="row pt-1 pb-3">
        <div class="col-1" style="text-align: end">
          <i class="bi bi-arrow-return-right"></i>
        </div>
        <div class="col-11">
          <div class="col d-flex justify-content-between">
            <div class="col-1">
              <img src="https://github.com/mdo.png" alt="" style="width: 50px" class="rounded-circle">
            </div>
            <div class="col" style="text-align: start">
              <strong>모모랜드</strong><br/>
              <div style="font-size: 10px; text-align: start">
                <%--            <span><fmt:formatDate value="" pattern="yyyy.MM.dd hh:mm:ss"></span>--%>
                <button type="button" class="btn"
                        style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">신고
                </button>
              </div>
            </div>
            <div class="col-2" style="text-align: end">
              <button class="btn btn-warning btn-sm">수정</button>
              <button class="btn btn-danger btn-sm" onclick="deleteReply()">삭제</button>
            </div>
          </div>
          <div class="comment-item rounded mt-1" style="border: 1px solid gray;">
            답글 내용이오
          </div>
          <c:if test="${not empty LOGIN_USER}">
            <button class="btn btn-outline-dark btn-sm d-flex justify-content-start">답글</button>
          </c:if>
        </div>
      </div>
    </div>
  </div>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
<script type="text/javascript">
    function updateBoard(boardNo){
        let result = confirm("해당 게시글을 수정하시겠습니까?");
        if (result) {
            window.location.href = "modify?no=" + boardNo;
        }
    }
    function deleteBoard(boardNo) {
        let result = confirm("해당 댓글을 삭제하시겠습니까?");
        if (result){
            window.location.href = "delete?no=" + boardNo;
        }
    }

    function deleteReply() {
        alert("해당 댓글을 삭제하시겠습니까?")
    }
    
    async function submitReply(){
      let value1 = document.querySelector("textarea[name=reply]").value
      let value2 = document.querySelector("input[name=boardNo]").value
      
      let date = {
        content: value1,
        boardNo: value2
      }
      
      // 자바스크립트 객체를 json형식의 텍스트로 변환한다.
      let jsonText = JSON.stringify(data);
      
      // POST 방식으로 객체를 JSON 형식의 데이터를 서버로 보내기
      let response = await fetch("/community/addReply", {
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
      if(response.ok){
        // 응답으로 새로 추가된 코멘트를 추가한다.
        let reply = await response.json();
      }
    }
</script>
</html>