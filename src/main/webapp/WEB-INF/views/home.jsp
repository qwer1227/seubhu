<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <style>
        /* 이미지 위에 아이콘 버튼을 겹치도록 */
        .icon-overlay {
            position: absolute;
            top: 10px;
            right: 10px;
        }

        /* 아이콘 버튼 스타일 설정 */
        .icon-button {
            background-color: transparent;
            border: none;
            color: #ffffff;
            font-size: 1.5rem;
        }

        .icon-button:hover {
            color: #f39c12; /* 호버 시 아이콘 색상 */
        }

        /* 카드 제목과 텍스트를 명확히 구분 */
        .card-body h5, .card-body p {
            margin: 0;
        }

        /* 광고 팝업 스타일 */
        .ad-popup {
            position: fixed;
            bottom: 100px;
            right: 100px;
            width: 300px;
            background-color: #f8f9fa;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
        }

        .ad-popup img {
            width: 100%;
            border-radius: 8px 8px 0 0;
        }

        .ad-popup .popup-content {
            padding: 15px;
        }

        .ad-popup .popup-content h5 {
            font-size: 1.1rem;
            margin-bottom: 10px;
        }

        .ad-popup .popup-content p {
            font-size: 0.9rem;
        }


    </style>
    <title>습습후후</title>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<main>
    <!-- 메인 이미지 캐러셀 -->
    <section class="container my-5">
        <div id="main-carousel" class="carousel slide">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#main-carousel" data-bs-slide-to="0" class="active"
                        aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#main-carousel" data-bs-slide-to="1"
                        aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#main-carousel" data-bs-slide-to="2"
                        aria-label="Slide 3"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="../../resources/img/nike.jpeg" class="d-block w-100" alt="...">
                </div>
                <div class="carousel-item">
                    <img src="../../resources/img/adidas.jpeg" class="d-block w-100" alt="...">
                </div>
                <div class="carousel-item">
                    <img src="../../resources/img/asics.jpeg" class="d-block w-100" alt="...">
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#main-carousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#main-carousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </section>

    <!-- 알림형 광고배너 -->
    <section class="container my-5">
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            <strong>특별 할인!</strong> 이번 주 한정, 모든 제품에 20% 할인 혜택이 제공됩니다. 지금 쇼핑하세요!
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    </section>

    <section class="container my-5">
        <div class="row">
            <div class="col-10 d-flex align-items-center">
                <h3>베스트 상품 랭킹</h3>
            </div>
            <div class="col-2 d-flex justify-content-end">
                <button class="btn btn-outline-dark" type="button" data-bs-target="#weeklyRankingCarousel"
                        data-bs-slide="prev">
                    <i class="bi bi-chevron-left"></i>
                </button>
                <button class="btn btn-outline-dark" type="button" data-bs-target="#weeklyRankingCarousel"
                        data-bs-slide="next">
                    <i class="bi bi-chevron-right"></i>
                </button>
            </div>
        </div>

        <div id="weeklyRankingCarousel" class="carousel slide mt-3" data-bs-ride="carousel">
            <div class="carousel-inner">
                <!-- 첫 번째 페이지 -->
                <div class="carousel-item active">
                    <div class="row">
                        <c:forEach var="product" items="${bestByRating}">
                        <div class="col-md-3">
                            <div class="card position-relative border-0">
                                <a href="detail?no=${product.no}&colorNo=${product.colorNum}">
                                    <img src="${product.imgThum}" class="card-img-top" alt="상품 1">
                                </a>
                                <div class="icon-overlay d-flex justify-content-center">
                                    <button class="icon-button btn-sm">
                                        <i class="bi bi-heart"></i>
                                    </button>
                                </div>
                                <div class="card-body">
                                    <span class="badge bg-dark">#${product.status}</span>
                                    <h5 class="card-title">${product.name}</h5>
                                    <p class="card-text">${product.price}</p>
                                    <p>${product.brand.name}</p>
                                </div>
                            </div>
                        </div>
                        </c:forEach>
                    </div>
                </div>

                <!-- 두 번째 페이지 -->
                <div class="carousel-item">
                    <div class="row">
                        <c:forEach var="product" items="${bestByRating}">
                        <div class="col-md-3">
                            <div class="card position-relative border-0">
                                <a href="detail?no=${product.no}&colorNo=${product.colorNum}">
                                    <img src="${product.imgThum}" class="card-img-top" alt="상품 5">
                                </a>
                                <div class="icon-overlay d-flex justify-content-center">
                                    <button class="icon-button btn-sm">
                                        <i class="bi bi-heart"></i>
                                    </button>
                                </div>
                                <div class="card-body">
                                    <span class="badge bg-dark">#${product.status}</span>
                                    <h5 class="card-title">${product.name}</h5>
                                    <p class="card-text">${product.price}</p>
                                    <p>${product.brand.name}</p>
                                </div>
                            </div>
                        </div>
                        </c:forEach>
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
                <ul class="list-group border-0">
                    <c:forEach var="product" items="${bestByViewCount}">
                    <li class="list-group-item d-flex align-items-center border-0">
                        <span class="fw-bold me-3">${product.rankByViewCount}</span>
                        <a href="detail?no=${product.no}&colorNo=${product.colorNum}" class="text-decoration-none">
                            <img src="${product.imgThum}" alt="러닝화 1" width="50" class="me-3">
                            <span class="text-muted">${product.name}</span>
                        </a>
                        <span class="ms-auto"><i class="bi bi-arrow-up"></i></span>
                    </li>
                    </c:forEach>
                    <li class="list-group-item d-flex align-items-center border-0">
                        <span class="fw-bold me-3">2</span>
                        <a href="#" class="text-decoration-none">
                            <img src="../../resources/img/nikeS.jpeg" alt="러닝화 2" width="50" class="me-3">
                            <span class="text-muted">러닝화 2</span>
                        </a>
                        <span class="ms-auto"><i class="bi bi-arrow-down"></i></span>
                    </li>
                    <li class="list-group-item d-flex align-items-center border-0">
                        <span class="fw-bold me-3">3</span>
                        <a href="#" class="text-decoration-none">
                            <img src="../../resources/img/nikeS.jpeg" alt="러닝화 3" width="50" class="me-3">
                            <span class="text-muted">러닝화 3</span>
                        </a>
                        <span class="ms-auto"><i class="bi bi-arrow-up"></i></span>
                    </li>
                    <li class="list-group-item d-flex align-items-center border-0">
                        <span class="fw-bold me-3">4</span>
                        <a href="#" class="text-decoration-none">
                            <img src="../../resources/img/nikeS.jpeg" alt="러닝화 4" width="50" class="me-3">
                            <span class="text-muted">러닝화 4</span>
                        </a>
                        <span class="ms-auto"><i class="bi bi-arrow-down"></i></span>
                    </li>
                    <li class="list-group-item d-flex align-items-center border-0">
                        <span class="fw-bold me-3">5</span>
                        <a href="#" class="text-decoration-none">
                            <img src="../../resources/img/nikeS.jpeg" alt="러닝화 5" width="50" class="me-3">
                            <span class="text-muted">러닝화 5</span>
                        </a>
                        <span class="ms-auto"><i class="bi bi-arrow-down"></i></span>
                    </li>
                </ul>
            </div>

            <!-- 이벤트 게시판 섹션 -->
            <div class="col-md-6 mb-4">
                <h3 class="d-flex align-items-center">
                    <span class="ms-3 text-muted">이벤트 게시판</span>
                </h3>
                <ul class="list-group border-0">
                    <li class="list-group-item d-flex justify-content-between align-items-center border-0">
                        <span class="text-muted">2024-11-01</span>
                        <span class="text-muted">이벤트 제목 1</span>
                        <a href="#" class="btn btn-sm btn-dark text-decoration-none">바로가기</a>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center border-0">
                        <span class="text-muted">2024-11-02</span>
                        <span class="text-muted">이벤트 제목 2</span>
                        <a href="#" class="btn btn-sm btn-dark text-decoration-none">바로가기</a>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center border-0">
                        <span class="text-muted">2024-11-03</span>
                        <span class="text-muted">이벤트 제목 3</span>
                        <a href="#" class="btn btn-sm btn-dark text-decoration-none">바로가기</a>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center border-0">
                        <span class="text-muted">2024-11-05</span>
                        <span class="text-muted">이벤트 제목 4</span>
                        <a href="#" class="btn btn-sm btn-dark text-decoration-none">바로가기</a>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center border-0">
                        <span class="text-muted">2024-11-06</span>
                        <span class="text-muted">이벤트 제목 5</span>
                        <a href="#" class="btn btn-sm btn-dark text-decoration-none">바로가기</a>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center border-0">
                        <span class="text-muted">2024-11-08</span>
                        <span class="text-muted">이벤트 제목 6</span>
                        <a href="#" class="btn btn-sm btn-dark text-decoration-none">바로가기</a>
                    </li>
                </ul>
            </div>
        </div>
    </section>

    <!-- 커뮤니티 게시판 -->
    <section class="container my-5">
    <h3 class="text-muted">커뮤니티</h3>
    <div class="list-group">
        <c:forEach var="board" items="${topViewedBoards}">
            <a href="#" class="list-group-item list-group-item-action d-flex border-0 text-decoration-none">
                <div class="col-9">
                    <span class="text-muted">${board.title}</span>
                </div>
                <div class="col-1 text-right">
                    <small class="text-muted">${board.user.nickname}</small>
                </div>
                <div class="col-1 text-right">
                    <small class="text-muted"><fmt:formatDate value="${board.createdDate}" pattern="yyyy-MM-dd"/></small>
                </div>
                <div class="col-1 text-right">
                    <small class="text-muted">${board.viewCnt}</small>
                </div>
            </a>
        </c:forEach>
    </div>
