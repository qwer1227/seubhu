<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
	<%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">
	
	<h2> 커뮤니티 글 상세 </h2>
	
	<div>
		<div class="col d-flex justify-content-left">
			<div>
				<a href="" style="text-decoration-line: none">${board.catName}</a>
			</div>
		</div>
		<div class="title h4 d-flex justify-content-between align-items-center">
			<div>
				${board.title}
			</div>
		</div>
		<div class="meta d-flex justify-content-between mb-3">
      <span>
        ${board.user.nickname} |
        <fmt:formatDate value="${board.createdDate}" pattern="yyyy.MM.dd hh:mm:ss"/>
      </span>
			<span>
        <i class="bi bi-eye"></i> ${board.viewCnt}
        <i class="bi bi-hand-thumbs-up"></i> ${board.like}
        <i class="bi bi-chat-square-text"></i> 5
      </span>
		</div>
		
		<div class="content mb-4" style="text-align: start">
			<p>${board.content}</p>
		</div>
		
		<div class="actions d-flex justify-content-between mb-4">
			<div>
				<%--      <c:if test="${empty LOGIN_USER ? '' : 'disabled'}">--%>
				<%--        <c:choose>--%>
				<%--          <c:when test="${LOGINED_USER eq board.user.no ? '' : 'disabled'}">--%>
				<button class="btn btn-warning" onclick="updateBoard(${board.no})">수정</button>
				<button class="btn btn-danger" onclick="deleteBoard()">삭제</button>
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
			<div class="row">
				<div class="form-group col-11">
					<%--        <c:choose>--%>
					<%--          <c:when test="${empty LOGIN_USER}">--%>
					<%--            <input class="form-control" disabled rows="3" placeholder="로그인 후 댓글 작성이 가능합니다." />--%>
					<%--          </c:when>--%>
					<%--          <c:otherwise>--%>
					<textarea class="form-control" rows="3" placeholder="댓글을 작성하세요."></textarea>
					<%--          </c:otherwise>--%>
					<%--        </c:choose>--%>
				</div>
				<div class="col">
					<button class="btn btn-success">등록</button>
				</div>
			</div>
		</div>
		
		<!-- 댓글 목록 -->
		<%--    <c:forEach var="reply" items="replies">--%>
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
								<span><fmt:formatDate value="" pattern="yyyy.MM.dd hh:mm:ss"/></span>
								<button type="button" class="btn"
												style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">
									신고
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
			
			<div class="comment pt-3" style="padding-left: 50px">
				<div class="row">
					<div class="col">
						<div class="col d-flex justify-content-between">
							<div class="col-1">
								<i class="bi bi-arrow-return-right"></i>
								<img src="https://github.com/mdo.png" alt="" style="width: 50px" class="rounded-circle">
							</div>
							<div class="col" style="text-align: start">
								<strong>모모랜드</strong><br/>
								<span><fmt:formatDate value="" pattern="yyyy.MM.dd hh:mm:ss"/></span>
								<button type="button" class="btn"
												style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">
									신고
								</button>
							</div>
							<div style="text-align: end">
								<%--              <c:if test="${LOGIN_USER eq board.review.user.no}">--%>
								<a href="modify-form" type="button" class="btn btn-warning btn-sm">수정</a>
								<button class="btn btn-danger btn-sm" onclick="deleteReply()">삭제</button>
								<%--              </c:if>--%>
							</div>
						</div>
						<div class="comment-item mt-1 rounded" style="border: 1px solid gray;">
							댓글 내용이오
						</div>
						<c:if test="${not empty LOGIN_USER}">
							<button class="btn btn-outline-dark btn-sm d-flex justify-content-start">답글</button>
						</c:if>
					</div>
				
				</div>
			</div>
			<%--    </c:forEach>--%>
		</div>
	</div>
	<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
<script type="text/javascript">
    function updateBoard(boardNo) {
        alert("해당 게시글을 수정하시겠습니까?")
        window.location.href = "form?no=" + boardNo;
    }

    function deleteBoard() {
        alert("해당 댓글을 삭제하시겠습니까?")
    }

    function deleteReply() {
        alert("해당 댓글을 삭제하시겠습니까?")
    }
</script>
</html>