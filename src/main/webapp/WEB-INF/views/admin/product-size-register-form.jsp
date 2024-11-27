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
                    <h1 class="h3 mb-0 text-gray-800">기존 상품 사이즈 추가</h1>
                </div>
                <div class="container my-3">
                    <div class="row mb-3">
                        <div class="col-6">
                            <div class="border p-2 bg-dark text-white fw-bold">사이즈 등록</div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-6">
                            <form class="border bg-light p-3"
                                  method="post" action="/admin/register-color"
                                  enctype="multipart/form-data">
                                <div class="form-group mb-3 col-4">
                                    <label class="form-label">상품번호: ${prodDetailDto.no}</label>
                                </div>
                                <div class="form-group mb-3 col">
                                    <label class="form-label">상품명: ${prodDetailDto.name}</label>
                                </div>
                                <div class="form-group mb-3 col-4">
                                    <label class="form-label">사이즈</label>
                                    <input type="text" class="form-control" name="size" />
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

</body>

</html>


