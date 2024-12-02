<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
  <%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<style>
    #inviting-table th {
        text-align: center;
    }

    #inviting-table tr {
        height: 50px;
    }
</style>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">
  
  <h2> 크루모임 글 상세페이지 </h2>
  <security:authentication property="principal" var="loginUser"/>
  <div>
    <div class="col d-flex justify-content-left">
      <div>
        가입가능여부
      </div>
    </div>
    <div class="title h4 d-flex justify-content-between align-items-center">
      <div class="title h4 d-flex justify-content-between align-items-center">
        <div>
          제목이 올 것이여${notice.title}
        </div>
        <span><i class="bi bi-eye"></i> ${notice.viewCnt}</span>
      </div>
      <div class="meta d-flex justify-content-between">
        <fmt:formatDate value="${notice.createdDate}" pattern="yyyy.MM.dd hh:mm:ss"/>
        
        <c:if test="${not empty notice.uploadFile.originalName}">
          <div class="content mb-4" id="fileDown" style="text-align: end">
            <a href="filedown?no=${notice.no}" class="btn btn-outline-primary btn-sm">첨부파일 다운로드</a>
            <span id="hover-box">${notice.uploadFile.originalName}</span>
          </div>
        </c:if>
      </div>
    </div>
    <div class="meta d-flex justify-content-between mb-3">
      <span>
        ${board.user.nickname} 닉네임 | <fmt:formatDate value="${board.createdDate}" pattern="yyyy.MM.dd hh:mm:ss"/> 시간
      </span>
      <span>
        <i class="bi bi-eye"></i> ${board.viewCnt}10
        <i class="bi bi-hand-thumbs-up"></i> ${board.like}10
        <i class="bi bi-chat-square-text"></i> ${replyCnt}10
      </span>
    </div>
    <div class="content mb-4" style="text-align: start">
      <p>내용이올시다${board.content}</p>
    </div>
    
    <div class="actions d-flex justify-content-between mb-4">
      <!-- 로그인 여부를 체크하기 위해 먼저 선언 -->
      <%--        <security:authorize access="isAuthenticated()">--%>
      <div>
        <!-- principal 프로퍼티 안의 loginUser 정보를 가져옴 -->
        <!-- loginUser.no를 가져와서 조건문 실행 -->
        <%--        <c:if test="${loginUser.no == board.user.no}">--%>
        <button class="btn btn-warning" onclick="updateBoard(${board.no})">수정</button>
        <button class="btn btn-danger" onclick="deleteBoard(${board.no})">삭제</button>
        <%--        </c:if>--%>
        <%--        <c:if test="${loginUser.no != board.user.no}">--%>
        <button type="button" class="btn btn-danger" onclick="report('board', ${board.no})">신고</button>
        <%--        </c:if>--%>
      
      </div>
      <div>
        <button class="btn btn-primary" id="likeCnt"
                onclick="boardLikeButton(${board.no}, ${loginUser.getNo()})">
          모임 가입
        </button>
        <a type="button" href="main" class="btn btn-secondary">목록</a>
      </div>
      <%--        </security:authorize>--%>
    </div>
    
    <!-- 댓글 작성 -->
    <div class="comment-form mb-4">
      <h5 style="text-align: start">댓글 작성</h5>
      <form method="get" action="add-reply">
        <input type="hidden" name="boardNo" value="${board.no}">
        <input type="hidden" name="userNo" value="${loginUser.no}">
        <div class="row">
<%--          <c:choose>--%>
<%--            <c:when test="${empty loginUser}">--%>
              <div class="form-group col-11">
                <input class="form-control" disabled placeholder="로그인 후 댓글 작성이 가능합니다."/>
              </div>
              <div class="col">
                <button type="button" class="btn btn-outline-success" onclick="goLogin()">등록</button>
              </div>
<%--            </c:when>--%>
<%--            <c:otherwise>--%>
              <div class="form-group col-11">
                <textarea name="content" class="form-control" rows="3" placeholder="댓글을 작성하세요."></textarea>
              </div>
              <div class="col">
                <button type="submit" class="btn btn-success" onclick="submitReply()">등록</button>
              </div>
<%--            </c:otherwise>--%>
<%--          </c:choose>--%>
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
                        <c:if test="${loginUser.no ne reply.user.no}">
                          <button type="button" class="btn btn-danger"
                                  style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;"
                                  onclick="report('reply', ${reply.no})">
                            신고
                          </button>
                        </c:if>
                      </div>
                      <div class="col-2" style="text-align: end">
                        <security:authorize access="isAuthenticated()">
                          <c:if test="${loginUser.no ne reply.user.no}">
                            <button class="btn btn-outline-primary btn-sm" id="replyLikeCnt"
                                    onclick="replyLikeButton(${board.no}, ${reply.no}, ${loginUser.getNo()})">
                              <i id="icon-thumbs"
                                 class="bi ${replyLiked == '1' ? 'bi-hand-thumbs-up-fill' : (replyLiked == '0' ? 'bi-hand-thumbs-up' : 'bi-hand-thumbs-up')}"></i>
                            </button>
                          </c:if>
                          <c:if test="${loginUser.no eq reply.user.no}">
                            <button type="button" class="btn btn-warning btn-sm" id="replyModifyButton-${reply.no}"
                                    onclick="appendModify(${reply.no})">수정
                            </button>
                            <button type="button" class="btn btn-danger btn-sm"
                                    onclick="deleteReply(${reply.no}, ${reply.boardNo})">삭제
                            </button>
                          </c:if>
                        </security:authorize>
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
                      <c:if test="${not empty loginUser}">
                        <button type="button" class="btn btn-outline-dark btn-sm d-flex justify-content-start mb-3"
                                name="replyContent" onclick="appendComment(${reply.no})">
                          답글
                        </button>
                      </c:if>
                      
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
  
  <!-- 신고 모달 창 -->
  <div class="modal" tabindex="-1" id="modal-reporter">
    <div class="modal-dialog">
      <div class="modal-content" style="text-align: start">
        <div class="modal-header">
          <h5 class="modal-title">신고 사유</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body ">
          <form method="post">
            <input type="hidden" name="type" value="">
            <input type="hidden" name="no" value="">
            <input type="hidden" name="bno" value="${board.no}">
            <div class="form-check">
              <input class="form-check-input" type="radio" value="스팸홍보/도배글입니다." name="reason" checked>
              <label class="form-check-label">
                스팸홍보/도배글입니다.
              </label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" value="불법정보를 포함하고 있습니다." name="reason">
              <label class="form-check-label">
                불법정보를 포함하고 있습니다.
              </label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" value=" 욕설/생명경시/혐오/차별적 표현입니다." name="reason">
              <label class="form-check-label">
                욕설/생명경시/혐오/차별적 표현입니다.
              </label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" value="개인정보 노출 게시물입니다." name="reason">
              <label class="form-check-label">
                개인정보 노출 게시물입니다.
              </label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" value="불쾌한 표현이 있습니다." name="reason">
              <label class="form-check-label">
                불쾌한 표현이 있습니다.
              </label>
            </div>
            <div class="form-check">
              <input class="form-check-input" type="radio" value="" name="reason" id="reason-etc">
              <label class="form-check-label">
                <input type="text" placeholder="신고사유를 직접 작성해주세요." id="etc">
              </label>
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
          <button type="button" class="btn btn-primary" onclick="reportButton()">신고</button>
        </div>
      </div>
    </div>
  </div>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>