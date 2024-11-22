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
        <button class="btn btn-outline-success btn-lg">
          <i class="bi bi-bookmark"></i>
          <i class="bi bi-bookmark-fill"></i>
        </button>
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
    
    <c:if test="${not empty board.uploadFile.originalName}">
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
        <button class="btn btn-outline-primary">
          <i class="bi bi-hand-thumbs-up"></i>
          <i class="bi bi-hand-thumbs-up-fill"></i>
        </button>
        <a type="button" href="main" class="btn btn-secondary">목록</a>
      </div>
    </div>
    
    <!-- 댓글 작성 -->
    <div class="comment-form mb-4">
      <h5 style="text-align: start">댓글 작성</h5>
      <form method="get" action="add-reply">
        <input type="hidden" name="boardNo" value="${board.no}">
        <%--          <input type="hidden" name="userNo" value="${user.no}">--%>
        <input type="hidden" name="userNo" value="11">
        <div class="row">
          <div class="form-group col-11">
            <%--        <c:choose>--%>
            <%--          <c:when test="${empty LOGIN_USER}">--%>
            <%--            <input class="form-control" disabled rows="3" placeholder="로그인 후 댓글 작성이 가능합니다." />--%>
            <%--          </c:when>--%>
            <%--          <c:otherwise>--%>
            <textarea name="content" class="form-control" rows="3" placeholder="댓글을 작성하세요."></textarea>
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
    <c:if test="${not empty board.reply}">
      <div class="row comments rounded" style="background-color: #f2f2f2">
        <!--댓글 내용 -->
        <c:forEach var="reply" items="${replies}">
          <c:choose>
            <c:when test="${reply.deleted eq 'Y'}">
              <div class="row m-3" style="text-align: start">
                <div class="col d-flex justify-content-between" style="text-align: start">
                  <c:if test="${reply.no ne reply.prevNo}">
                    <i class="bi bi-arrow-return-right"></i>
                  </c:if>
                  <i class="bi bi-emoji-dizzy" style="font-size: 35px; margin-left: 5px;"></i>
                  <div class="col" style="margin-left: 15px">
                    <c:if test="${reply.no eq reply.prevNo}">
                      <strong>삭제된 댓글입니다.</strong><br/>
                    </c:if>
                    <c:if test="${reply.no ne reply.prevNo}">
                      <strong>삭제된 답글입니다.</strong><br/>
                    </c:if>
                    <span><fmt:formatDate value="${reply.createdDate}" pattern="yyyy.MM.dd hh:mm:ss"/></span>
                  </div>
                </div>
              </div>
            </c:when>
            <c:otherwise>
              <div class="comment pt-3 ">
                <div class="row">
                  <div class="col ${reply.no ne reply.prevNo ? 'ps-5' : ''}">
                    <div class="col d-flex justify-content-between">
                      <div class="col-1">
                        <c:if test="${reply.no ne reply.prevNo}">
                          <i class="bi bi-arrow-return-right"></i>
                        </c:if>
                        <img src="https://github.com/mdo.png" alt="" style="width: 50px" class="rounded-circle">
                      </div>
                      <div class="col" style="text-align: start">
                        <strong>${reply.user.nickname}</strong><br/>
                        <span><fmt:formatDate value="${reply.createdDate}" pattern="yyyy.MM.dd hh:mm:ss"/></span>
                        <button type="button" class="btn"
                                style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">
                          신고
                        </button>
                      </div>
                      <div class="col-2" style="text-align: end">
                          <%--              <c:if test="${LOGIN_USER eq board.review.user.no}">--%>
                        <button class="btn btn-outline-dark btn-sm">
                          <i class="bi bi-hand-thumbs-up"></i>
                          <i class="bi bi-hand-thumbs-up-fill"></i>
                        </button>
                        <button type="button" class="btn btn-warning btn-sm" id="replyModifyButton-${reply.no}"
                                onclick="appendModify(${reply.no})">수정
                        </button>
                          <button type="button" class="btn btn-danger btn-sm"
                                  onclick="deleteReply(${reply.no}, ${reply.boardNo})">삭제
                          </button>
                          <%--              </c:if>--%>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="row">
                  <div class="col ${reply.no ne reply.prevNo ? 'ps-5' : ''}">
                    <div class="comment-item m-1 rounded" style="padding-left:30px; text-align:start;">
                        ${reply.content}
                      <form method="post" action="modify-reply" id="box-reply-${reply.no}" class="my-3 d-none">
                        <div class="row">
                          <input type="hidden" name="replyNo" value="${reply.no}">
                          <input type="hidden" name="boardNo" value="${reply.boardNo}">
                          <div class="col-11">
                            <textarea name="content" class="form-control" rows="2">${reply.content}</textarea>
                          </div>
                          <div class="col">
                            <button class="btn btn-warning btn-sm d-flex justify-content-start" type="submit">
                              수정
                            </button>
                          </div>
                        </div>
                      </form>
                        <%--        <c:if test="${not empty LOGIN_USER}">--%>
                      <button type="button" class="btn btn-outline-dark btn-sm d-flex justify-content-start mb-3"
                              name="replyContent" onclick="appendComment(${reply.no})">
                        답글
                      </button>
                        <%--        </c:if>--%>
                      
                      <form method="post" action="add-comment" id="box-comments-${reply.no}" class="my-3 d-none">
                        <input type="hidden" name="no" value="${reply.no}">
                        <input type="hidden" name="prevNo" value="${reply.prevNo}">
                        <input type="hidden" name="boardNo" value="${board.no}">
                        <div class="row">
                          <div class="col-11">
                            <textarea name="content" class="form-control" rows="2" placeholder="답글을 작성하세요."></textarea>
                          </div>
                          <div class="col">
                            <button type="submit" class="btn btn-success d-flex justify-content-start"
                                    style="font-size: 15px">
                              답글<br/>등록
                            </button>
                          </div>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
              </div>
            </c:otherwise>
          </c:choose>
        </c:forEach>
      </div>
    </c:if>
  </div>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
