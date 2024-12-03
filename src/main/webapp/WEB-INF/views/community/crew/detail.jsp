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
</style>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">
  
  <h2> 크루모임 글 상세페이지 </h2>
  <security:authentication property="principal" var="loginUser"/>
  <input type="hidden" id="location" value="${crew.location}">
  <div>
    <div class="col d-flex d-flex justify-content-between">
      <div>
        가입가능여부
      </div>
    </div>
    <div class="title h4 d-flex justify-content-between align-items-center">
      <div>
        ${crew.title}
      </div>
      <span class="h5">
          <i class="bi bi-eye"></i> ${crew.viewCnt}
          <i class="bi bi-chat-square-text"></i> 10
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
      <table style="width: 100%">
        <colgroup>
          <col width="5%">
          <col width="50%">
          <col width="5%">
          <col width="40%">
        </colgroup>
        <tbody>
        <tr>
          <td></td>
          <td rowspan="5" class="d-flex justify-content-center">
            <div class="col-6 mb-2" id="map" style="height: 250px; width: 500px"></div>
          </td>
          <td style="text-align: center">
            <span style=>
            <p><strong>크루명</strong></p>
            <p><strong>크루장</strong></p>
            <p><strong>일 시</strong></p>
            <p><strong>장 소</strong></p>
            <p><strong>가 입</strong></p>
            </span>
          </td>
          <td>
            <p>${crew.name}</p>
            <p>${crew.user.nickname}</p>
            <p>${crew.schedule}</p>
            <p>${crew.location}</p>
            <p>
              ? / 5
              <button class="btn btn-primary btn-sm" id="likeCnt">
                <%--                onclick="boardLikeButton(${board.no}, ${loginUser.getNo()})">--%>
                모임 가입
              </button>
            </p>
          </td>
        </tr>
        <tr>
          <td colspan="4">
            <textarea id="content" class="form-control bg-white border-0"
                      readonly="readonly">${crew.description}
            </textarea>
          </td>
        </tr>
        </tbody>
      </table>
    </div>
    
    <div class="actions d-flex justify-content-between mb-4">
      <!-- 로그인 여부를 체크하기 위해 먼저 선언 -->
      <%--        <security:authorize access="isAuthenticated()">--%>
      <div>
        <!-- principal 프로퍼티 안의 loginUser 정보를 가져옴 -->
        <!-- loginUser.no를 가져와서 조건문 실행 -->
        <%--        <c:if test="${loginUser.no == board.user.no}">--%>
        <button class="btn btn-warning" onclick="updateBoard()">수정</button>
        <button class="btn btn-danger" onclick="deleteBoard()">삭제</button>
        <%--        </c:if>--%>
        <%--        <c:if test="${loginUser.no != board.user.no}">--%>
        <button type="button" class="btn btn-danger" onclick="report()">신고</button>
        <%--        </c:if>--%>
      
      </div>
      <div>
        <a type="button" href="main" class="btn btn-secondary">목록</a>
      </div>
      <%--        </security:authorize>--%>
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
            <%--              <input type="hidden" name="bno" value="${board.no}">--%>
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
<script>

    var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
    var options = { //지도를 생성할 때 필요한 기본 옵션
        center: new kakao.maps.LatLng(37.572990, 126.992240), //지도의 중심좌표.
        level: 3 //지도의 레벨(확대, 축소 정도)
    };

    var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
    let loc = document.querySelector("#location").value
    var ps = new kakao.maps.services.Places();
    ps.keywordSearch(loc, placesSearchCB);

    function placesSearchCB(data, status, pagination) {
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