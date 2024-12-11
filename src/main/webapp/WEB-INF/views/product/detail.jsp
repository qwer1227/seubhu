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

    <h2>상품 상세 페이지</h2>

    <div class="container" style="margin-top: 100px;">
        <div class="row mb-3">
            <%--상품의 사진을 화면에 표시한다.--%>
            <div class="col-6">
                <div class="mb-3 box-big-img">
                    <img src="${prodImagesDto.images.get(0).url}" width="100%" id="big-img"/>
                </div>
                <div class="row">
                    <c:forEach var="imgs" items="${prodImagesDto.images}">
                        <div class="col-2 box-small-img">
                            <img class="img-fluid" src="${imgs.url}" data-big-img-path="${imgs.url}"/>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="col-6">
                <div class="row mb-3">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h4>상품 상세 정보</h4>
                            </div>
                            <div class="card-body">
                                <table class="table">
                                    <colgroup>
                                        <col width="15%" />
                                        <col width="35%" />
                                        <col width="15%" />
                                        <col width="35%" />
                                    </colgroup>
                                    <tr>
                                        <th>상품 이름</th>
                                        <td colspan="3">${prodDetailDto.name}</td>
                                    </tr>
                                    <tr>
                                        <th>상품 가격</th>
                                        <td colspan="3"><fmt:formatNumber value="${prodDetailDto.price }"/> 원</td>
                                    </tr>
                                    <tr>
                                        <th>브랜드명</th>
                                        <td>${prodDetailDto.brand.name}</td>
                                        <th>카테고리</th>
                                        <td>${prodDetailDto.category.name}</td>
                                    </tr>
                                    <tr>
                                        <th>평점</th>
                                        <td>${prodDetailDto.rating}</td>
                                        <th>조회수</th>
                                        <td>${prodDetailDto.cnt}</td>
                                    </tr>
                                    <tr>
                                        <th>상품 설명</th>
                                        <td colspan="3">${prodDetailDto.content}</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h4>상품 옵션 선택</h4>
                            </div>
                            <div>색상을 선택하세요:</div>
                            <div class="card-body">
                                <div class="mb-4">
                                    <c:forEach var="p" items="${colorProdImgDto}">
                                            <c:forEach var="im" items="${p.images}">
                                                <a href="detail?no=${p.product.no}&colorNo=${p.no}"><img src="${im.url}" width=15%/></a>
                                            </c:forEach>
                                    </c:forEach>
                                </div>
                                    <div class="mb-4">
                                        <div class="mb-4">
                                            <label class="form-label d-block">사이즈를 선택하세요:</label>
                                            <div class="row row-cols-5 g-3">
                                                <!-- 사이즈 버튼 -->
                                                <c:forEach var="size" items="${sizeAmountDto.sizes }" varStatus="loop">
                                                    <div class="col">
                                                        <input type="radio" class="btn-check" name="size" id="size${size.size}" value="${size.size}" required
                                                        onchange="fn(this)"
                                                        data-name="${prodDetailDto.name}"
                                                        data-size="${size.size}"
                                                        data-size-no="${size.no}"
                                                        data-color="${sizeAmountDto.name}"
                                                        data-color-no="${sizeAmountDto.no}"
                                                        data-no="${prodDetailDto.no}"
                                                        >
                                                        <label class="${size.amount == 0 ? "btn btn-outline-danger fixed-size w-100 d-flex align-items-center justify-content-between disabled": "btn btn-outline-secondary fixed-size w-100 d-flex align-items-center justify-content-between"}" for="size${size.size}">
                                                            <span class="ms-2">${size.size}</span>
                                                            <span class="badge bg-secondary">재고:${size.amount}</span>
                                                        </label>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                    <hr class="bg-primary border border-1">
                                    <!--
                                        선택한 상품과 수량
                                    -->
                                    <form id="form-cart" method="post">
                                        <div id="cart" class="d-flex  p-2 border row">

                                        </div>
                                        <hr class="bg-primary border border-1">

                                        <div class="text-end mb-3">
                                            총액: <strong id="total-price">0</strong> 원 (<small id="total-stock">0</small> 개)
                                        </div>
                                        <div class="text-end mb-3">
                                            <button class="btn btn-outline-secondary" type="button" id="cart-add">장바구니 추가</button>
                                            <button class="btn btn-outline-secondary" type="button" id="wish-add" >위시리스트 추가</button>
                                        </div>
                                    </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 리뷰 -->
