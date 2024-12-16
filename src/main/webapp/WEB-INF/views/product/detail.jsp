<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
    <style>
        .star-rating {
            font-size: 2rem;
            cursor: pointer;
        }
        .star-rating .star {
            color: #ddd;
        }
        .star-rating .star.selected {
            color: gold;
        }
    </style>
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
                                                <a href="/product/hit?no=${p.product.no}&colorNo=${p.no}"><img src="${im.url}" width=15%/></a>
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
    </div>

    <!--
        리뷰
     -->
    <hr class="bg-primary border border-1">
    <div class="comment-form mb-4">
        <h5 style="text-align: start; font-weight: bold;">리뷰 작성</h5>
        <form method="post" action="/reviews/review-write" enctype="multipart/form-data">
            <input type="hidden" name="prodNo" value="${prodDetailDto.no}">
            <input type="hidden" name="userNo" value="${user.no}">

            <!-- 별점과 댓글 입력 -->
            <div class="row mb-3">
                <!-- 별점 -->
                <div class="col-2" style="text-align: left;">
                    <label class="form-label" style="font-weight: bold;">별점</label>
                    <div class="star-rating" id="commentStarRating" style="font-size: 1.5rem;">
                        <span class="star" data-value="1">&#9733;</span>
                        <span class="star" data-value="2">&#9733;</span>
                        <span class="star" data-value="3">&#9733;</span>
                        <span class="star" data-value="4">&#9733;</span>
                        <span class="star" data-value="5">&#9733;</span>
                    </div>
                    <input type="hidden" name="rating" id="commentRating" value="0">
                </div>

                <!-- 댓글 입력 -->
                <div class="col-10">
                    <textarea name="content" id="commentContent" class="form-control" rows="3" placeholder="댓글을 작성하세요." style="resize: none;"></textarea>
                </div>
            </div>

            <!-- 버튼 영역 -->
            <div class="row">
                <div class="col text-end">
                    <!-- 이미지 업로드 버튼과 등록 버튼을 나란히 정렬 -->
                    <button type="button" class="btn btn-primary me-2" id="openUploadModalBtn">이미지 업로드</button>
                    <input type="file" name="files" accept="image/*" multiple>
                    <button type="submit" class="btn btn-success" onclick="submitReply()">등록</button>
                </div>
            </div>
        </form>
    </div>

    <!-- 이미지 업로드 모달 -->
    <div class="modal fade" id="uploadImageModal" tabindex="-1" aria-labelledby="uploadImageModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="uploadImageModalLabel">이미지 업로드</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="imageUploadForm">
                        <div class="mb-3">
                            <label for="imageFile" class="form-label">이미지 선택</label>
                            <input class="form-control" type="file" id="imageFile" accept="image/*">
                        </div>
                        <div id="imagePreview" class="mb-3">
                            <!-- 업로드된 이미지 미리보기 -->
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" id="addImageToComment">추가</button>
                </div>
            </div>
        </div>
    </div>
    <hr class="bg-primary border border-1">


    <div class="row comments rounded py-3" style="background-color: #f2f2f2">
        <c:choose>
            <c:when test="${empty prodReviewDto}">
                <div class="text-center py-4">
                    <p style="font-size: 1.2rem; color: #555;">아직 등록된 리뷰가 없습니다. 첫 번째 리뷰를 작성해보세요!</p>
                </div>
            </c:when>

            <c:otherwise>
                <c:forEach var="review" items="${prodReviewDto}">
                    <div class="comment">
                            <div class="row align-items-center">
                                <div class="col-3" style="text-align: start;">
                                    <img src="https://github.com/mdo.png" alt="프로필 이미지" style="width: 50px; height: 50px;" class="rounded-circle mb-2">


                                    <strong>${review.userNickname}</strong><br/>


                                    <span style="font-size: 0.9rem; color: #555;">${review.reviewDate}</span><br/>


                                    <span style="font-size: 0.9rem; color: #555;">${review.prodName} [${review.colorName}]</span>


                                    <div class="star-rating" style="font-size: 1.2rem; color: gold;">
                                        &#9733;&#9733;&#9733;&#9733;&#9734;
                                    </div>
                                    <div class="mt-1">
                                        <button class="btn btn-outline-secondary">답글</button>
                                    </div>
                                </div>


                                <div class="col">
                                    <div class="mt-2">
                                        <c:forEach var="img" items="${review.prodReviewImgs}">
                                            <img src="${img.imgName}" alt="리뷰 이미지" class="img-fluid" style="max-height: 100px; object-fit: cover;">
                                        </c:forEach>
                                    </div>

                                    <p style="margin: 3px;">${review.reviewContent}</p>
                                </div>

                                <div class="col-2 text-end">
                                    <button type="button" class="btn btn-warning btn-sm">수정</button>
                                    <button type="button" class="btn btn-danger btn-sm">삭제</button>
                                </div>
                            </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
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

        // 중복되어 있는 상품
        let box = document.querySelector("#item-" + sizeNo);
        if (box) {
            let stockInput = box.querySelector(`#item-\${sizeNo} input[name=stock]`);
            stockInput.value = parseInt(stockInput.value) + 1;
        } else {

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

        }
        updatePrice(sizeNo);
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

    $(document).ready(function () {
        // 별점 클릭 시
        $("#commentStarRating .star").click(function () {
            var ratingValue = $(this).data("value"); // 클릭한 별의 값 가져오기

            // 별점 값 저장
            $("#commentRating").val(ratingValue);

            // 별점 하이라이트
            $("#commentStarRating .star").each(function () {
                if ($(this).data("value") <= ratingValue) {
                    $(this).css("color", "gold"); // 선택한 별과 이전 별은 금색
                } else {
                    $(this).css("color", "#ddd"); // 나머지는 회색
                }
            });
        });

        // 초기 별점 하이라이트 설정
        $("#commentStarRating .star").each(function () {
            var ratingValue = $("#commentRating").val();
            if ($(this).data("value") <= ratingValue) {
                $(this).css("color", "gold");
            } else {
                $(this).css("color", "#ddd");
            }
        });
    });

    $(document).ready(function () {
        // 이미지 업로드 모달 열기
        $("#openUploadModalBtn").click(function () {
            $("#uploadImageModal").modal("show");
        });

        // 이미지 파일 선택 시 미리보기
        $("#imageFile").change(function () {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    $("#imagePreview").html(`
                    <img src="${e.target.result}" alt="업로드 이미지" style="max-width: 100%; height: auto;" class="rounded">
                `);
                };
                reader.readAsDataURL(file);
            }
        });

        // 이미지 추가 버튼 클릭 시 댓글 입력창에 삽입
        $("#addImageToComment").click(function () {
            const fileInput = $("#imageFile")[0];
            if (fileInput.files.length > 0) {
                const file = fileInput.files[0];
                const reader = new FileReader();
                reader.onload = function (e) {
                    // 댓글 입력창에 이미지 삽입
                    const imgTag = `<img src="${e.target.result}" alt="첨부 이미지" style="max-width: 100%; height: auto; margin-top: 10px;">\n`;
                    const commentContent = $("#commentContent").val();
                    $("#commentContent").val(commentContent + "\n" + imgTag);

                    // 모달 닫기
                    $("#uploadImageModal").modal("hide");

                    // 초기화
                    $("#imageFile").val("");
                    $("#imagePreview").empty();
                };
                reader.readAsDataURL(file);
            } else {
                alert("이미지를 선택해주세요.");
            }
        });
    });
</script>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
