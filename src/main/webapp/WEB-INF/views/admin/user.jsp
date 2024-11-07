<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <%@include file="/WEB-INF/admincommon/sidebar.jsp" %>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

        <!-- Main Content -->
        <div id="content">

            <!-- Topbar -->
            <%@include file="/WEB-INF/admincommon/topbar.jsp" %>
            <!-- End of Topbar -->

            <!-- Begin Page Content -->
            <div class="container-fluid">
                <!-- Page Heading -->
                <div class="d-sm-flex align-items-center justify-content-between mb-4">
                    <h1 class="h3 mb-0 text-gray-800">회원</h1>
                </div>
                <!-- 5-10-20개씩 보기 최신순 이름순 -->
                <form id="form-search" method="get" action="">
                    <div class="rows g-3 d-flex">
                        <div class="col-2 mb-4">
                            <select class="form-control" name="rows">
                                <option value="">5개씩 보기</option>
                                <option value="">10개씩 보기</option>
                                <option value="">20개씩 보기</option>
                            </select>
                        </div>
                        <div class="col-4 mb-4 pt-2">
                            <div class="form-check form-check-inline">
                                <div class="mr-2">
                                    <input class="form-check-input"
                                           type="radio"/>
                                    <label class="form-check-label">이메일로</label>
                                </div>
                                <div class="mr-2">
                                    <input class="form-check-input"
                                           type="radio"/>
                                    <label class="form-check-label">아이디로</label>
                                </div>
                                <div class="mr-2">
                                    <input class="form-check-input"
                                           type="radio"/>
                                    <label class="form-check-label">이름으로</label>
                                </div>
                            </div>
                        </div>

                    </div>
                </form>
                <!-- 5-10-20개씩 보기 최신순 이름순 끝 -->
                <!-- Search -->
                <%@include file="/WEB-INF/admincommon/searchbar.jsp" %>
            </div>
            <!-- 회원 리스트 -->
            <div class="row mb-3">
                <div class="col">
                    <div class="border-bottom p-4 bg-light">
                        <table class="table">
                            <colgroup>
                                <col width="10%">
                                <col width="15%">
                                <col width="10%">
                                <col width="*%">
                                <col width="15%">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>회원번호</th>
                                    <th>이름</th>
                                    <th>아이디</th>
                                    <th>이메일</th>
                                    <th>가입일자</th>
                                </tr>
                            </thead>
                            <tbody>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- end Page Content -->
        </div>
    </div>
</div>
    <!-- Footer -->
    <%@include file="/WEB-INF/admincommon/footer.jsp" %>
    <!-- End of Footer -->

    <%@include file="/WEB-INF/admincommon/common.jsp" %>

</body>

</html>


