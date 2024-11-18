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
            <!-- Feed Card Example (Repeat this for each feed) -->
            <div class="col">
                <div class="card feed" data-post-id="1" data-bs-toggle="modal" data-bs-target="#feedModal">
                    <img src="data:image/png;base64,${post.thumbnail}" class="card-img-dtop" alt="Feed Image">
                    <div class="card-body">
                        <p class="card-text">테스트</p>
                    </div>
                </div>
            </div>
            <!-- More Cards can go here... -->
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
                        <input type="hidden" id="postNoInput" name="postNo" value="123"> <!-- 임의의 POST_NO 값 -->
                        <input type="hidden" id="thumbnailImage" name="thumbnailImage" value=""> <!-- 썸네일 이미지 -->
                        <button type="button" onclick="uploadImage()">업로드</button>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" id="submitPostButton" onclick="insertPost()">게시</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for Feed Detail -->
    <div class="modal fade" id="feedModal" tabindex="-1" aria-labelledby="feedModalLabel" aria-hidden="true" data-post-id="${post.no}">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="feedModalLabel">테스트</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body d-flex">
                    <!-- Left section: Image -->
                    <div class="col-6">
                        <img src="data:image/png;base64,${post.thumbnail}" class="card-img-top" alt="Feed Image">

                    </div>

                    <!-- Right section: User information, content, and comments -->
                    <div class="col-6 ps-3">
                        <!-- User info and content -->
                        <div>
                            <div class="col d-flex justify-content-start align-items-start">
                                <h5 class="m-0" ID="detailPostWriter">${post.user.username}</h5>
                            </div>
                            <hr>
                            <p class="mt-3" id="detailPostContent">${post.postContent}</p>
                            <p class="text-muted" id="detailCreatedDate">${post.postCreatedDate}</p>
                            <div>
                                <button class="btn btn-outline-primary">좋아요</button>
                            </div>
                        </div>

                        <hr>

                        <!-- Comment input -->
                        <div class="mt-3">
                            <p><strong>친구1:</strong> 멋진 사진이네요!</p>
                            <p><strong>친구2:</strong> 저도 가보고 싶어요!</p>
                            <!-- Additional comments can go here -->
                        </div>

                        <!-- Comments section -->
                        <hr>

                        <div class="mt-3">
                            <input type="text" class="form-control" placeholder="댓글을 입력하세요...">
                            <button class="btn btn-primary mt-2">댓글 등록</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script>
        // 게시글 클릭 시 AJAX로 데이터 가져오기
        $('.feed').on('click', function() {
            var postId = $(this).data("post-id");
            $.ajax({
                url: "/mypage/detail/" + postId,
                method: "GET",
                success: function(response) {
                    // 서버에서 받은 게시글 정보를 모달에 표시
                    $("#detailPostContent").text(response.postContent);
                    $("#detailCreatedDate").text(response.postCreatedDate);
                    $("#detailPostWriter").text(response.user.username);
                    $("#boardNo").attr('src', response.thumbnail);
                    // 모달을 표시
                    $("#feedModal").show();
                },
                error: function() {
                    alert("게시글 정보를 가져오는데 실패했습니다");
                }
            });
        });

        // 이미지 미리보기 기능 및 썸네일 설정
        $('#fileInput').on('change', function(event) {
            const files = event.target.files;
            const previewContainer = $('#imagePreviewContainer');
            previewContainer.empty();  // 미리보기 영역 초기화

            if (files.length <= 5) {
                for (const file of files) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        const img = $('<img>');
                        img.attr('src', e.target.result);

                        // base64 데이터를 기반으로 파일명 생성 (기존의 currentMillis를 대체)
                        const base64Data = e.target.result;
                        const newFileName = base64Data.split(',')[0].replace('data:image/', '').replace(';base64', '');  // base64 데이터에서 확장자 포함한 파일명 생성

                        // Base64 데이터와 새 파일명을 함께 처리
                        const slicedBase64Data = sliceBase64(base64Data);

                        img.on('click', function() {
                            $('#imagePreviewContainer img').removeClass('selected');  // 다른 이미지 선택 해제
                            img.addClass('selected');  // 클릭한 이미지를 선택 상태로 변경
                            $('#thumbnailImage').val(slicedBase64Data);  // 선택된 이미지를 썸네일로 설정
                            $('#thumbnailImage').data('file-name', newFileName);  // 새로운 파일명을 숨은 필드에 저장
                        });

                        previewContainer.append(img);
                    };
                    reader.readAsDataURL(file);
                }
            } else {
                alert("최대 5개의 이미지만 업로드할 수 있습니다.");
            }
        });

        // base64 문자열 슬라이싱 함수
        function sliceBase64(base64Data) {
            const prefix = base64Data.slice(0, 22);  // data:image/jpeg;base64, 부분
            const slicedData = base64Data.slice(22);  // 실제 이미지 데이터 부분만 슬라이싱
            return prefix + slicedData;  // 슬라이싱된 base64 문자열 반환
        }


        function insertPost(){
            const formData = new FormData(document.getElementById('uploadForm'));

            $.ajax({
                url: '/mypage/public/insert',  // 백엔드 업로드 엔드포인트
                type: 'POST',
                data: formData,
                processData: false,       // 파일 전송 시 필수 설정
                contentType: false,       // 파일 전송 시 필수 설정
                success: function(response) {
                    alert("업로드 성공: " + response);
                    closeModal();
                },
                error: function(xhr, status, error) {
                    alert("업로드 실패: " + xhr.responseText);
                }
            });
        }

        // 이미지 업로드 함수
        function uploadImage() {
            const form = document.getElementById('uploadForm');
            const formData = new FormData(form);
            const files = form.querySelector('#fileInput').files;

            // 각 파일에 대해 base64 데이터와 파일 이름 설정
            if (files.length > 0) {
                for (let i = 0; i < files.length; i++) {
                    const file = files[i];
                    const reader = new FileReader();

                    reader.onload = function(e) {
                        // base64 데이터 가져오기
                        const base64Data = e.target.result;
                        const fileName = base64Data.split(',')[0].replace('data:image/', '').replace(';base64', ''); // 파일 이름 설정 (확장자 포함)

                        // base64 데이터를 'fileNames[]' 필드로 추가
                        formData.append('fileNames[]', fileName);  // 파일 이름을 별도의 필드로 추가
                        formData.set('files', file, fileName);  // 파일의 이름을 base64 데이터로 설정
                    };

                    reader.readAsDataURL(file); // 파일을 base64로 읽어들임
                }
            }

            // AJAX로 파일 데이터와 파일 이름 전송
            $.ajax({
                url: '/mypage/public/upload',  // 백엔드 업로드 엔드포인트
                type: 'POST',
                data: formData,
                processData: false,       // 파일 전송 시 필수 설정
                contentType: false,       // 파일 전송 시 필수 설정
                success: function(response) {
                    alert("업로드 성공: " + response);
                    closeModal();
                },
                error: function(xhr, status, error) {
                    alert("업로드 실패: " + xhr.responseText);
                }
            });
        }

    </script>
</body>
</html>
