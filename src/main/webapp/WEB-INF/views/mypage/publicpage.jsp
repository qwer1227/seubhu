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

        .comment-item {
            position: relative;
            margin-bottom: 10px;
        }

        .comment-actions {
            display: none; /* 기본적으로 숨김 처리 */
            position: absolute;
            right: 0;
            top: 0;
        }

        .comment-item:hover .comment-actions {
            display: block; /* 마우스를 올리면 버튼 보이기 */
        }

        .comment-actions button {
            font-size: 12px;

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
                        <p class="text-muted">작성자: ${post.user.name}</p>
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
                        <input type="hidden" id="existingImages" name="existingImages" value="">
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
                    <div class="col-12 col-md-6">
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
                    </div>

                    <!-- Right section: User info, content, comments -->
                    <div class="col-12 col-md-6 ps-3">
                        <!-- User info and action buttons (right side of the image) -->
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="mb-0" id="detailPostWriter"></h5>
                            <div>
                                <button class="btn btn-outline-secondary btn-sm" id="postUpdate">수정</button>
                                <button class="btn btn-outline-danger btn-sm ms-2" id="postDelete">삭제</button>
                            </div>
                        </div>
                        <hr>
                        <p id="detailPostContent"></p>
                        <p id="detailCreatedDate"></p>
                        <button class="btn btn-outline-primary">좋아요</button>

                        <!-- 댓글 섹션 -->
                        <div class="mt-3">
                            <hr>
                            <div id="commentList">

                            </div>

                            <!-- 댓글 입력 -->
                            <div class="mt-3">
                                <input type="text" id="postComment" class="form-control" placeholder="댓글을 입력하세요...">
                                <button class="btn btn-primary mt-2" id="postCommentInsert" data-post-id="${post.no}">댓글</button>
                            </div>
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
        var postId = $(this).data('post-id');  // 클릭한 게시글의 ID 가져오기

        $('#postDelete').data('post-id', postId);
        $('#postUpdate').data('post-id', postId);
        $('#postCommentInsert').data('post-id', postId);

        $.ajax({
            url: "/mypage/detail/" + postId,  // 서버로 AJAX 요청
            method: "GET",
            success: function(response) {
                // 서버에서 받은 게시글 정보로 모달 내용 채우기
                $("#detailPostContent").text(response.postContent);
                $("#detailCreatedDate").text(response.postCreatedDate);
                $("#detailPostWriter").text(response.user.name);

                // 서버에서 받은 댓글 데이터를 반복하면서 화면에 추가
                const comments = response.postComment; // 서버에서 받은 댓글

                console.log(comments)

                $('#commentList').empty()

                comments.forEach(function(comment) {
                    const commentHTML = `
                    <div class="comment-item">
                       <div class="d-flex justify-content-between align-items-center">
                            <p><strong>\${comment.userName}:</strong> \${comment.commentRequest.postComment}</p>
                            <div class="comment-actions">
                                <span>${comment.createdDate}</span>  <!-- 작성 시간 -->
                                <button class="btn btn-outline-primary btn-sm ms-2">좋아요 (${comment.likes})</button>  <!-- 좋아요 버튼 -->
                                <button class="btn btn-outline-secondary btn-sm ms-2" onclick="replyToComment(${comment.commentNo}, '${comment.commentUserName}')">답글 달기</button>  <!-- 답글 달기 버튼 -->

                                <!-- 댓글 작성자 본인일 때 삭제, 남일 때 신고 버튼 표시 -->
                                <%--${comment.isOwner ?
                                    `<button class="btn btn-outline-danger btn-sm ms-2" onclick="deleteComment(${comment.commentNo})">삭제</button>` :
                                    `<button class="btn btn-outline-warning btn-sm ms-2" onclick="reportComment(${comment.commentNo})">신고</button>`
                                }--%>
                            </div>
                        </div>
                    </div>
                `;
                    $('#commentList').append(commentHTML);
                });

                // 답글 달기
                function replyToComment(commentNo, userName) {
                    const commentInput = $('#postComment');
                    commentInput.val(`@${userName} `); // 입력란에 @username 추가
                    commentInput.focus(); // 입력란에 포커스
                }

                // 댓글 삭제
                function deleteComment(commentNo) {
                    if (confirm("정말로 이 댓글을 삭제하시겠습니까?")) {
                        // AJAX로 댓글 삭제 요청 보내기
                        $.ajax({
                            url: `/delete-comment/${commentNo}`,
                            method: 'DELETE',
                            success: function(response) {
                                alert("댓글이 삭제되었습니다.");
                                // 댓글 목록을 새로 고침
                                loadComments();
                            },
                            error: function() {
                                alert("댓글 삭제에 실패했습니다.");
                            }
                        });
                    }
                }

                // 댓글 신고
                function reportComment(commentNo) {
                    if (confirm("이 댓글을 신고하시겠습니까?")) {
                        // 신고 처리 로직
                        $.ajax({
                            url: `/report-comment/${commentNo}`,
                            method: 'POST',
                            success: function(response) {
                                alert("댓글이 신고되었습니다.");
                            },
                            error: function() {
                                alert("댓글 신고에 실패했습니다.");
                            }
                        });
                    }
                }




                // 이미지 슬라이드 구성

                var carouselContainer = $('#feedModal .carousel-inner');
                carouselContainer.empty();  // 기존 이미지를 초기화
                console.log($(this).data("post-id"));

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
                        console.log(image.imageUrl)
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

    // 새글 작성 버튼 클릭 시
    $(document).on('click', '#insertPost', function() {
        // 새글 작성 모드로 전환
        $('#postContent').val('');  // 내용 필드 초기화
        $('#thumbnailImage').val('');  // 썸네일 필드 초기화
        $('#imagePreviewContainer').empty();  // 이미지 미리보기 초기화

        // 새글 작성 모드로 버튼 텍스트 변경
        $('#submitPostButton').text('게시글 작성');  // 버튼 텍스트 변경
        $('#newPostModalLabel').text('새 게시글 작성');
        $('#submitPostButton').attr('onclick', 'insertPost()');  // 클릭 시 새글 작성 동작으로 변경

        // 새글 작성 모달 표시
        $('#newPostModal').modal('show');  // 새글 작성 모달을 표시
    });

    // 게시글 수정 버튼 클릭 시
    $(document).on('click', '#postUpdate', function() {
        // 클릭된 버튼의 data-postid 값을 가져옴
        const postId = $(this).data('post-id');

        // 기존에 열려 있는 상세 게시글 모달 닫기
        $('#feedModal').modal('hide');  // 상세 모달 닫기

        // 서버로 AJAX 요청하여 해당 게시글 데이터를 불러옴
        $.ajax({
            url: "/mypage/detail/" + postId,  // 서버로 AJAX 요청
            type: 'GET',
            success: function(response) {
                // 서버에서 받은 데이터를 수정 폼에 채움
                $('#postContent').val(response.postContent);  // 내용 필드에 내용 채우기
                $('#thumbnailImage').val(response.thumbnail);  // 썸네일 필드에 내용 채우기

                // 기존 이미지 리스트를 hidden 필드에 저장
                let existingImages = response.images.map(image => image.imageUrl);
                $('#existingImages').val(JSON.stringify(existingImages));

                // 기존 이미지 미리보기 초기화
                let previewContainer = $('#imagePreviewContainer');
                previewContainer.empty();

                // 기존 이미지 미리보기 표시
                existingImages.forEach((image, index) => {
                    let img = $('<img>', {
                        src: image,
                        class: 'selected-preview',
                        'data-index': index,
                        click: function () {
                            selectImageAsThumbnail(this);
                        }
                    });
                    previewContainer.append(img);
                });

                $('#submitPostButton').text('게시글 수정');
                $('#newPostModalLabel').text('글 수정');
                $('#submitPostButton').attr('onclick', 'updatePost(' + postId + ')');
                $('#newPostModal').modal('show');
            },
            error: function(xhr, status, error) {
                console.error('게시글 정보를 가져오는 데 실패했습니다:', error);
            }
        });

        // 모달 표시
        $('#newPostModal').modal('show');  // 수정 모드 모달을 표시
    });

    // 게시글 삭제 버튼 누를 시
    $(document).on('click', '#postDelete', function() {
        // 클릭된 버튼의 data-postid 값을 가져옴
        const postId = $(this).data('post-id');

        // 기존에 열려 있는 상세 게시글 모달 닫기
        $('#feedModal').modal('hide');  // 상세 모달 닫기

        $.ajax({
            url: 'mypage/detail/delete/' + postId,
            type: 'PUT',
            success: function (response){
                alert("게시물이 삭제되었습니다");
                location.reload();
            },
            error: function (xhr, status, error){
                alert("게시글 삭제 실패 : " + xhr.responseJSON.message);
            }
        })
    });

    // 댓글 작성 함수
    $(document).on('click', '#postCommentInsert', function (){
        let postComment = $('#postComment').val(); // 입력된 댓글의 값
        let postId = $(this).data('post-id'); // 클릭된 버튼의 data-post-id값
        let userNo = 23;

        // 댓글 내용이 비어있는지 확인
        if (!postComment.trim()){
            alert("댓글 내용을 입력해주세요");
            return;
        }

        let jsonData = {
          postComment : postComment,
          postId : postId,
          userNo : userNo
        };

        $.ajax({
            url: 'mypage/detail/comment',
            type: 'POST',
            data: JSON.stringify(jsonData), // JSON으로 변환하여 전송
            dataType: 'json',
            contentType: 'application/json', // JSON 형식으로 설정
            success: function (response){
                console.log("댓글 작성에 성공하셨습니다");
                console.log("서버 응답:", response);

                // 서버에서 받은 userName과 commentText
                const userName = response.userName;  // 서버에서 받은 유저 이름
                const commentText = response.commentText;  // 서버에서 받은 댓글 텍스트

                // 동적으로 댓글 추가
                const newCommentHtml = `
                <p><strong>\${userName}:</strong> \${commentText}</p>
            `;

                // 기존 댓글 목록에 추가
                $('#postCommentInsert').closest('.mt-3').prev().append(newCommentHtml);

                // 입력 필드 초기화
                $('#postComment').val('');

            },
            error: function (xhr, status, error){
                console.log("댓글 작성 실패", error);
            }
        })
    })

    // 게시글 수정 함수
    function updatePost(postId) {
        let postContent = $('#postContent').val();
        let thumbnailImage = $('#thumbnailImage').val();  // 썸네일 이미지
        let existingImages = $('#existingImages').val(); // 기존 이미지 리스트
        let formData = new FormData();

        formData.append('content', postContent);
        formData.append('thumbnailImage', thumbnailImage);
        formData.append('existingImages', existingImages); // 기존 이미지 전송

        // 이미지 파일 전송
        let files = $('#fileInput')[0].files;
        if (files.length > 0) {
            Array.from(files).forEach(file => {
                formData.append('files', file);
            });
        }

        $.ajax({
            url: '/mypage/detail/update/' + postId,  // 수정 엔드포인트
            type: 'PUT',
            data: formData,
            dataType: 'json',
            processData: false,
            contentType: false,
            success: function(response) {
                alert("게시글이 성공적으로 수정되었습니다!");
                $('#newPostModal').modal('hide');  // 모달 닫기
                location.reload();  // 페이지 새로고침
            },
            error: function(xhr, status, error) {
                console.log('Error:', status, error);  // 서버 오류 정보 로그
                alert("게시글 수정 실패.");
            }
        });
    }


    // 이미지 선택 시 미리보기 및 썸네일 설정
    document.getElementById('fileInput').addEventListener('change', function (e) {
        let files = e.target.files;
        let previewContainer = document.getElementById('imagePreviewContainer');
        previewContainer.innerHTML = ""; // 기존 미리보기 이미지 제거

        Array.from(files).forEach((file, index) => {
            let reader = new FileReader();
            reader.onload = function (event) {
                let wrapperDiv = document.createElement('div');
                wrapperDiv.classList.add('image-preview-wrapper');

                let img = document.createElement('img');
                img.src = event.target.result;
                img.setAttribute('data-index', index); // 고유한 data-index 추가
                img.onclick = function() {
                    selectImageAsThumbnail(img);
                };

                let deleteBtn = document.createElement('button');
                deleteBtn.classList.add('delete-btn');
                deleteBtn.textContent = 'X';
                deleteBtn.onclick = function () {
                    wrapperDiv.remove();  // X 버튼 클릭 시 해당 이미지를 미리보기에서 제거
                };

                wrapperDiv.appendChild(img);
                wrapperDiv.appendChild(deleteBtn);
                previewContainer.appendChild(wrapperDiv);
            };
            reader.readAsDataURL(file);
        });
    });

    // 썸네일 이미지를 선택하는 함수
    function selectImageAsThumbnail(selectedImage) {
        let selectedIndex = $(selectedImage).data('index');
        let previewContainer = $('#imagePreviewContainer');

        // 선택된 이미지의 썸네일을 '#thumbnailImage'에 채워넣기
        let selectedImageUrl = $(selectedImage).attr('src');
        $('#thumbnailImage').val(selectedImageUrl);

        // 기존의 썸네일 미리보기를 모두 초기화하고 선택된 이미지만 강조 표시
        previewContainer.find('img').removeClass('selected');
        $(selectedImage).addClass('selected');
    }

    // 게시글 수정 버튼 클릭 시 기존 이미지 미리보기 및 삭제 버튼 추가
    $(document).on('click', '#postUpdate', function() {
        const postId = $(this).data('post-id');


        $.ajax({
            url: "/mypage/detail/" + postId,
            type: 'GET',
            success: function(response) {
                $('#postContent').val(response.postContent);  // 내용 필드에 내용 채우기
                $('#thumbnailImage').val(response.thumbnail);  // 썸네일 필드에 내용 채우기

                // 기존 이미지 리스트를 hidden 필드에 저장
                let existingImages = response.images.map(image => image.imageUrl);
                $('#existingImages').val(JSON.stringify(existingImages));

                // 기존 이미지 미리보기 초기화
                let previewContainer = $('#imagePreviewContainer');
                previewContainer.empty();

                // 기존 이미지 미리보기 표시
                existingImages.forEach((image, index) => {
                    let wrapperDiv = $('<div>', { class: 'image-preview-wrapper' });

                    let img = $('<img>', {
                        src: image,
                        class: 'selected-preview',
                        'data-index': index,
                        'data-image-no': response.images[index].no, //imageNo 추가
                        click: function () {
                            selectImageAsThumbnail(this);
                        }
                    });

                    // 삭제 버튼 추가
                    let deleteBtn = $('<button>', {
                        class: 'delete-btn',
                        text: 'X',
                        click: function () {
                            let imageNo = $(this).siblings('img').data('image-no'); // data-image-no에서 imageNo 가져오기
                            deleteImage(index, image, postId, imageNo); // 해당 이미지를 삭제하는 함수 호출
                        }
                    });

                    wrapperDiv.append(img).append(deleteBtn);
                    previewContainer.append(wrapperDiv);
                });

                $('#submitPostButton').text('게시글 수정');
                $('#submitPostButton').attr('onclick', 'updatePost(' + postId + ')');
                $('#newPostModal').modal('show');
            },
            error: function(xhr, status, error) {
                console.error('게시글 정보를 가져오는 데 실패했습니다:', error);
            }
        });

        $('#newPostModal').modal('show');
    });

    // 삭제할 이미지 처리
    function deleteImage(index, imageUrl, postId, imageNo) {
        // 기존 이미지 목록에서 해당 이미지를 제거
        let existingImages = JSON.parse($('#existingImages').val());
        existingImages.splice(index, 1);  // 배열에서 해당 이미지 제거
        $('#existingImages').val(JSON.stringify(existingImages));  // 업데이트된 이미지 목록 저장

        // 미리보기에서 해당 이미지 삭제
        $('#imagePreviewContainer img[src="' + imageUrl + '"]').parent().remove();

        let dataToSend = {
            imageNo : imageNo
        };


        $.ajax({
            url: '/mypage/detail/imagedelete/' + postId,
            type: 'DELETE',
            data: JSON.stringify(dataToSend), // JSON으로 변환하여 전송
            dataType: 'json',
            contentType: 'application/json', // JSON 형식으로 설정
            success: function (response) {
                alert("이미지가 삭제 성공")
            },
            error: function (xhr, status, error){
                console.log('Error:', status,  error); //서버 오류 정보 로그
                alert("이미지 삭제 실패")
            }
        })
    }

    // 게시글 작성
    function insertPost() {
        let postContent = $('#postContent').val();
        let thumbnailImage = $('#thumbnailImage').val();  // 썸네일 이미지
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
            dataType:'json',
            processData: false,
            contentType: false,
            success: function(response) {
                alert("게시글이 성공적으로 작성되었습니다!");

            },
            error: function() {
                alert("게시글 작성 실패.");
            }
        });
    }

</script>

</body>
</html>
