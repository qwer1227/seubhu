<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .auto-resize {
        border: none; /* 테두리 제거 */
        box-shadow: none; /* 그림자 제거 */
        resize: none; /* 크기 조정 막기 */
        overflow: hidden; /* 스크롤바 숨기기 */
    }

    .auto-resize:focus {
        outline: none; /* 포커스 시 외곽선 제거 */
    }

    #reply-content-area {
        resize: none;
        overflow: hidden;
        border: none;
        box-shadow: none;
        background: transparent;
    }
</style>
<!doctype html>
<html lang="ko">
	<c:choose>
		<c:when test="${reply.deleted eq 'Y'}">
			<!-- 삭제된 댓글인 경우 -->
			<div class="row m-3" style="text-align: start">
				<div class="col d-flex justify-content-between" style="text-align: start">
					<!-- 대댓글인 경우, 화살표 아이콘 추가 -->
					<c:if test="${reply.no ne reply.prevNo}">
						<i class="bi bi-arrow-return-right"></i>
					</c:if>
					<i class="bi bi-emoji-dizzy" style="font-size: 35px; margin-left: 5px;"></i>
					<div class="col" style="margin-left: 15px">
						<strong>삭제된 댓글입니다.</strong><br/>
						<span><fmt:formatDate value="${reply.createdDate}" pattern="yyyy.MM.dd hh:mm:ss"/></span>
					</div>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<!-- 삭제되지 않은 댓글인 경우 -->
			<div class="comment pt-3 ">
				<div class="${reply.no ne reply.prevNo ? 'ps-5' : ''}">
					<!-- 댓글 내용 -->
					<div class="row d-flex justify-content-between">
						<div class="col-1">
							<c:if test="${reply.no ne reply.prevNo}">
								<i class="bi bi-arrow-return-right"></i>
							</c:if>
							<img src="https://github.com/mdo.png" alt="" style="width: 50px" class="rounded-circle">
						</div>
						<div class="col" style="text-align: start">
							<strong>${reply.user.nickname}</strong><br/>
							<span><fmt:formatDate value="${reply.createdDate}" pattern="yyyy.MM.dd hh:mm:ss"/></span>
							<c:if test="${loginUser.no ne reply.user.no and not empty loginUser}">
								<button type="button" class="btn btn-danger" onclick="report('${reply.type}Reply', ${reply.no})"
												style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;">신고
								</button>
							</c:if>
						</div>
						<div class="col-2" style="text-align: end">
							<security:authorize access="isAuthenticated()">
								<c:if test="${loginUser.no ne reply.user.no}">
									<button class="btn btn-outline-primary btn-sm" id="replyLikeCnt"
													onclick="replyLikeButton(${reply.typeNo}, ${reply.no})">
											${reply.replyLike}
										<i id="icon-thumbs-${reply.no}"
											 class="bi ${reply.replyLike == '1' ? 'bi-hand-thumbs-up-fill' : (reply.replyLike == '0' ? 'bi-hand-thumbs-up' : 'bi-hand-thumbs-up')}"></i>
									</button>
								</c:if>
								<c:if test="${loginUser.no eq reply.user.no}">
									<button type="button" class="btn btn-warning btn-sm" id="replyModifyButton-${reply.no}"
													onclick="appendModify(${reply.no})">수정
									</button>
									<button type="button" class="btn btn-danger btn-sm"
													onclick="deleteReply(${reply.typeNo},${reply.no})">삭제
									</button>
								</c:if>
							</security:authorize>
						</div>
					</div>
					<div class="row">
						<div class="col-1"></div>
						<div class="col" style="text-align: start">
							<span>@ ${reply.prevUser.nickname}</span>
							<textarea name="content" id="reply-content-area" class="form-control auto-resize" rows="1"
												style="">${reply.content}</textarea>
						</div>
					</div>
					<div class="col">
						<c:if test="${not empty loginUser and loginUser ne null}">
							<button type="button" class="btn btn-outline-dark btn-sm d-flex justify-content-start mb-2 mt-1"
											name="replyContent" style="margin: 100px" onclick="appendComment(${reply.no})">
								답글
							</button>
						</c:if>
					</div>
					
					<div class="col ${reply.no ne reply.prevNo ? 'ps-5' : ''}">
						<div class="comment-item m-1 rounded" style="padding-left:30px; text-align:start;">
							<form method="post" action="modify-reply" id="box-reply-${reply.no}" class="my-3 d-none">
								<div class="row">
									<input type="hidden" name="no" value="${reply.no}">
									<input type="hidden" name="prevNo" value="${reply.prevNo}">
									<input type="hidden" name="typeNo" value="${reply.typeNo}">
									<input type="hidden" name="type" value="${reply.type}">
									<div class="col-11">
										<div class="form-control"
												 style="position: relative; padding-top: 1.5em; border: none; box-shadow: none;">
											<!-- 닉네임 표시 부분 -->
											<span
												style="position: absolute; top: 0.5em; left: 0.5em; color: #6c757d;">@ ${reply.prevUser.nickname}</span>
											<!-- 텍스트 입력 영역 -->
											<textarea name="content" class="form-control auto-resize" rows="1" placeholder="답글을 작성하세요."
																style="resize: none; overflow: hidden; border: none; box-shadow: none;">${reply.content}</textarea>
										</div>
									</div>
									<div class="col">
										<button class="btn btn-warning d-flex align-items-center justify-content-center" type="submit"
														style="width: 70px;">
											수정
										</button>
									</div>
								</div>
							</form>
						</div>
					</div>
					<!-- 대댓글 입력 폼 -->
					<form method="post" action="add-comment" id="box-comments-${reply.no}" class="d-none">
						<input type="hidden" name="prevNo" value="${reply.prevNo}">
						<input type="hidden" name="rno" value="${reply.no}">
						<input type="hidden" name="type" value="${reply.type}">
						<input type="hidden" name="typeNo" value="${reply.typeNo}">
						<div class="row">
							<div class="col-11">
								<div class="form-control"  style="position: relative; padding-top: 1.5em; border: none; box-shadow: none;">
									<!-- 닉네임 표시 부분 -->
									<span style="position: absolute; top: 0.5em; left: 0.5em; color: #6c757d;">@ ${reply.prevUser.nickname}</span>
									<!-- 텍스트 입력 영역 -->
									<textarea name="content" class="form-control auto-resize" rows="1" placeholder="답글을 작성하세요."
														style="resize: none; overflow: hidden; border: none; box-shadow: none;" oninput="autoResize(this)"></textarea>
								</div>
							</div>
							<div class="col">
								<button type="submit" id="submit" class="btn btn-success d-flex align-items-center justify-content-center"
												style="font-size: 15px; width: 70px;">
									답글 <span>${reply.no}</span> / <span>${reply.typeNo}</span>
								</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</html>
