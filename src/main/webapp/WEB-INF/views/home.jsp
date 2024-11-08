<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<main>
    <!-- 메인 이미지 캐러셀 -->
    <div id="carouselExample" class="carousel slide">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="../../resources/img/cat.png" class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
                <img src="../../resources/img/cat.png" class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
                <img src="../../resources/img/cat.png" class="d-block w-100" alt="...">
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>

    <!-- 알림형 광고배너 -->
    <section class="container my-5">
    <div class="alert alert-warning alert-dismissible fade show" role="alert">
        <strong>특별 할인!</strong> 이번 주 한정, 모든 제품에 20% 할인 혜택이 제공됩니다. 지금 쇼핑하세요!
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    </section>

    <!-- 베스트 상품 랭킹 -->
    <section class="container my-5">
        <div class="row">
            <div class="col-10 d-flex align-items-center">
                <h3>베스트 상품 랭킹</h3>
            </div>
            <div class="col-2 d-flex justify-content-end">
                <button class="btn btn-outline-secondary" type="button" data-bs-target="#weeklyRankingCarousel" data-bs-slide="prev">Prev</button>
                <button class="btn btn-outline-secondary" type="button" data-bs-target="#weeklyRankingCarousel" data-bs-slide="next">Next</button>
            </div>
        </div>
        <div id="weeklyRankingCarousel" class="carousel slide mt-3" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="card text-center">
                                <img src="../../resources/img/cat.png" class="card-img-top" alt="상품 1">
                                <div class="card-body">
                                    <h5 class="card-title">상품명 1</h5>
                                    <p class="card-text">₩12,000</p>
                                    <span class="badge bg-warning">#1</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card text-center">
                                <img src="../../resources/img/cat.png" class="card-img-top" alt="상품 2">
                                <div class="card-body">
                                    <h5 class="card-title">상품명 2</h5>
                                    <p class="card-text">₩13,000</p>
                                    <span class="badge bg-secondary">#2</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card text-center">
                                <img src="../../resources/img/cat.png" class="card-img-top" alt="상품 3">
                                <div class="card-body">
                                    <h5 class="card-title">상품명 3</h5>
                                    <p class="card-text">₩15,000</p>
                                    <span class="badge bg-info">#3</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card text-center">
                                <img src="../../resources/img/cat.png" class="card-img-top" alt="상품 4">
                                <div class="card-body">
                                    <h5 class="card-title">상품명 4</h5>
                                    <p class="card-text">₩9,000</p>
                                    <span class="badge bg-dark">#4</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 러닝화 주간 랭킹 -->
    <section class="container">
        <div class="row">
            <div class="col-md-6 mb-4">
                <h3>러닝화 주간 랭킹</h3>
                <ul class="list-group">
                    <li class="list-group-item d-flex align-items-center">
                        <span class="fw-bold me-3">1</span>
                        <img src="../../resources/img/img1.png" alt="러닝화 1" width="50" class="me-3">
                        <span>러닝화 1</span>
                        <span class="ms-auto"><i class="bi bi-arrow-up"></i></span>
                    </li>
                    <li class="list-group-item d-flex align-items-center">
                        <span class="fw-bold me-3">2</span>
                        <img src="../../resources/img/img1.png" alt="러닝화 2" width="50" class="me-3">
                        <span>러닝화 2</span>
                        <span class="ms-auto"><i class="bi bi-arrow-down"></i></span>
                    </li>
                    <li class="list-group-item d-flex align-items-center">
                        <span class="fw-bold me-3">3</span>
                        <img src="../../resources/img/img1.png" alt="러닝화 3" width="50" class="me-3">
                        <span>러닝화 3</span>
                        <span class="ms-auto"><i class="bi bi-arrow-up"></i></span>
                    </li>
                    <li class="list-group-item d-flex align-items-center">
                        <span class="fw-bold me-3">4</span>
                        <img src="../../resources/img/img1.png" alt="러닝화 4" width="50" class="me-3">
                        <span>러닝화 4</span>
                        <span class="ms-auto"><i class="bi bi-arrow-down"></i></span>
                    </li>
                    <li class="list-group-item d-flex align-items-center">
                        <span class="fw-bold me-3">5</span>
                        <img src="../../resources/img/img1.png" alt="러닝화 5" width="50" class="me-3">
                        <span>러닝화 5</span>
                        <span class="ms-auto"><i class="bi bi-arrow-down"></i></span>
                    </li>
                </ul>
            </div>

            <!-- 이벤트 게시판 섹션 -->
            <div class="col-md-6 mb-4">
                <h3 class="d-flex align-items-center">
                    <span class="ms-3">이벤트 게시판</span>
                </h3>
                <ul class="list-group">
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <span>2024-11-01</span>
                        <span>이벤트 제목 1</span>
                        <a href="#" class="btn btn-sm btn-primary">바로가기</a>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <span>2024-11-02</span>
                        <span>이벤트 제목 2</span>
                        <a href="#" class="btn btn-sm btn-primary">바로가기</a>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <span>2024-11-03</span>
                        <span>이벤트 제목 3</span>
                        <a href="#" class="btn btn-sm btn-primary">바로가기</a>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <span>2024-11-05</span>
                        <span>이벤트 제목 4</span>
                        <a href="#" class="btn btn-sm btn-primary">바로가기</a>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <span>2024-11-06</span>
                        <span>이벤트 제목 5</span>
                        <a href="#" class="btn btn-sm btn-primary">바로가기</a>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <span>2024-11-08</span>
                        <span>이벤트 제목 6</span>
                        <a href="#" class="btn btn-sm btn-primary">바로가기</a>
                    </li>
                </ul>
            </div>

        </div>
    </section>


    <!-- 커뮤니티 게시판 -->
    <section class="container my-5">
        <h3>커뮤니티</h3>
        <div class="list-group">
            <!-- 게시글 1 -->
            <a href="#" class="list-group-item list-group-item-action d-flex">
                <div class="col-9">
                    <span>게시글 1</span>
                </div>
                <div class="col-1 text-right">
                    <small>김습후 </small>
                </div>
                <div class="col-1 text-right">
                    <small>2024-11-07 </small>
                </div>
                <div class="col-1 text-right">
                    <small>125</small>
                </div>
            </a>
            <!-- 게시글 2 -->
            <a href="#" class="list-group-item list-group-item-action d-flex">
                <div class="col-9">
                    <span>게시글 2</span>
                </div>
                <div class="col-1 text-right">
                    <small>김습후 </small>
                </div>
                <div class="col-1 text-right">
                    <small>2024-11-07 </small>
                </div>
                <div class="col-1 text-right">
                    <small>125</small>
                </div>
            </a>
            <!-- 게시글 3 -->
            <a href="#" class="list-group-item list-group-item-action d-flex">
                <div class="col-9">
                    <span>게시글 3</span>
                </div>
                <div class="col-1 text-right">
                    <small>김습후 </small>
                </div>
                <div class="col-1 text-right">
                    <small>2024-11-07 </small>
                </div>
                <div class="col-1 text-right">
                    <small>125</small>
                </div>
            </a>
        </div>
    </section>





    <!-- 레슨 목록 & 이벤트 게시판 -->
    <section class="container my-5">
        <h3>레슨 목록</h3>
        <div class="row">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">레슨 1</h5>
                        <p class="card-text">내용 1</p>
                        <a href="#" class="btn btn-primary">레슨 예약</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">레슨 2</h5>
                        <p class="card-text">내용 2</p>
                        <a href="#" class="btn btn-primary">레슨 예약</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">레슨 3</h5>
                        <p class="card-text">내용 3</p>
                        <a href="#" class="btn btn-primary">레슨 예약</a>
                    </div>
                </div>
            </div>
        </div>
    </section>



</main>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
