<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>SB Admin 2 - Dashboard</title>

  <!-- Custom fonts for this template-->
  <link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link
          href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
          rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body id="page-top">

<!-- Page Wrapper -->
    <div id="wrapper">
      <!-- Sidebar -->
      <%@include file="/WEB-INF/views/admincommon/sidebar.jsp" %>
      <!-- End of Sidebar -->
      <!-- Content Wrapper -->
      <div id="content-wrapper" class="d-flex flex-column">
        <!-- Main Content -->
        <div id="content">
          <!-- Topbar -->
          <%@include file="/WEB-INF/views/admincommon/topbar.jsp" %>
          <!-- End of Topbar -->
          <!-- Begin Page Content -->
          <div class="container-fluid">
            <!-- Page Heading -->
            <div class="d-sm-flex align-items-center justify-content-between mb-4">
              <h1 class="h3 mb-0 text-gray-800">상품 상세 페이지</h1>
            </div>
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
                                        <h4>상품 옵션</h4>
                                    </div>
                                    <div>색상을 선택하세요:</div>
                                    <div class="card-body">
                                        <div class="mb-4">
                                            <c:forEach var="p" items="${colorProdImgDto}">
                                                    <c:forEach var="im" items="${p.images}">
                                                        <a href="product-detail?no=${p.product.no}&colorNo=${p.no}"><img src="${im.url}" width=15%/></a>
                                                    </c:forEach>
                                            </c:forEach>
                                        </div>
                                            <div class="mb-4">
                                                <div class="mb-4">
                                                    <label class="form-label d-block">사이즈</label>
                                                    <div class="row row-cols-5 g-3">
                                                        <!-- 사이즈 버튼 -->
                                                        <c:forEach var="size" items="${sizeAmountDto.sizes }" varStatus="loop">
                                                            <div class="col">
                                                                <input type="radio" class="btn-check" name="size" id="size${size.size}" value="${size.size}" required
                                                                onchange="fn(this)"
                                                                data-name="${prodDetailDto.name}"
                                                                data-size="${size.size}"
                                                                data-size-no="${loop.count}"
                                                                data-color="${sizeAmountDto.name}"
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
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row m-2">
                            <div class="mr-2">
                                <a href="register-editform?no=${param.no}&colorNo=${param.colorNo}">
                                    <button class="btn btn-outline btn-success btn-sm">상품 수정&대표 색상 설정</button>
                                </a>
                            </div>
                            <div class="mr-2">
                              <a href="register-color?no=${param.no}">
                                <button class="btn btn-outline btn-success btn-sm">상품 색상 추가</button>
                              </a>
                            </div>
                        </div>
                        <div class="row m-2">
                            <div class="mr-2">
                                <a href="register-size?no=${param.no}&colorNo=${param.colorNo}">
                                    <button class="btn btn-outline btn-success btn-sm">상품 사이즈 추가</button>
                                </a>
                            </div>
                            <div class="mr-2">
                                <a href="delete-size?no=${param.no}&colorNo=${param.colorNo}">
                                    <button class="btn btn-outline btn-success btn-sm">상품 사이즈 삭제</button>
                                </a>
                            </div>
                        </div>
                        <div class="row m-2">
                            <div class="mr-2">
                                <a href="register-image?no=${param.no}">
                                    <button class="btn btn-outline btn-success btn-sm">상품 이미지 추가</button>
                                </a>
                            </div>
                            <div class="mr-2">
                                <a href="image-changeThumb?no=${param.no}&colorNo=${param.colorNo}">
                                    <button class="btn btn-outline btn-success btn-sm">대표 이미지 설정</button>
                                </a>
                            </div>
                            <div class="mr-2">
                                <a href="image-editform?no=${param.no}&colorNo=${param.colorNo}">
                                    <button class="btn btn-outline btn-success btn-sm">상품 이미지 편집</button>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 리뷰 -->
            <div class="row mb-3">
                <div class="col">
                    <div class="border p-2 bg-secondary text-white fw-bold d-flex justify-content-between">
                        <span>리뷰 리스트</span>
                            <button class="btn btn-light btn-sm" id="btn-show-review-modal" onclick="openCommentFormModal()">리뷰쓰기</button>
                    </div>
                </div>
            </div>
            <div class="row mb-3">
                <div class="col">
                    <ul class="list-group">
                        <li class="list-group-item">
                            <div class="row mb-1">
                                <div class="col-10"><span class="fw-bold">너무 좋아요</span></div>
                                <div class="col-2 text-end"><small>2024-11-19-15:16:04</small></div>
                            </div>
                            <div class="row">
                                <div class="col-10">너무 좋은 제품이라 또 사고 싶습니다.</div>
                                <div class="col-2 text-end"><a href="deleteReview?no=10&productNo=10" class="text-danger"><small><i class="fas fa-trash"></i></small></a></div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            <!-- 리뷰 쓰기 모달 창 -->
            <div class="modal fade" id="form-review-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <form id="form-review" method="post" action="addReview">
                        <input type="hidden" name="productNo" value="">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">새 리뷰쓰기</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="text-danger" id="form-alert">제목과 내용은 필수입력값입니다.</div>
                                <div class="row mb-1 p-2">
                                    <input type="text" class="form-control" id="review-title" name="title" placeholder="제목을 입력하세요">
                                </div>
                                <div class="row mb-1 p-2">
                                    <textarea rows="5" class="form-control" id="review-content" name="content" placeholder="내용을 입력하세요"></textarea>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                                <button type="submit" class="btn btn-primary" id="btn-add-review">등록</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
          </div>
          <!-- end Page Content -->
        </div>
      </div>
    </div>
<!-- Footer -->
<%@include file="/WEB-INF/views/admincommon/footer.jsp" %>
<!-- End of Footer -->

<%@include file="/WEB-INF/views/admincommon/common.jsp" %>
</body>
<script>
    // 댓글 폼
    const commentFormModal = new bootstrap.Modal('#form-review-modal');

    // 댓글 폼 모달 열기
    function openCommentFormModal() {
        commentFormModal.show();
    }

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

    // 이미지 클릭시 화면 대표 이미지 변경
    $(".box-small-img img").click(function () {
        let bigImgPath = $(this).data("big-img-path");
        console.log(bigImgPath);
        $("#big-img").attr("src", bigImgPath);
    });
</script>


</html>


