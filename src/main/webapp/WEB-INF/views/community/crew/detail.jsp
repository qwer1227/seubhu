<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<script type="text/javascript"
        src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3af1f449b9175825b32af2e204b65779&libraries=services,clusterer,drawing"></script>
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

    table th {
        text-align: center;
    }

    table tr {
        height: 50px;
    }
</style>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">
  
  <h2> 크루모임 글 상세페이지 </h2>
  <input type="hidden" id="location" value="${crew.location}">
  <div>
    <div class="col d-flex d-flex justify-content-between">
      <div>
        ${crew.entered eq 'Y' ? '모집중' : '모집마감'}
      </div>
    </div>
    <div class="title h4 d-flex justify-content-between align-items-center">
      <div>
        ${crew.title}
      </div>
      <span class="h5">
          <i class="bi bi-eye"></i> ${crew.viewCnt}
          <i class="bi bi-chat-square-text"></i> ${replyCnt}
        </span>
    </div>
    <div class="meta d-flex justify-content-between mb-3">
      <span>
         ${crew.user.nickname} | <fmt:formatDate value="${crew.createdDate}" pattern="yyyy.MM.dd hh:mm:ss"/>
      </span>
      <div class="meta d-flex justify-content-between">
        <c:if test="${not empty crew.uploadFile.originalName}">
          <div class="content mb-4" id="fileDown" style="text-align: end">
            <a href="filedown?no=${crew.no}" class="btn btn-outline-primary btn-sm">첨부파일 다운로드</a>
            <span id="hover-box">${crew.uploadFile.originalName}</span>
          </div>
        </c:if>
      </div>
    </div>
    <div class="content mb-3" style="text-align: start">
      <div class="row">
        <div class="col-6 mb-2" id="map" style="height: 250px; width: 500px"></div>
        <div class="col-6">
          <table style="width: 100%">
            <colgroup>
              <col width="15%">
              <col width="*">
            </colgroup>
            <tbody>
            <tr>
              <th>크루명</th>
              <td>: ${crew.name}</td>
            </tr>
            <tr>
              <th>크루장</th>
              <td>: ${crew.user.nickname}</td>
            </tr>
            <tr>
              <th>일 시</th>
              <td>: ${crew.schedule}</td>
            </tr>
            <tr>
              <th>장 소</th>
              <td>: ${crew.location}</td>
            </tr>
            <tr>
              <th>가 입</th>
              <td>: ${memberCnt} / 5
                <security:authorize access="isAuthenticated()">
                  <security:authentication property="principal" var="loginUser"/>
                  <c:if test="${loginUser.no ne crew.user.no}">
                    <c:choose>
                      <c:when test="${isExists}">
                        <button id="btn-crew-leave" class="btn btn-danger btn-sm" onclick="crewLeaveButton(${crew.no})">
                          모임 탈퇴
                        </button>
                      </c:when>
                      <c:otherwise>
                        <button id="btn-crew_join" class="btn btn-primary btn-sm" onclick="crewJoinButton(${crew.no})">
                          모임 가입
                        </button>
                      </c:otherwise>
                    </c:choose>
                  </c:if>
                </security:authorize></td>
            </tr>
            </tbody>
          </table>
        </div>
        <div>
          <p>${crew.description}</p>
        </div>
      </div>
    </div>
    
    <div class="row actions mb-4">

      <!-- 로그인 여부를 체크하기 위해 먼저 선언 -->
      <security:authorize access="isAuthenticated()">
        <div class="col-6 d-flex justify-content-start">
          <!-- principal 프로퍼티 안의 loginUser 정보를 가져옴 -->
          <!-- loginUser.no를 가져와서 조건문 실행 -->
          <c:if test="${loginUser.no eq crew.user.no and loginUser ne null}">
            <button class="btn btn-warning" onclick="updateCrew(${crew.no})">수정</button>
            <button class="btn btn-danger" onclick="deleteCrew(${crew.no})">삭제</button>
          </c:if>
          <c:if test="${loginUser.no ne crew.user.no}">
            <button type="button" class="btn btn-danger" onclick="report('crew', ${crew.no})">신고</button>
          </c:if>
        </div>
      </security:authorize>
      <div class="col-6 d-flex justify-content-end">
        <a type="button" href="main" class="btn btn-secondary">목록</a>
      </div>

    </div>
    
    <!-- 댓글 작성 -->
    <div class="comment-form mb-4">
      <h5 style="text-align: start">댓글 작성</h5>
      <form method="get" action="add-reply">
        <input type="hidden" name="crewNo" value="${crew.no}">
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
                                  onclick="report('crewReply', ${reply.no})">
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
  </div>
  
  <!-- 신고 모달 창 -->
  <%@include file="/WEB-INF/views/community/report-modal.jsp" %>

