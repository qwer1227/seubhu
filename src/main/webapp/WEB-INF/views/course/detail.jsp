<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
    <%-- 코스 상세 정보 --%>
    <%-- 요청 파라미터 정보 : no --%>
    <div class="row">
        <div class="col-5">
            <table class="table table-bordered">
                <div class="card">
                    <div class="card-header">${course.name}</div>
                </div>
                <tbody>
                <tr>
                    <th scope="row">코스 지역</th>
                    <td>${course.region.si} ${course.region.gu} ${course.region.dong}</td>
                </tr>
                <tr>
                    <th scope="row">코스 거리</th>
                    <td>${course.distance}KM</td>
                </tr>
                <tr>
                    <th scope="row">평균 완주 시간</th>
                    <td>${course.time}분</td>
                </tr>
                <tr>
                    <th scope="row">코스 난이도</th>
                    <td>${course.level}단계</td>
                </tr>
                </tbody>
            </table>
            <button type="button" class="btn btn-primary">
                <i class="bi bi-hand-thumbs-up"></i> 좋아요!
            </button>
            <span>좋아요 수 : ${course.likeCnt}개</span>
        </div>
        <div class="col-1"></div> <%-- 빈칸 --%>
        <div class="col-6">
            <div class="card">
                <div class="card-body">
                    <div class="row mb-1">
                        <div class="col">
                            <img src="/resources/images/course/${course.filename}" class="img-thumbnail">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- 코스 리뷰 목록 --%>
    <div class="card mt-5" id="review">
        <div class="card-header">
            코스 리뷰
            <div class="text-end">
                <%-- <sec:authorize access="isAuthenticated()"> --%>
                    <%-- <sec:authentication property="principal" var="loginUser" /> --%>
                    <button class="btn btn-primary" onclick="openReviewFormModal(25)">리뷰 작성</button> <%-- ${loginUser.no} --%>
                <%-- </sec:authorize> --%>
            </div>
        </div>
        <div class="card-body">
            <div class="row mb-3">
                <div class="col-12" id="box-reviews"></div>
            </div>
        </div>
    </div>
</div>

<%-- 코스 리뷰 등록 Modal창 --%>
<div class="modal fade" id="modal-review-form" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">코스 리뷰 등록하기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <%-- 리뷰 내용을 입력하고 등록한다. --%>
            <%-- 요청 파라미터 정보 : courseNo, title, content, upfile --%>
            <div class="modal-body">
                <form method="post" action="/addReview" enctype="multipart/form-data">
                    <input type="hidden" name="courseNo" value="${course.no }" />
                    <div class="form-group">
                        <label class="form-label">제목</label>
                        <input type="text" class="form-control" name="title"/>
                    </div>
                    <div class="form-group">
                        <label class="form-label">내용</label>
                        <textarea rows="4" class="form-control" name="content"></textarea>
                    </div>
                    <div class="form-group">
                        <label class="form-label">코스 사진 업로드</label>
                        <input type="file" class="form-control" name="upfile" multiple="multiple"/>
                        <strong style="color:red;">＊ 컨트롤(Ctrl)을 누른 채로 사진 여러 개 클릭</strong>
                    </div>
                    <div class="form-group">
                        <strong style="color:red;">＊ 리뷰 수정이 불가하니 신중히 작성바랍니다!</strong>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="submit" class="btn btn-primary" onclick="submitReview()">등록</button>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/views/common/footer.jsp" %>
