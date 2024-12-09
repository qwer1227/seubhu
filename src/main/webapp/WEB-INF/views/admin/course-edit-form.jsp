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
                    <h1 class="h3 mb-0 text-gray-800">코스 수정</h1>
                </div>
                <div class="container my-3">
                    <div class="row mb-3">
                        <div class="col">
                            <div class="border p-2 bg-dark text-white fw-bold">코스 수정폼</div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-12">
                            <form class="border bg-light p-3"
                                  method="get" action="/admin/course-register-form"
                                  enctype="multipart/form-data">
                                <div class="form-group mb-3 col-4">
                                    <label class="form-label">코스명</label>
                                    <input type="text" class="form-control" name="name" />
                                </div>
                                <div class="form-group mb-3 col-4">
                                    <label class="form-label">걸리는 시간(분)</label>
                                    <input type="text" class="form-control" name="time" />
                                </div>
                                <div class="form-group mb-3 col-4">
                                    <label class="form-label">거리(km)</label>
                                    <input type="text" class="form-control" name="distance" />
                                </div>
                                <div class="col-4">
                                    <label class="form-label">시</label>
                                    <select class="form-control mb-3" name="si" >
                                        <option value="서울시" selected>서울시</option>
                                        <option value="경기도">경기도</option>
                                    </select>
                                </div>
                                <div class="col-4">
                                    <label class="form-label">구</label>
                                    <select class="form-control mb-3" name="gu" >
                                        <option value="강남구" selected>강남구</option>
                                        <option value="강동구">강동구</option>
                                        <option value="강북구">강북구</option>
                                        <option value="강서구">강서구</option>
                                        <option value="관악구">관악구</option>
                                        <option value="광진구">광진구</option>
                                        <option value="구로구">구로구</option>
                                        <option value="금천구">금천구</option>
                                        <option value="노원구">노원구</option>
                                        <option value="도봉구">도봉구</option>
                                        <option value="동대문구">동대문구</option>
                                        <option value="동작구">동작구</option>
                                        <option value="마포구">마포구</option>
                                        <option value="서대문구">서대문구</option>
                                        <option value="서초구">서초구</option>
                                        <option value="성동구">성동구</option>
                                        <option value="성북구">성북구</option>
                                        <option value="송파구">송파구</option>
                                        <option value="양천구">양천구</option>
                                        <option value="영등포구">영등포구</option>
                                        <option value="용산구">용산구</option>
                                        <option value="은평구">은평구</option>
                                        <option value="종로구">종로구</option>
                                        <option value="중구">중구</option>
                                        <option value="중랑구">중랑구</option>
                                    </select>
                                </div>
                                <div class="col-4">
                                    <label class="form-label">동</label>
                                    <input type="text" class="form-control" name="dong">
                                </div>
                                <div class="col-4 mt-4" >
                                    <div class="row">
                                        <label class="col-3 mt-2 form-label">코스단계</label>
                                        <select class="col-2 form-control mb-3" name="level">
                                            <option value="1" selected>1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
                                            <option value="5">5</option>
                                        </select>
                                        <div class="col-4 mt-2">레벨</div>
                                    </div>
                                </div>
                                <div class="form-group col-4">
                                    <label class="form-label mb-3">코스 이미지</label>
                                    <input type="file" class="form-control" name="image"/>
                                </div>
                                <div class="text-end">
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



