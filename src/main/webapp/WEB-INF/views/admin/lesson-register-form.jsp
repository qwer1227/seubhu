<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Dashboard</title>

    <!-- Custom fonts for this template-->
    <link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
          type="text/css">
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
                    <h1 class="h3 mb-0 text-gray-800">새 레슨 등록</h1>
                </div>
                <div class="container my-3">
                    <div class="row mb-3">
                        <div class="col">
                            <div class="border p-2 bg-dark text-white fw-bold">새 레슨 등록폼</div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-12">
                            <form name="form" action="/admin/lesson-register-form" enctype="multipart/form-data"
                                  method="post">
                                <div class="row p-3">
                                    <div class="col-6">
                                        <label for="title">레슨명</label>
                                        <input type="text" class="form-control" name="title" id="title">
                                    </div>
                                </div>
                                <div class="row p-3">
                                    <div class="col-2">
                                        <label for="subject">과정</label>
                                        <select name="subject" class="form-control" id="subject">
                                            <option>호흡</option>
                                            <option>자세</option>
                                            <option>운동</option>
                                        </select>
                                    </div>
                                    <div class="col-2">
                                        <label for="lecturerName">강사명</label>
                                        <select name="lecturerId" class="form-control" id="lecturerName">
                                            <c:forEach var="lecturer" items="${lecturers}">
                                                <option value="${lecturer.id}">${lecturer.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-2">
                                        <label for="price">가격</label>
                                        <input type="number" class="form-control" name="price" id="price">
                                    </div>
                                </div>
                                <div class="row p-3 ">
                                    <div class="col-5">
                                        <label for="place">장소</label>
                                        <input type="text" class="form-control" name="place" id="place"/>
                                    </div>
                                </div>
                                <div class="row row-cols-1 p-3">
                                    <div class="col-1 pb-3">
                                        게시글
                                    </div>
                                    <div class="col">
                                        <textarea class="form-control" rows="10" cols="10" name="plan"></textarea>
                                    </div>
                                </div>
                                <div class="row p-3">
                                    <div class="col-3">
                                        <label for="startDate">시작 시간</label>
                                        <input type="datetime-local" class="form-control" name="startDate"
                                               id="startDate">
                                    </div>
                                    <div class="col-3">
                                        <label for="endDate">종료 시간</label>
                                        <input type="datetime-local" class="form-control" name="endDate" id="endDate">
                                    </div>
                                </div>
                                <div class="row p-3 ">
                                    <div class="col-5">
                                        <label for="thumbnail">썸네일 이미지</label>
                                        <input type="file" class="form-control" name="thumbnail" id="thumbnail"/>
                                    </div>
                                </div>
                                <div class="row p-3 ">
                                    <div class="col-5">
                                        <label for="mainImage">본문 이미지</label>
                                        <input type="file" class="form-control" name="mainImage" id="mainImage"/>
                                    </div>
                                </div>
                                <div class="row p-3">
                                    <div class="col d-flex justify-content-end">
                                        <a href="/lesson" class="btn btn-secondary m-1">취소</a>
                                        <button type="submit" class="btn btn-primary m-1">등록</button>
                                    </div>
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

</script>

</body>

</html>