</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
<script>

    const myModalRepoter = new bootstrap.Modal('#modal-reporter')

    function updateCrew(crewNo) {
        let result = confirm("해당 크루 모임글을 수정하시겠습니까?");
        if (result) {
            window.location.href = "modify?no=" + crewNo;
        }
    }

    function deleteCrew(crewNo) {
        let result = confirm("해당 크루 모임글을 삭제하시겠습니까?");
        if (result) {
            window.location.href = "delete?no=" + crewNo;
        }
    }

    function goLogin() {
        let result = confirm("로그인하시겠습니까?");
        if (result) {
            window.location.href = "/login";
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
        let boardNo = document.querySelector("input[name=crewNo]").value;
        let content = document.querySelector("textarea[name=content]").value;
        let userNo = document.querySelector("input[name=userNo]").value;

        let data = {
            boardNo,
            content,
            userNo
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
    function deleteReply(replyNo, crewNo) {
        let result = confirm("해당 댓글을 삭제하시겠습니까?");
        if (result) {
            window.location.href = "delete-reply?rno=" + replyNo + "&cno=" + crewNo;
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

    function replyLikeButton(crewNo, replyNo, userNo) {
        let heart = document.querySelector("#icon-thumbs");
        if (heart.classList.contains("bi-hand-thumbs-up")) {
            window.location.href = `update-reply-like?no=\${crewNo}&rno=\${replyNo}&userNo=\${userNo}`;
        } else {
            window.location.href = `delete-reply-like?no=\${crewNo}&rno=\${replyNo}&userNo=\${userNo}`;
        }
    }

    /* 버튼 클릭 시 답글 입력 폼 활성화 */
    function appendComment(replyNo) {
        let box = document.querySelector("#box-comments-" + replyNo);
        box.classList.toggle("d-none");
    }

    function crewJoinButton(crewNo) {
        let result = confirm("해당 모임에 가입하시겠습니까?");
        if (result) {
            window.location.href = "enter-crew?no=" + crewNo;
        }
    }

    function crewLeaveButton(crewNo) {
        let result = confirm("가입된 해당 모임을 탈퇴하시겠습니까?");
        if (result) {
            window.location.href = "leave-crew?no=" + crewNo;
        }
    }

    async function report(type, no) {
        let response = await fetch("/community/crew/report-check?type=" + type + "&no=" + no, {
            // 요청방식을 지정한다.
            method: "GET",
            // 요청메세지의 바디부에 포함된 컨텐츠의 형식을 지정한다.
            headers: {
                "Content-Type": "application/json"
            }
        });

        if (response.ok) {
            let exists = await response.text();

            if (exists === "yes") {
                // 신고한 내역이 있으면
                alert("이미 신고한 내역이 있습니다");
            } else {
                // 신고한 내역이 없으면 모달창 보이기
                document.querySelector(".modal input[name=type]").value = type;
                document.querySelector(".modal input[name=no]").value = no;
                document.querySelector(".modal input[name=cno]").value = ${crew.no};

                if (type === 'crew') {
                    $(".modal form").attr('action', 'report-crew');
                }
                if (type === 'crewReply') {
                    $(".modal form").attr('action', 'report-reply');
                }

                myModalRepoter.show();
            }
        }
    }

    function reportButton() {
        if (document.querySelector("#reason-etc").checked) {
            document.querySelector("#reason-etc").value = document.querySelector("#etc").value;
        }
        $(".modal form").trigger("submit");
    }

    var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
    var options = { //지도를 생성할 때 필요한 기본 옵션
        center: new kakao.maps.LatLng(37.572990, 126.992240), //지도의 중심좌표.
        level: 3 //지도의 레벨(확대, 축소 정도)
    };

    var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
    let loc = document.querySelector("#location").value
    var ps = new kakao.maps.services.Places();
    ps.keywordSearch(loc, placesSearchCB);

    function placesSearchCB(data, status) {
        if (status === kakao.maps.services.Status.OK) {
            // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
            // LatLngBounds 객체에 좌표를 추가합니다
            var bounds = new kakao.maps.LatLngBounds();

            displayMarker(data[0]);
            bounds.extend(new kakao.maps.LatLng(data[0].y, data[0].x));

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
            map.setBounds(bounds);
        }
    }

    // 지도에 마커를 표시하는 함수입니다
    function displayMarker(place) {
        // 마커를 생성하고 지도에 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: new kakao.maps.LatLng(place.y, place.x)
        });
    }
</script>
</html>