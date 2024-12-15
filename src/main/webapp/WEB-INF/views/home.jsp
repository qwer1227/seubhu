<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <style>
        /*메인이미지 캐러셀*/
        .carousel-image-container {
            width: 100%;
            height: 70vh; /* 뷰포트 높이의 50%로 설정 */
        }

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
        .btn-close {
            position: absolute;
            top: 10px;
            right: 10px;
            cursor: pointer;
        }
        .d-none {
            display: none !important;
        }


    </style>
    <title>습습후후</title>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<main>
    <!-- 메인 이미지 캐러셀 -->
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
                <div class="carousel-image-container">
                    <img src="../../resources/img/main3.jpg" class="d-block w-100" alt="..."
                         style="object-fit: cover; width: 100%; height: 680px;"/>
                </div>
            </div>
            <div class="carousel-item">
                <div class="carousel-image-container">
                    <img src="../../resources/img/main2.jpg" class="d-block w-100" alt="..."
                         style="object-fit: cover; width: 100%; height: 680px;"/>
                </div>
            </div>
            <div class="carousel-item">
                <div class="carousel-image-container">
                    <img src="../../resources/img/main1.jpg" class="d-block w-100" alt="..."
                         style="object-fit: cover; width: 100%; height: 680px;"/>
                </div>
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
        <!-- 가로 구분선 추가 -->
        <div class="border-bottom my-3"></div>

    <div id="weeklyRankingCarousel" class="carousel slide mt-3" data-bs-ride="carousel">
            <div class="carousel-inner">
                <!-- 첫 번째 페이지 -->
                <div class="carousel-item active">
                    <div class="row">
                        <c:forEach var="product" items="${bestByRating}" varStatus="status">
                            <div class="col-md-3">
                                <div class="card position-relative border-0">

                                    <a href="/product/hit?no=${product.no}&colorNo=${product.colorNum}">
                                        <img src="${product.imgThum}" class="card-img-top" alt="상품 1">
                                    </a>
                                    <div class="icon-overlay d-flex justify-content-center">
                                        <button class="icon-button btn-sm">
                                            <i class="bi bi-heart"></i>
                                        </button>
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title mb-0">${product.name}</h5>
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <span>#${status.index + 1}</span> <!-- 좌측: 순위 -->
                                            <span class="text-danger">${product.status}</span> <!-- 우측: 판매중 -->
                                        </div>
                                        <div class="d-flex justify-content-between">
                                            <p class="card-text fw-bold mb-0">${product.price}</p> <!-- 가격 -->
                                            <p class="mb-0">${product.brand.name}</p> <!-- 브랜드명 -->
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <!-- 두 번째 페이지 -->
                <div class="carousel-item">
                    <div class="row">
                        <c:forEach var="product" items="${bestByRating}" varStatus="status">
                            <div class="col-md-3">
                                <div class="card position-relative border-0">
                                    <a href="/product/hit?no=${product.no}&colorNo=${product.colorNum}">
                                        <img src="${product.imgThum}" class="card-img-top" alt="상품 5">
                                    </a>
                                    <div class="icon-overlay d-flex justify-content-center">
                                        <button class="icon-button btn-sm">
                                            <i class="bi bi-heart"></i>
                                        </button>
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title mb-0">${product.name}</h5>
                                        <div class="d-flex align-items-center">
                                            <span class="me-3">#${status.index + 1}</span>
                                        </div>
                                        <p class="card-text fw-bold">${product.price}</p>
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

    <section class="container">
        <div class="row">
            <!-- 러닝화 주간 랭킹 -->
            <div class="col-md-6 mb-4">
                <h3>러닝화 주간 랭킹</h3>
                <div class="border-bottom my-3"></div>
                <ul class="list-group border-0">
                    <c:forEach var="product" items="${bestByViewCount}" varStatus="status">
                        <li class="list-group-item d-flex align-items-center border-0">
                            <!-- 자동 순위 표시 -->
                            <span class="fw-bold me-3">#${status.index + 1}</span>
                            <a href="/product/hit?no=${product.no}&colorNo=${product.colorNum}"
                               class="text-decoration-none">
                                <img src="${product.imgThum}" alt="러닝화 ${status.index + 1}" width="50" class="me-3">
                                <span class="text-muted">${product.name}</span>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>

            <!-- 마라톤 정보 -->
            <div class="col-md-6 mb-4">
                <h3 class="d-flex align-items-center">
                    <span class="ms-3 text-muted">마라톤 정보</span>
                </h3>
                <div class="border-bottom my-3"></div>
                <c:forEach var="marathon" items="${latestMarathons}">
                    <ul class="list-group border-0">
                        <li class="list-group-item d-flex justify-content-between align-items-center border-0">
                            <!-- 작성 날짜 -->
                            <div class="d-flex flex-column text-start w-25">
                            <span class="text-muted">
                                <fmt:formatDate value="${marathon.marathonDate}" pattern="yyyy-MM-dd"/>
                            </span>
                            </div>
                            <!-- 제목 -->
                            <div class="d-flex flex-column text-start w-50">
                                <span class="text-muted">${marathon.title}</span>
                            </div>
                            <!-- 시작/끝 날짜 -->
                            <div class="d-flex flex-column text-start w-25">
                            <span class="text-muted">
                                <fmt:formatDate value="${marathon.startDate}" pattern="yyyy-MM-dd"/>
                                ~
                                <fmt:formatDate value="${marathon.endDate}" pattern="yyyy-MM-dd"/>
                            </span>
                            </div>
                            <a href="/community/marathon/hit?no=${marathon.no}" class="btn btn-sm btn-dark text-decoration-none">바로가기</a>
                        </li>
                    </ul>
                </c:forEach>
            </div>
        </div>
    </section>


        <!-- 커뮤니티 게시판 -->
    <section class="container my-5">
        <h3 class="text-muted">커뮤니티</h3>
        <div class="border-bottom my-3"></div>
        <div class="list-group">
            <c:forEach var="board" items="${topViewedBoards}">
                <a href="/community/board/hit?no=${board.no}"
                   class="list-group-item list-group-item-action d-flex border-0 text-decoration-none">
                    <div class="col-9">
                        <span class="text-muted">${board.title}</span>
                    </div>
                    <div class="col-1 text-right">
                        <small class="text-muted">${board.user.nickname}</small>
                    </div>
                    <div class="col-1 text-right">
                        <small class="text-muted"><fmt:formatDate value="${board.createdDate}"
                                                                  pattern="yyyy-MM-dd"/></small>
                    </div>
                    <div class="col-1 text-right">
                        <small class="text-muted">${board.viewCnt}</small>
                    </div>
                </a>
            </c:forEach>
        </div>
    </section>

    <!-- 코스 목록 -->
    <section class="container my-5">
        <h3 class="text-muted">코스 목록</h3>
        <div class="border-bottom my-3"></div>
        <div class="row">
            <c:forEach var="course" items="${topLikedCourses}">
                <div class="col-md-4 mb-4">
                    <div class="card border-0">
                        <div class="card-body">
                            <a href="/course/detail?no=${course.no}" class="text-decoration-none">
                                <!-- 이미지와 이름 사이 여백 추가 -->
                                <img src="https://2404-bucket-team-1.s3.ap-northeast-2.amazonaws.com/resources/images/course/${course.filename}" class="d-block w-100 mb-3" alt="SEUB2HU2 ls">
                                <h5 class="card-title text-muted fw-bold">${course.name}</h5> <!-- 볼드체 처리 -->
                            </a>
                            <!-- 지역과 좋아요 개수를 한 줄로, 좋아요 개수 빨간색으로 표시 -->
                            <p class="card-text text-muted d-flex justify-content-between">
                                <span>${course.region.si} ${course.region.gu} ${course.region.dong}</span>
                                <span class="text-danger">${course.likeCnt}개</span>
                            </p>
                            <!-- 거리, 레벨, 시간 한 줄로 배치 -->
                            <p class="card-text text-muted d-flex justify-content-between">
                                <span>${course.distance}KM</span>
                                <span>${course.level}단계</span>
                                <span>${course.time}분</span>
                            </p>
                            <a href="/course/detail?no=${course.no}" class="btn btn-dark text-white">바로가기</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>


    <!-- 광고 팝업 -->
    <div class="ad-popup">
        <div id="lessonCarousel" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <!-- 반복문으로 슬라이드 생성 -->
                <c:forEach var="lesson" items="${ongoingLessons}" varStatus="status">
                    <div class="carousel-item ${status.first ? 'active' : ''}">
                        <c:if test="${not empty images['THUMBNAIL']}">
                            <img src="${s3}/resources/images/lesson/${images['THUMBNAIL']}"
                                 alt="Thumbnail" style="width: 100%; height: 300px;" class="d-block w-100" />
                        </c:if>
                        <div class="popup-content text-center">
                            <h5>${lesson.title}</h5>
                            <p>${lesson.subject} - ${lesson.place}</p>
                            <p>${lesson.start} ~ ${lesson.end}</p>
                            <a href="/lesson/detail?lessonNo=${lesson.lessonNo}" class="btn btn-dark text-white">예약하기</a>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- 캐러셀 제어 버튼 -->
            <button class="carousel-control-prev" type="button" data-bs-target="#lessonCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#lessonCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
        <!-- 닫기 버튼 -->
        <div class="icon-overlay d-flex justify-content-center">
            <button type="button" class="btn-close" aria-label="Close" id="closeAdPopup"></button>
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
    document.addEventListener("DOMContentLoaded", function () {
        const closeButton = document.getElementById("closeAdPopup");
        const adPopup = document.querySelector(".ad-popup");

        // 닫기 버튼 클릭 시 팝업 숨기기
        closeButton.addEventListener("click", function () {
            adPopup.classList.add("d-none"); // Bootstrap의 d-none 클래스를 추가
        });
    });


</script>
</body>
</html>