<div class="actions d-flex justify-content-between mb-4">
      <!-- 로그인 여부를 체크하기 위해 먼저 선언 -->
      <security:authorize access="isAuthenticated()">
        <div>
          <!-- principal 프로퍼티 안의 loginUser 정보를 가져옴 -->
          <!-- loginUser.no를 가져와서 조건문 실행 -->
          <c:if test="${loginUser.no == user.no}">
            <button class="btn btn-warning" onclick="updateBoard(${user.no})">수정</button>
            <button class="btn btn-danger" onclick="deleteBoard(${user.no})">삭제</button>
          </c:if>
          <c:if test="${loginUser.no == user.no}">
            <button type="button" class="btn btn-danger" onclick="report('board', )">신고</button>
          </c:if>

        </div>
        <div>
          <button class="btn btn-outline-primary" id="likeCnt"
                  onclick="boardLikeButton(${user.no}, ${loginUser.no})">
            <i id="icon-heart"
               class="bi"></i>
          </button>
          <a type="button" href="main" class="btn btn-secondary">목록</a>
        </div>
      </security:authorize>
    </div>

    <!-- 댓글 작성 -->
    <div class="comment-form mb-4">
      <h5 style="text-align: start">댓글 작성</h5>
      <form method="get" action="add-reply">
        <input type="hidden" name="boardNo" value="">
        <input type="hidden" name="userNo" value="">
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
    <c:if test="">
      <div class="row comments rounded" style="background-color: #f2f2f2">
        <!--댓글 내용 -->
        <c:forEach var="reply" items="">
          <c:choose>
            <c:when test="">
              <div class="row m-3" style="text-align: start">
                <div class="col d-flex justify-content-between" style="text-align: start">
                  <c:if test="">
                    <i class="bi bi-arrow-return-right"></i>
                  </c:if>
                  <i class="bi bi-emoji-dizzy" style="font-size: 35px; margin-left: 5px;"></i>
                  <div class="col" style="margin-left: 15px">
                    <c:if test="">
                      <strong>삭제된 댓글입니다.</strong><br/>
                    </c:if>
                    <c:if test="">
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
                  <div class="col">
                    <div class="col d-flex justify-content-between">
                      <div class="col-1">
                        <c:if test="">
                          <i class="bi bi-arrow-return-right"></i>
                        </c:if>
                        <img src="https://github.com/mdo.png" alt="" style="width: 50px" class="rounded-circle">
                      </div>
                      <div class="col" style="text-align: start">
                        <strong></strong><br/>
                        <span><fmt:formatDate value="" pattern="yyyy.MM.dd hh:mm:ss"/></span>
                        <c:if test="">
                          <button type="button" class="btn btn-danger"
                                  style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;"
                                  onclick="report('reply',)">
                            신고
                          </button>
                        </c:if>
                      </div>
                      <div class="col-2" style="text-align: end">
                        <security:authorize access="isAuthenticated()">
                          <c:if test="">
                            <button class="btn btn-outline-primary btn-sm" id="replyLikeCnt"
                                    onclick="replyLikeButton()">
                              <i id="icon-thumbs"
                                 class="bi "></i>
                            </button>
                          </c:if>
                          <c:if test="">
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
                      <c:if test="">
                        <button type="button" class="btn btn-outline-dark btn-sm d-flex justify-content-start mb-3"
                                name="replyContent" onclick="appendComment()">
                          답글
                        </button>
                      </c:if>

                      <form method="post" action="add-comment" id="box-comments-" class="my-3 d-none">
                        <input type="hidden" name="no" value="">
                        <input type="hidden" name="prevNo" value="">
                        <input type="hidden" name="boardNo" value="">
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
</div>
<script type="text/javascript">



    function fn(el) {
        let prodNo = el.getAttribute("data-no"); // 상품 번호
        let size = el.getAttribute("data-size"); // 상품 사이즈
        let sizeNo = el.getAttribute("data-size-no"); // 상품 사이즈 번호
        let name = el.getAttribute("data-name"); // 상품명
        let color = el.getAttribute("data-color"); // 상품 색상명
        let colorNum = el.getAttribute("data-color-no"); // 색상 번호

        let content = `
                 <div id="item-\${sizeNo}">
                      <input type="hidden" name="prodNo" value="\${prodNo}"/>
                      <input type="hidden" name="size" value="\${size}"/>
                      <input type="hidden" name="sizeNo" value="\${sizeNo}"/>
                      <input type="hidden" name="colorNo" value="\${colorNum}"/>
                     <span><small>\${name} </small></span>
                     <p><small>- \${color} / \${size}</small></p>
                     <input type="button" value=" - " name="minus" data-no="\${sizeNo}">
                     <input type="text" name="stock" value="1" id="stock-\${sizeNo}" size="3" max="" style="width: 3rem; text-align: center">
                     <input type="button" value=" + " name="plus" data-no="\${sizeNo}">
                     <div class="text-end">
                        <small><strong id="price-\${sizeNo}"><fmt:formatNumber value="${prodDetailDto.price }"/></strong>원</small>
                        <button type="button" class="btn btn-lg delete-button" data-target-id="#item-\${sizeNo}"><i class="bi bi-x"></i></button>
                     </div>
                     <hr class="bg-primary border border-1">
                 </div>

        `

        $("#cart").append(content);
        updateTotals();
    }

    // 삭제하는 기능
    $("#cart").on('click', '.delete-button', function() {
        let id = $(this).data("target-id");
        $(id).remove();
        updateTotals();
    })

    $("#cart").on('click', 'input[name=minus]', function(){
        let no = $(this).attr("data-no");
        // 수량
        let amountInput = document.querySelector('#stock-' + no);
        let currentValue = parseInt(amountInput.value);

        if(currentValue > 1) {
            amountInput.value = currentValue - 1;
            updatePrice(no)
            updateTotals();
        }
    })

    $("#cart").on('click', 'input[name=plus]', function(){
        let no = $(this).attr("data-no");
        let amountInput = document.querySelector('#stock-' + no);
        let currentValue = parseInt(amountInput.value);
        amountInput.value = currentValue + 1;
        updatePrice(no);

        updateTotals();

    })

    // 금액 업데이트 함수
    const updatePrice = (no) => {
        // 수량
        let amountInput = document.querySelector('#stock-' + no);
        // 단가
        let eachPrice = ${prodDetailDto.price};
        // 총액
        let totalPrice = document.getElementById('price-' + no);
        let quantity = parseInt(amountInput.value) || 1;
        let total = eachPrice * quantity;

        totalPrice.textContent = total.toLocaleString();
    }

    // 총금액과 총수량을 계산하는 기능
    const updateTotals = () => {
        // 총 금액 초기화
        let totalPrice = 0;
        // 총 수량 초기화
        let totalStock = 0;

        // 누적 총금액
        let x = $("#cart strong[id^=price]").each(function() {
            let price = $(this).text().replaceAll(/,/g, "");
            totalPrice += parseInt(price)

        });

        // 누적 총수량
        let y = $("#cart input[id^=stock]").each(function() {
            let stock = $(this).val();
            totalStock += parseInt(stock);
        });

        // 출력
        $("#total-price").text(totalPrice.toLocaleString());
        $("#total-stock").text(totalStock.toLocaleString());
    }

    // 이미지 클릭시 화면 대표 이미지 변경
    $(".box-small-img img").click(function () {
        let bigImgPath = $(this).data("big-img-path");
        console.log(bigImgPath);
        $("#big-img").attr("src", bigImgPath);
    });

    // 장바구니에 전달
    $("#cart-add").click(function () {
        alert("장바구니에 담겼습니다.");
        $("#form-cart").attr("action", "/mypage/cart");
        $("#form-cart").trigger("submit");
    });

    // 위시리스트에 전달
    $("#wish-add").click(function () {
        alert("위시리스트에 담겼습니다.");
        $("#form-cart").attr("action", "/mypage/wish");
        $("#form-cart").trigger("submit");
    });

</script>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
