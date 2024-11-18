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
                                        <td colspan="3">남성 글리세린 21 블랙 (MEDIUM)</td>
                                    </tr>
                                    <tr>
                                        <th>상품 가격</th>
                                        <td colspan="3">199,000 원</td>
                                    </tr>
                                    <tr>
                                        <th>평점</th>
                                        <td>4.8</td>
                                        <th>조회수</th>
                                        <td>10</td>
                                    </tr>
                                    <tr>
                                        <th>상품 설명</th>
                                        <td colspan="3">최상의 부드러움과 최고의 편안함으로 러너들의 사랑을 받고 있는 브룩스의 시그니처 러닝화 </td>
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
                            <div class="card-body">
                                <form method="post">
                                    <div class="mb-4">
                                        <label class="form-label">색상을 선택하세요</label>
                                        <select class="form-select" name="color">
                                            <option value="" disabled selected>색상을 선택하세요</option>
                                            <option value="black">블랙</option>
                                            <option value="white">화이트</option>
                                            <option value="mango">망고</option>
                                            <option value="bolt">볼트</option>
                                        </select>
                                    </div>
                                    <div class="mb-4">
                                        <div class="mb-4">
                                            <label class="form-label d-block">사이즈를 선택하세요:</label>
                                            <div class="row row-cols-5 g-3">
                                                <!-- 사이즈 버튼 -->
                                                <div class="col">
                                                    <input type="radio" class="btn-check" name="shoeSize" id="size250" value="250" required onclick="function getCart() {

                                                }">
                                                    <label class="btn btn-outline-secondary fixed-size w-100 d-flex align-items-center justify-content-between" for="size250">
                                                        <span>250</span>
                                                        <span class="badge bg-secondary">재고: 10</span>
                                                    </label>
                                                </div>
                                                <div class="col">
                                                    <input type="radio" class="btn-check" name="shoeSize" id="size255" value="255">
                                                    <label class="btn btn-outline-secondary fixed-size w-100 d-flex align-items-center justify-content-between" for="size255">
                                                        <span>255</span>
                                                        <span class="badge bg-secondary">재고: 10</span>
                                                    </label>
                                                </div>
                                                <div class="col">
                                                    <input type="radio" class="btn-check" name="shoeSize" id="size260" value="260" disabled>
                                                    <label class="btn btn-outline-danger fixed-size w-100 d-flex align-items-center justify-content-between" for="size260">
                                                        <span>260</span>
                                                        <span class="badge bg-danger">품절</span>
                                                    </label>
                                                </div>
                                                <div class="col">
                                                    <input type="radio" class="btn-check" name="shoeSize" id="size265" value="265">
                                                    <label class="btn btn-outline-secondary fixed-size w-100 d-flex align-items-center justify-content-between" for="size265">
                                                        <span>265</span>
                                                        <span class="badge bg-secondary">재고: 10</span>
                                                    </label>
                                                </div>
                                                <div class="col">
                                                    <input type="radio" class="btn-check" name="shoeSize" id="size270" value="270">
                                                    <label class="btn btn-outline-secondary fixed-size w-100 d-flex align-items-center justify-content-between" for="size270">
                                                        <span>270</span>
                                                        <span class="badge bg-secondary">재고: 10</span>
                                                    </label>
                                                </div>

                                                <!-- 두 번째 줄 -->
                                                <div class="col">
                                                    <input type="radio" class="btn-check" name="shoeSize" id="size275" value="275">
                                                    <label class="btn btn-outline-secondary fixed-size w-100 d-flex align-items-center justify-content-between" for="size275">
                                                        <span>275</span>
                                                        <span class="badge bg-secondary">재고: 10</span>
                                                    </label>
                                                </div>
                                                <div class="col">
                                                    <input type="radio" class="btn-check" name="shoeSize" id="size280" value="280">
                                                    <label class="btn btn-outline-secondary fixed-size w-100 d-flex align-items-center justify-content-between" for="size280">
                                                        <span>280</span>
                                                        <span class="badge bg-secondary">재고: 10</span>
                                                    </label>
                                                </div>
                                                <div class="col">
                                                    <input type="radio" class="btn-check" name="shoeSize" id="size285" value="285">
                                                    <label class="btn btn-outline-secondary fixed-size w-100 d-flex align-items-center justify-content-between" for="size285">
                                                        <span>285</span>
                                                        <span class="badge bg-secondary">재고: 10</span>
                                                    </label>
                                                </div>
                                                <div class="col">
                                                    <input type="radio" class="btn-check" name="shoeSize" id="size290" value="290">
                                                    <label class="btn btn-outline-secondary fixed-size w-100 d-flex align-items-center justify-content-between" for="size290">
                                                        <span>290</span>
                                                        <span class="badge bg-secondary">재고: 10</span>
                                                    </label>
                                                </div>
                                                <div class="col">
                                                    <input type="radio" class="btn-check" name="shoeSize" id="size295" value="295">
                                                    <label class="btn btn-outline-secondary fixed-size w-100 d-flex align-items-center justify-content-between" for="size295">
                                                        <span>295</span>
                                                        <span class="badge bg-secondary">재고: 10</span>
                                                    </label>
                                                </div>
                                                <div class="col">
                                                    <input type="radio" class="btn-check" name="shoeSize" id="size300" value="300">
                                                    <label class="btn btn-outline-secondary fixed-size w-100 d-flex align-items-center justify-content-between" for="size300">
                                                        <span>300</span>
                                                        <span class="badge bg-secondary">재고: 10</span>
                                                    </label>
                                                </div>
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
    </div>
</div>

<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