</section>


    <!-- 레슨 목록 -->
    <section class="container my-5">
        <h3 class="text-muted">레슨 목록</h3>
        <div class="row">
            <div class="col-md-4">
                <div class="card border-0">
                    <div class="card-body">
                        <a href="#" class="text-decoration-none">
                            <img src="../../resources/img/adidas.jpeg" class="d-block w-100" alt="SEUB2HU2 ls">
                            <h5 class="card-title text-muted">레슨 1</h5>
                        </a>
                        <p class="card-text text-muted">내용 1</p>
                        <a href="#" class="btn btn-dark text-white">예약하기</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0">
                    <div class="card-body">
                        <a href="#" class="text-decoration-none">
                            <img src="../../resources/img/adidas.jpeg" class="d-block w-100" alt="SEUB2HU2 ls">
                            <h5 class="card-title text-muted">레슨 2</h5>
                        </a>
                        <p class="card-text text-muted">내용 2</p>
                        <a href="#" class="btn btn-dark text-white">예약하기</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0">
                    <div class="card-body">
                        <a href="#" class="text-decoration-none">
                            <img src="../../resources/img/adidas.jpeg" class="d-block w-100" alt="SEUB2HU2 ls">
                            <h5 class="card-title text-muted">레슨 3</h5>
                        </a>
                        <p class="card-text text-muted">내용 3</p>
                        <a href="#" class="btn btn-dark text-white">예약하기</a>
                    </div>
                </div>
            </div>
        </div>
    </section>


    <!-- 광고 팝업 -->
    <div class="ad-popup">
        <div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="../../resources/img/nike.jpeg" class="d-block w-100" alt="SEUB2HU2 Ad">
                    <div class="icon-overlay d-flex justify-content-center">
                        <button type="button" class="btn-close" aria-label="Close"></button>
                    </div>
                    <div class="popup-content text-center">
                        <h5>SEUB2HU2 RUNNING CLASS</h5>
                        <p>습습후후에서 진행하는 전문 레슨과 함께 달리기를 배워보세요.</p>
                        <button class="btn btn-dark btn-sm w-100">MORE</button>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="../../resources/img/adidas.jpeg" class="d-block w-100" alt="SEUB2HU2 Ad">
                    <div class="popup-content text-center">
                        <h5>SEUB2HU2 RUNNING CLASS</h5>
                        <p>습습후후에서 진행하는 전문 레슨과 함께 달리기를 배워보세요.</p>
                        <button class="btn btn-dark btn-sm w-100">MORE</button>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="../../resources/img/asics.jpeg" class="d-block w-100" alt="SEUB2HU2 Ad">
                    <div class="popup-content text-center">
                        <h5>SEUB2HU2 RUNNING CLASS</h5>
                        <p>습습후후에서 진행하는 전문 레슨과 함께 달리기를 배워보세요.</p>
                        <button class="btn btn-dark btn-sm w-100">MORE</button>
                    </div>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleAutoplaying"
                    data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleAutoplaying"
                    data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </div>

    <!-- 우측 하단 세로 배치 버튼 -->
    <div class="position-fixed bottom-0 end-0 p-3">
        <!-- 챗봇 연결 버튼 -->
        <button type="button" class="btn btn-light text-dark mb-3 px-3 py-2 rounded-3 d-block" style="width: 45px;"
                data-bs-toggle="modal" data-bs-target="#chatModal" title="관리자-유저 채팅">
            <i class="bi bi-chat-dots me-2"></i>
        </button>

        <!-- 모달 -->
        <div class="modal fade" id="chatModal" tabindex="-1" aria-labelledby="chatModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="chatModalLabel">관리자-유저 채팅</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- JSP 페이지 로드 -->
                        <iframe src="/chat/chatSend" style="width: 100%; height: 400px; border: none;"></iframe>
                    </div>
                </div>
            </div>
        </div>

        <!-- 탑 버튼 -->
        <a href="#top" class="btn btn-dark text-light px-3 py-2 rounded-3 d-block" style="width: 45px;" title="상단으로 가기">
            <i class="bi bi-arrow-up me-2"></i>
        </a>
    </div>


</main>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
<script>
</script>
</body>
</html>
