<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/common/tags.jsp" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!doctype html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/common.jsp" %>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        .profile-header {
            margin-top: 20px;
            text-align: center;
        }
        .profile-header img {
            border-radius: 50%;
            width: 120px;
            height: 120px;
        }
        .profile-header .name {
            font-size: 24px;
            font-weight: bold;
        }
        .profile-header .badge {
            background-color: #00bfff;
            color: white;
            padding: 0 8px;
            border-radius: 12px;
        }
        .btn-follow, .btn-message, .btn-settings {
            margin-left: 10px;
        }
        .feed-card img {
            width: 100%;
            border-radius: 8px;
        }
        .feed-card {
            cursor: pointer;
        }
        .modal-body img {
            width: 100%;
            border-radius: 8px;
        }

        /* 이미지 미리보기 */
        .image-preview-container {
            display: flex;
            justify-content: center;
            gap: 24px;  /* 이미지 간격 24px */
            flex-wrap: wrap; /* 화면 크기에 맞게 이미지 줄 바꿈 */
        }
        .image-preview-container img {
            max-width: 120px; /* 이미지 크기 조정 */
            height: 120px;
            border-radius: 8px;
            object-fit: cover;
            cursor: pointer;
            border: 2px solid transparent;
        }
        .image-preview-container img.selected {
            border-color: #00bfff; /* 선택된 이미지의 테두리 색 */
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/nav.jsp" %>

<div class="container-xxl text-center" id="wrap">

    <!-- User Profile -->
    <div class="profile-header">
        <img src="https://via.placeholder.com/120" alt="User Image">
        <div class="name">홍길동 dd<span class="badge">Verified</span></div>
        <div>
            <button type="button" id="insertPost" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#newPostModal">
                새 글 작성
            </button>
            <button class="btn btn-outline-primary btn-follow">팔로우</button>
            <button class="btn btn-outline-secondary btn-message">메시지</button>
            <button class="btn btn-outline-dark btn-settings">⚙️</button>
        </div>
    </div>

    <!-- Feed -->
<div class="container mt-4">
    <div class="row row-cols-1 row-cols-md-3 g-4">
        <!-- Feed Card (반복문을 사용하여 각 게시글을 표시) -->
        <c:forEach var="post" items="${posts}">
            <div class="col">
                <div class="card feed" data-post-id="${post.no}" data-bs-toggle="modal" data-bs-target="#feedModal">
                    <!-- 썸네일 이미지 -->
                    <img src="${post.thumbnail}" class="card-img-top" alt="Feed Image">
                    <div class="card-body">
                        <!-- 게시글 내용 (content) -->
                        <p class="card-text">${post.postContent}</p>
                        <!-- 게시글 작성자 -->
                        <p class="text-muted">작성자: ${post.user.username}</p>
                        <!-- 게시글 작성일 -->
                        <p class="text-muted">${post.postCreatedDate}</p>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>


    <!-- 새 글 작성 모달 -->
    <div class="modal fade" id="newPostModal" tabindex="-1" aria-labelledby="newPostModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="newPostModalLabel">새 글 작성</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="uploadForm" enctype="multipart/form-data">
                        <label for="postContent" class="form-label">내용</label>
                        <textarea class="form-control" id="postContent" name="content" rows="4" required></textarea>
                        <label for="fileInput">이미지 파일:</label>
                        <input type="file" id="fileInput" name="files" accept="image/*" multiple required>
                        <div id="imagePreviewContainer" class="image-preview-container"></div> <!-- 이미지 미리보기 공간 -->
                        <input type="hidden" id="postNoInput" name="postNo" value=""> <!-- 임의의 POST_NO 값 -->
                        <input type="hidden" id="thumbnailIndex" name="thumbnailIndex" value="">
                        <input type="hidden" id="thumbnailImage" name="thumbnailImage" value=""> <!-- 썸네일 이미지 -->
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" id="submitPostButton" onclick="insertPost()">게시</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Feed Modal -->
    <div class="modal fade" id="feedModal" tabindex="-1" aria-labelledby="feedModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="feedModalLabel">게시글 상세</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body d-flex">
                    <!-- Left section: Image carousel -->
                    <div id="carouselExample" class="carousel slide">
                        <div class="carousel-inner">
                            <!-- Carousel items will be dynamically added here -->
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

                    <!-- Right section: User info, content, comments -->
                    <div class="col-6 ps-3">
                        <div>
                            <h5 id="detailPostWriter">작성자</h5>
                            <hr>
                            <p id="detailPostContent">내용</p>
                            <p id="detailCreatedDate">작성일</p>
                            <button class="btn btn-outline-primary">좋아요</button>
                        </div>
                        <!-- Comment input -->
                        <div class="mt-3">
                            <p><strong>친구1:</strong> 멋진 사진이네요!</p>
                            <p><strong>친구2:</strong> 저도 가보고 싶어요!</p>
                        </div>

                        <!-- Comments section -->
                        <hr>

                        <div class="mt-3">
                            <input type="text" class="form-control" placeholder="댓글을 입력하세요...">
                            <button class="btn btn-primary mt-2">댓글</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>



<script>
    // 게시글 클릭 시 AJAX로 데이터 가져오기
    $('.feed').on('click', function() {
        var postId = $(this).data("post-id");  // 클릭한 게시글의 ID 가져오기
        $.ajax({
            url: "/mypage/detail/" + postId,  // 서버로 AJAX 요청
            method: "GET",
            success: function(response) {
                // 서버에서 받은 게시글 정보로 모달 내용 채우기
                $("#detailPostContent").text(response.postContent);
                $("#detailCreatedDate").text(response.postCreatedDate);
                $("#detailPostWriter").text(response.user.username);

                // 이미지 슬라이드 구성
                var carouselContainer = $('#feedModal .carousel-inner');
                carouselContainer.empty();  // 기존 이미지를 초기화

                // 이미지를 carousel에 추가
                if (response.images && response.images.length > 0) {
                    response.images.forEach(function(image, index) {
                        var activeClass = (index === 0) ? 'active' : '';  // 첫 번째 이미지를 active로 설정
                        var imgElement = $('<div>', {
                            class: 'carousel-item ' + activeClass
                        }).append(
                            $('<img>', {
                                src: image.imageUrl,  // 이미지 URL
                                class: 'd-block w-100',
                                alt: 'Post Image ' + (index + 1)
                            })
                        );
                        carouselContainer.append(imgElement);  // carousel-inner에 추가
                    });
                } else {
                    carouselContainer.append('<p>이미지가 없습니다.</p>');  // 이미지가 없을 경우
                }

                // 모달을 표시
                $("#feedModal").show();
            },
            error: function() {
                alert("게시글 정보를 가져오는데 실패했습니다.");
            }
        });
    });


    // 이미지 선택 시 미리보기 및 썸네일 설정
    document.getElementById('fileInput').addEventListener('change', function (e) {
        let files = e.target.files;
        let previewContainer = document.getElementById('imagePreviewContainer');
        previewContainer.innerHTML = ""; // 기존 미리보기 이미지 제거

        Array.from(files).forEach((file, index) => {
            let reader = new FileReader();
            reader.onload = function (event) {
                let img = document.createElement('img');
                img.src = event.target.result;
                img.setAttribute('data-index', index); // 고유한 data-index 추가
                img.onclick = function() {
                    selectImageAsThumbnail(img);
                };
                previewContainer.appendChild(img);
            };
            reader.readAsDataURL(file);
        });
    });

    function selectImageAsThumbnail(imageElement) {
        // 선택된 이미지의 data-index 값 가져오기
        let selectedIndex = imageElement.getAttribute('data-index');

        // 모든 이미지에서 선택된 이미지를 찾고 스타일 적용
        document.querySelectorAll('.image-preview-container img').forEach(img => {
            img.classList.remove('selected'); // 모든 이미지에서 'selected' 클래스 제거
        });

        // 클릭된 이미지에 'selected' 클래스 추가
        imageElement.classList.add('selected');

        // 선택된 이미지의 src를 썸네일로 저장
        document.getElementById('thumbnailImage').value = imageElement.src;
    }

    // 게시글 작성
    function insertPost() {
        let postContent = $('#postContent').val();
        let thumbnailImage = $('#thumbnailImage').val();  // 썸네일 이미지
        let thumbnailIndex = $('#thumbnailIndex').val(); // 선택된 썸네일의 index
        let formData = new FormData();
        formData.append('content', postContent);
        formData.append('thumbnailImage', thumbnailImage);

        // 이미지 파일 전송
        let files = $('#fileInput')[0].files;
        if (files.length > 0) {
            Array.from(files).forEach(file => {
                formData.append('files', file);
            });
        }

        $.ajax({
            url: '/mypage/public/insert', // 게시글 생성 엔드포인트
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                alert("게시글이 성공적으로 작성되었습니다!");
                location.reload();
            },
            error: function() {
                alert("게시글 작성 실패.");
            }
        });
    }

</script>

</body>
</html>
