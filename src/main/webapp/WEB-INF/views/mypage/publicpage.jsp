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
    </style>
</head>
<body>
<%@ include file="/WEB-INF/common/nav.jsp" %>

<div class="container-xxl text-center" id="wrap">

    <!-- User Profile -->
    <div class="profile-header">
        <img src="https://via.placeholder.com/120" alt="User Image">
        <div class="name">홍길동 dd<span class="badge">Verified</span></div>
        <div>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#newPostModal">
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
                <div class="card feed-card" data-bs-toggle="modal" data-bs-target="#feedModal">
                    <img src="https://via.placeholder.com/300" class="card-img-top" alt="Feed Image">
                    <div class="card-body">
                        <p class="card-text">게시글 제목</p>
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
                    <form id="newPostForm">
                        <div class="mb-3">
                            <label for="postTitle" class="form-label">제목</label>
                            <input type="text" class="form-control" id="postTitle" name="title" required>
                        </div>
                        <div class="mb-3">
                            <label for="postContent" class="form-label">내용</label>
                            <textarea class="form-control" id="postContent" name="content" rows="4" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="postImage" class="form-label">이미지 업로드</label>
                            <input type="file" class="form-control" id="postImage" name="image" accept="image/*">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" id="submitPostButton">게시</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal for Feed Detail -->
    <div class="modal fade" id="feedModal" tabindex="-1" aria-labelledby="feedModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="feedModalLabel">게시글 제목</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body d-flex">
                    <!-- Left section: Image -->
                    <div class="col-6">
                        <img id="boardNo"  src="https://via.placeholder.com/500" alt="Feed Image" class="img-fluid">
                    </div>

                    <!-- Right section: User information, content, and comments -->
                    <div class="col-6 ps-3">
                        <!-- User info and content -->
                        <div>
                            <div class="col d-flex justify-content-start align-items-start">
                                <h5 class="m-0">홍길동</h5>
                            </div>
                            <hr>
                            <p class="mt-3">게시글 내용 설명...</p>
                            <p class="text-muted">작성일: 2024-11-05</p>
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


<%@ include file="/WEB-INF/common/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<script>

    $('#boardNo').on('click',function (){
        $.ajax({
            url : '',
            type : 'GET',
            dataType : 'json',
            success : function (data)
        })
    })
</script>
</body>
</html>
