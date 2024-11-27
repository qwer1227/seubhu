<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Dashboard</title>

    <!-- Custom fonts for this template-->
    <link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">

    <!-- Sidebar -->
    <%@include file="/WEB-INF/views/admincommon/sidebar.jsp" %>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

        <!-- Main Content -->
        <div id="content">

            <!-- Topbar -->
            <%@include file="/WEB-INF/views/admincommon/topbar.jsp" %>
            <!-- End of Topbar -->

            <!-- Begin Page Content -->
            <div class="container-fluid">
    <!-- Page Heading -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">기존 이미지 수정</h1>
    </div>
    <div class="container my-3">
        <div class="row mb-3">
            <div class="col-6">
                <div class="border p-2 bg-dark text-white fw-bold">이미지 수정</div>
            </div>
        </div>
        <div class="row mb-3">
            <div class="col-6">
                <!-- GET Form -->
                <form id="getForm" class="border bg-light p-3" method="get" action="/admin/image-editform" enctype="multipart/form-data">
                    <div class="form-group mb-3 col-4">
                        <label class="form-label">상품번호:</label>
                        <input type="text" class="form-control" name="no" value="${product.no}" />
                    </div>
                    <div class="form-group mb-3 col">
                        <label class="form-label">상품명:</label>
                        <input type="text" class="form-control" name="name" value="${product.name}" />
                    </div>
                    <div class="form-group mb-3 col-4">
                        <label class="form-label">색상 : ${color.name}</label>
                        <input type="hidden" name="colorNo" />
                    </div>
                    <div class="text-end" style="text-align: right">
                        <button type="button" id="getSubmitButton" class="btn btn-primary">조회</button>
                    </div>
                </form>

                <!-- POST Form (hidden initially) -->
                <form id="postForm" class="border bg-light p-3" method="post" action="/admin/image-editform" enctype="multipart/form-data" style="display: none;">
                    <div id="imageContainer">
                        <div class="row m-3">
                            <label class="form-label mr-2">항목 추가하기</label>
                            <button id="addButton" type="button" class="btn btn-primary">+</button>
                        </div>
                        <c:forEach var="i" items="${images}">
                            <div class="form-group col mb-3">
                                <label class="form-label mb-3 mr-2">상품 이미지</label>
                                <input type="hidden" name="colorNo" value="${i.colorNo}"/>
                                <input type="hidden" name="imgNo" value="${i.no}"/>
                                <input type="checkbox" class="form-check-input m-2 single-checkbox" name="isThum" />
                                <input type="text" class="form-control mt-2" name="image[]" value="${i.url}" />
                                <button type="button" class="btn btn-danger mt-2 btn-delete">삭제</button>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="text-end" style="text-align: right">
                        <button type="submit" class="btn btn-primary">등록</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
            <!-- end Page Content -->
        </div>
    </div>
</div>
<!-- Footer -->
<%@include file="/WEB-INF/views/admincommon/footer.jsp" %>
<!-- End of Footer -->

<%@include file="/WEB-INF/views/admincommon/common.jsp" %>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const getSubmitButton = document.getElementById("getSubmitButton");
        const postForm = document.getElementById("postForm");

        // 조회 버튼 클릭 이벤트
        getSubmitButton.addEventListener("click", function () {
            // POST Form 보이기
            postForm.style.display = "block";
        });
    });


    document.addEventListener('DOMContentLoaded', () => {
        const imageContainer = document.getElementById('imageContainer');
        const addButton = document.getElementById('addButton');

        // 새로운 입력 필드 추가
        const addImageInput = (colorNo = '', imgNo = '', imageUrl = '') => {
            const div = document.createElement('div');
            div.className = 'form-group col mb-3';
            div.innerHTML = `
            <label class="form-label mb-3 mr-2">상품 이미지</label>
            <input type="hidden" name="colorNo" value="${colorNo}" />
            <input type="hidden" name="imgNo" value="${imgNo}" />
            <input type="checkbox" class="form-check-input m-2 single-checkbox" name="isThum" />
            <input type="text" class="form-control mt-2" name="image[]" value="${imageUrl}" placeholder="이미지 URL을 입력하세요" />
            <button type="button" class="btn btn-danger mt-2 btn-delete">삭제</button>
        `;
            imageContainer.appendChild(div);
        };

        // 이벤트 위임 방식으로 체크박스 클릭 이벤트 처리
        imageContainer.addEventListener("click", function (event) {
            if (event.target.classList.contains("single-checkbox")) {
                const checkboxes = document.querySelectorAll(".single-checkbox");

                // 현재 클릭된 체크박스가 체크 상태인 경우
                if (event.target.checked) {
                    checkboxes.forEach((checkbox) => {
                        if (checkbox !== event.target) {
                            checkbox.checked = false; // 다른 체크박스는 모두 해제
                        }
                    });
                }
            }
        });

        // 입력 필드 삭제
        const deleteImageInput = (button) => {
            button.parentElement.remove();
        };

        // + 버튼 클릭 이벤트
        addButton.addEventListener('click', () => addImageInput());

        // 삭제 버튼 클릭 이벤트 위임
        imageContainer.addEventListener('click', (e) => {
            if (e.target.classList.contains('btn-delete')) {
                deleteImageInput(e.target);
            }
        });
    });
</script>
</body>

</html>