<script>
		// 댓글 등록
    document.querySelector("#submit").addEventListener("click", function () {
        let no = document.querySelector("input[name=no]").value;
        let type = document.querySelector("input[name=type]").value;
        let typeNo = document.querySelector("input[name=typeNo]").value;
        let content = document.querySelector("textarea[name=content]").value;
        let returnUrl = "detail?no=" + typeNo;

        formData.append(("no"), no);
        formData.append(("typeNo"), typeNo);
        formData.append(("type"), type);
        formData.append(("content"), content);
        formData.append("returnUrl", returnUrl);

        $.ajax({
            method: "post",
            url: "modify-reply",
            data: formData,
            processData: false,
            contentType: false,
            success: function (board) {
                window.location.href = "detail?no=" + board.no;
            }
        })
    });


    /* 버튼 클릭 시 답글 입력 폼 활성화 */
    function appendComment(replyNo) {
        let box = document.querySelector("#box-comments-" + replyNo);
        box.classList.toggle("d-none");

        document.querySelector("#box-reply-${reply.no}").addEventListener("click", function () {
            let no = document.querySelector("input[name=no]").value;
            let prevNo = document.querySelector("input[name=prevNo]").value;
            let type = document.querySelector("input[name=type]").value;
            let typeNo = document.querySelector("input[name=typeNo]").value;
            let content = document.querySelector("textarea[name=content]").value;
            let returnUrl = "detail?no=" + typeNo;

            formData.append(("no"), no);
            formData.append(("prevNo"), prevNo);
            formData.append(("typeNo"), typeNo);
            formData.append(("type"), type);
            formData.append(("content"), content);
            formData.append("returnUrl", returnUrl);

            $.ajax({
                method: "post",
                url: "add-comment",
                data: formData,
                processData: false,
                contentType: false,
                success: function (board) {
                    window.location.href = "detail?no=" + board.no;
                }
            })
        });
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

                // textarea 높이를 자동 조정
                const textarea = box.querySelector("textarea");
                if (textarea) {
                    autoResize(textarea); // textarea의 높이를 자동 조정
                }
            }
        }
    }

    /* 댓글&답글 삭제 */
    function deleteReply(typeNo, replyNo) {
        let result = confirm("해당 댓글을 삭제하시겠습니까?");
        if (result) {
            window.location.href = "delete-reply?no=" + typeNo + "&rno=" + replyNo;
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

    function replyLikeButton(boardNo, replyNo) {
        let heart = document.querySelector("#icon-thumbs-" + replyNo);
        if (heart.classList.contains("bi-hand-thumbs-up")) {
            window.location.href = `update-reply-like?no=\${boardNo}&rno=\${replyNo}`;
        } else {
            window.location.href = `delete-reply-like?no=\${boardNo}&rno=\${replyNo}`;
        }
    }

    function autoResize(textarea) {
        // 높이를 초기화하여 스크롤 높이를 정확히 계산
        textarea.style.height = 'auto';
        // 입력된 텍스트에 따라 높이를 조정
        textarea.style.height = textarea.scrollHeight + 'px';
    }

    // DOM이 로드된 후 textarea에 자동 크기 조정 이벤트를 추가
    document.addEventListener("DOMContentLoaded", function () {
        const textareas = document.querySelectorAll(".auto-resize");
        textareas.forEach(function (textarea) {
            adjustTextareaHeight(textarea); // 초기 높이 설정

            // 입력 이벤트가 발생할 때마다 높이를 조정
            textarea.addEventListener("input", function () {
                adjustTextareaHeight(textarea);
            });
        });
    });

    // 페이지 로드 시 기존 값이 있다면 크기를 조정
    document.querySelectorAll('.auto-resize').forEach(textarea => {
        autoResize(textarea);
    });
</script>