<script type="text/javascript">
    const reviewFormModal = new bootstrap.Modal('#modal-review-form')

    // 코스 리뷰 등록 Modal창을 연다.
    async function openReviewFormModal(userNo) {
        // 1. 코스 완주를 성공한 사용자가 아니라면, 경고 메시지를 출력한다.
        let response = await fetch("/course/check-success/" + userNo);
        let result = await response.json();

        if (result.data === "fail") {
            alert("코스를 성공한 사용자만 리뷰 작성이 가능합니다.");
            return;
        }

        // 2. 코스 리뷰 등록 Modal창을 화면에 표시한다.
        reviewFormModal.show();
    }

    // 리뷰 목록이 화면에 표시된다.
    async function getReviews() {
        let courseNo = document.querySelector("input[name=courseNo]").value;

        let response = await fetch("/course/reviews/" + courseNo);
        let result = await response.json();

        let reviews = result.data;
        for (let review of reviews) {
            appendReview(review);
        }
    }

    getReviews();

    // 입력한 코스 리뷰 정보(코스번호, 제목, 내용, 첨부파일)를 컨트롤러에 제출한다.
    async function submitReview() {
        // 1. 입력한 코스 리뷰 정보를 가져온다.
        let courseNo = document.querySelector("input[name=courseNo]").value;
        let title = document.querySelector("input[name=title]").value;
        let content = document.querySelector("textarea[name=content]").value;
        let upfiles = document.querySelector("input[name=upfile]").files;

        // 2. 리뷰 제목과 리뷰 내용이 없다면, 경고 메시지를 출력한다.
        if (title === "" || content === "") {
            alert("제목과 내용 작성은 필수입니다.");
            return;
        }

        // 3. 입력한 코스 리뷰 정보를 formData 객체에 저장한다.
        let formData = new FormData();

        formData.append("courseNo", courseNo);
        formData.append("title", title);
        formData.append("content", content);
        for (let i = 0; i < upfiles.length; i++) {
            let upfile = upfiles[i];
            formData.append("upfiles", upfile);
        }

        // 4. formData(입력한 코스 리뷰 정보)를 서버에 보낸다.
        let response = await fetch("/course/addReview", {
            method: "POST",
            body: formData
        });

        // 5. 요청 처리 성공 확인 후, 입력한 리뷰를 화면에 표시한다.
        if (response.ok) {
            let review = await response.json();
            appendReview(review);

            reviewFormModal.hide();
        }
    }

    // 입력한 리뷰를 화면에 표시한다.
    function appendReview(review) {
        // 1. 리뷰를 화면에 표시한다.
        let content = `
            <input type="hidden" name="reviewNo" value="\${review.no}">
	        <div class="card mb-3" id="review-\${review.no}">
	            <div class="card-header">
	                <span>\${review.title}</span>
	                <span class="float-end">
	                    <small>\${review.user.nickname}</small>
	                    <small>\${review.createdDate}</small>
                        <button class="btn btn-primary">좋아요</button> <small>좋아요 수: \${review.likeCnt}</small>
	                </span>
	            </div>
	            <div class="card-body">
	                <div>\${review.content}</div>
	                <div id="box-images-\${review.no}"></div>
	            </div>
	            <div class="card-footer text-end">
	                <button class="btn btn-danger btn-sm" onclick="removeReview(\${review.no})">삭제</button>
	            </div>
	        </div>
	    `;

        let box = document.querySelector("#box-reviews");
        box.insertAdjacentHTML("beforeend", content);

        // 2. 첨부파일(코스 사진)을 화면에 표시한다.
        let images = review.reviewImage;
        let imgContent = '';
        if (images != null) {
            for (let image of images) {
                imgContent += `<img src="/resources/images/courseReviewImages/\${image.name}" class="img-thumbnail" style="width: 100px; height: 100px;"/>`;
            }

            let imagesbox = document.querySelector(`#box-images-\${review.no}`);
            imagesbox.insertAdjacentHTML("beforeend", imgContent);
        }
    }

    // 리뷰를 삭제한다.
    async function removeReview(reviewNo) {
        // 1. 리뷰 번호를 서버에 보낸다.
        let response = await fetch("/course/deleteReview/" + reviewNo);

        // 2. 요청 처리 성공 확인 후, 리뷰를 삭제한다.
        if (response.ok) {
            let div = document.querySelector("#review-" + reviewNo);
            div.remove();
        } else {
            alert("로그인한 해당 리뷰 작성자만 삭제 가능합니다.");
        }
    }
</script>
</body>
</html>