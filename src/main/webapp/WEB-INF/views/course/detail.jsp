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
            <div class="text-end"><button class="btn btn-primary" onclick="openCommentFormModal()">리뷰 작성</button></div>
        </div>
        <div class="card-body">
            <div class="row mb-3">
                <div class="col-12" id="box-comments"></div>
            </div>
        </div>
    </div>
</div>

<%-- 코스 리뷰 등록 Modal창 --%>
<div class="modal fade" id="modal-comment-form" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">코스 리뷰 등록하기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <%-- 리뷰 내용을 입력하고 등록한다. --%>
            <%-- 요청 파라미터 정보 : courseNo, title, content, upfile --%>
            <div class="modal-body">
                <form method="post" action="/addComment" enctype="multipart/form-data">
                    <input type="hidden" name="courseNo" value="${course.no }" />
                    <div class="form-group">
                        <label class="form-label">제목(반드시 입력)</label>
                        <input type="text" class="form-control" name="title"/>
                    </div>
                    <div class="form-group">
                        <label class="form-label">내용(반드시 입력)</label>
                        <textarea rows="4" class="form-control" name="content"></textarea>
                    </div>
                    <div class="form-group">
                        <label class="form-label">코스 사진 업로드</label>
                        <input type="file" class="form-control" name="upfile" multiple="multiple"/>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="submit" class="btn btn-primary" onclick="submitComment()">등록</button>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/views/common/footer.jsp" %>
<script type="text/javascript">
    const commentFormModal = new bootstrap.Modal('#modal-comment-form')

    // 코스 리뷰 등록 Modal창을 연다.
    function openCommentFormModal() {
        commentFormModal.show();
    }

    // 입력한 코스 리뷰 정보(코스번호, 제목, 내용, 첨부파일)를 컨트롤러에 제출한다.
    function submitComment() {
        let value1 = document.querySelector("input[name=courseNo]").value;
        let value2 = document.querySelector("input[name=title]").value;
        let value3 = document.querySelector("textarea[name=content]").value;

        let data = {
            courseNo: value1,
            title: value2,
            content: value3
        }
    }
</script>
</body>
</html>