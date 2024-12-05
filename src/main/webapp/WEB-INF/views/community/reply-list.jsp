<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="ko">
<head>
</head>
<body>
<!-- 댓글 목록 -->
<c:if test="${not empty crew.reply}">
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
                <span><fmt:formatDate value="" pattern="yyyy.MM.dd hh:mm:ss"/></span>
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
                                onclick="replyLikeButton(${crew.no}, ${reply.no}, ${loginUser.getNo()})">
                          <i id="icon-thumbs"
                             class="bi ${replyLiked == '1' ? 'bi-hand-thumbs-up-fill' : (replyLiked == '0' ? 'bi-hand-thumbs-up' : 'bi-hand-thumbs-up')}"></i>
                        </button>
                      </c:if>
                      <c:if test="${loginUser.no eq reply.user.no}">
                        <button type="button" class="btn btn-warning btn-sm" id="replyModifyButton-${reply.no}"
                                onclick="appendModify(${reply.no})">수정
                        </button>
                        <button type="button" class="btn btn-danger btn-sm"
                                onclick="deleteReply(${reply.no}, ${reply.crewNo})">삭제
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
                      <input type="hidden" name="crewNo" value="${reply.crewNo}">
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
                    <input type="hidden" name="crewNo" value="${crew.no}">
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
</body>
</html>