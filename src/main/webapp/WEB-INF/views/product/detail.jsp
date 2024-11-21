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
                <div class="mb-3">
                    <img src="https://ecimg.cafe24img.com/pg90b05313110010/brooksrunning/web/product/big/20240102/6531af333e9506981bed79075102fe43.png"/>
                </div>
                <div>
                    <img src="https://ecimg.cafe24img.com/pg90b05313110010/brooksrunning/web/product/big/20240102/6531af333e9506981bed79075102fe43.png" width="20%" />
                    <img src="https://ecimg.cafe24img.com/pg90b05313110010/brooksrunning/web/product/big/20240102/6531af333e9506981bed79075102fe43.png" width="20%" />
                    <img src="https://ecimg.cafe24img.com/pg90b05313110010/brooksrunning/web/product/big/20240102/6531af333e9506981bed79075102fe43.png" width="20%" />
                    <img src="https://ecimg.cafe24img.com/pg90b05313110010/brooksrunning/web/product/big/20240102/6531af333e9506981bed79075102fe43.png" width="20%" />
                    <img src="https://ecimg.cafe24img.com/pg90b05313110010/brooksrunning/web/product/big/20240102/6531af333e9506981bed79075102fe43.png" width="20%" />
                    <img src="https://ecimg.cafe24img.com/pg90b05313110010/brooksrunning/web/product/big/20240102/6531af333e9506981bed79075102fe43.png" width="20%" />
                    <img src="https://ecimg.cafe24img.com/pg90b05313110010/brooksrunning/web/product/big/20240102/6531af333e9506981bed79075102fe43.png" width="20%" />
                    <img src="https://ecimg.cafe24img.com/pg90b05313110010/brooksrunning/web/product/big/20240102/6531af333e9506981bed79075102fe43.png" width="20%" />
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
                                <form method="post">
                                    <div class="mb-4">
                                        <div class="mb-4">
                                            <label class="form-label d-block">사이즈를 선택하세요:</label>
                                            <div class="row row-cols-5 g-3">
                                                <!-- 사이즈 버튼 -->
                                                <c:forEach var="size" items="${sizeAmountDto.sizes }">
                                                    <div class="col">
                                                        <input type="radio" class="btn-check" name="Size" id="size${size.size}" value="${size.size}" required onclick="function getCart() {

                                                        }">
                                                        <label class="btn btn-outline-secondary fixed-size w-100 d-flex align-items-center justify-content-between" for="size${size.size}">
                                                            <span class="ms-2">${size.size}</span>
                                                            <span class="badge bg-secondary">재고:${size.amount}</span>
                                                        </label>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                    <hr class="bg-primary border border-1">
                                    <div class="text-end mb-3">
                                        <button class="btn btn-outline-secondary" type="submit" >장바구니 추가</button>
                                        <button class="btn btn-outline-secondary" type="submit" >위시리스트 추가</button>
                                    </div>
                                </form>
                            </div>
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
</div>
<script type="text/javascript">
    const commentFormModal = new bootstrap.Modal('#form-review-modal');

    function openCommentFormModal() {
        commentFormModal.show();
    }

</script>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