<script type="text/javascript">
    function updateBoard(boardNo) {
        let result = confirm("해당 게시글을 수정하시겠습니까?");
        if (result) {
            window.location.href = "modify?no=" + boardNo;
        }
    }

    function deleteBoard(boardNo) {
        let result = confirm("해당 게시글을 삭제하시겠습니까?");
        if (result) {
            window.location.href = "delete?no=" + boardNo;
        }
    }

    /* 댓글&답글 입력 폼이 클릭한 버튼 바로 아래 위치하도록 처리 */
    document.addEventListener("click", function (event) {
        // 클릭된 요소가 '답글' 버튼인지 확인
        if (event.target && event.target.classList.contains('btn-outline-dark')) {
            let replyElement = event.target.closest('.comment-item'); // 댓글의 가장 가까운 부모 요소 찾기
            if (replyElement) {
                appendComment(replyElement);
                appendModify(replyElement);
            }
        }
    });
    
    /* 댓글 제출(/community/add-reply로 데이터 전달) */
    async function submitReply() {
        let value1 = document.querySelector("input[name=boardNo]").value;
        let value2 = document.querySelector("textarea[name=content]").value;
        let value3 = document.querySelector("input[name=userNo]").value;

        let data = {
            boardNo: value1,
            content: value2,
            userNo: value3
        }

        // 자바스크립트 객체를 json형식의 텍스트로 변환한다.
        let jsonText = JSON.stringify(data);

        // POST 방식으로 객체를 JSON 형식의 데이터를 서버로 보내기
        let response = await fetch("/community/add-reply", {
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
    
    /* 댓글&답글 삭제 */
    function deleteReply(replyNo, boardNo) {
        let result = confirm("해당 댓글을 삭제하시겠습니까?");
        if (result) {
            window.location.href = "delete-reply?rno=" + replyNo + "&bno=" + boardNo;
        }
    }
    
    /* 버튼 클릭 시 댓글 수정 입력 폼 활성화 */
    function appendModify(replyNo) {
        let box = document.querySelector("#box-reply-" + replyNo);
        box.classList.toggle("d-none");

        // 댓글 수정 버튼 클릭 여부에 따라 색상 변경
        let modifyButton = document.querySelector("#replyModifyButton-" + replyNo);
        if (modifyButton) {
            if (box.classList.contains("d-none")) {
                // 폼이 닫혔을 때 색상 초기화
                modifyButton.style.backgroundColor = "";
                modifyButton.style.color = "";
            } else {
                // 폼이 열렸을 때 색상 변경
                modifyButton.style.backgroundColor = "white";
                modifyButton.style.color = "black";
            }
        }
    }

    /* 버튼 클릭 시 답글 입력 폼 활성화 */
    function appendComment(replyNo) {
        let box = document.querySelector("#box-comments-" + replyNo);
        box.classList.toggle("d-none");
    }
</script>
</html>