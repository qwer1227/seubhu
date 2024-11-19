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
  <!-- Bootstrap CSS 링크 예시 페이지네이션-->
  <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
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
          <h1 class="h3 mb-0 text-gray-800">레슨</h1>
        </div>
        <form id="form-search" method="get" action="/lesson">
          <input type="hidden" name="" value="">
          <div class="row mb-3 d-flex">
            <div class="col-2 mb-4 pt-2">
              <select class="form-control" name="rows" onchange="changeRows()">
                <option value="5" ${param.rows eq 5 ? "selected" : ""}>5개씩 보기</option>
                <option value="10" ${empty param.rows or param.rows eq 10 ? "selected" : ""}>10개씩 보기</option>
                <option value="20" ${param.rows eq 20 ? "selected" : ""}>20개씩 보기</option>
              </select>
            </div>
            <div class="col-1 mb-4 pt-2">
              <select class="form-control" name="lessonCategory">
                <option>모두</option>
                <option>호흡</option>
                <option>자세</option>
                <option>운동</option>
              </select>
            </div>
            <div class="row col-5 mb-4 pt-2">
                <div class="col">
                </div>
                <div class="col-1.7 mb-4 pt-2">
                  <span>날짜</span>
                </div>
                <div class="row col-10 mb-4 pt-1">
                  <div class="col-4">
                    <input type="date" name="startDate">
                  </div>
                  <div class="col-2 text-center">
                    <p>-</p>
                  </div>
                  <div class="col-4">
                    <input type="date" name="endDate">
                  </div>
                </div>
            </div>
            <div class="col-1 mb-4 pt-2">
              <select class="form-control" name="searchCondition">
                <option>강사명</option>
                <option>레슨명</option>
                <option>과목</option>
              </select>
            </div>
            <div class="col-3 mb-4 pt-2">
            <!-- Search -->
            <%@include file="/WEB-INF/views/admincommon/searchbar.jsp" %>

            </div>
          </div>
        </form>
      </div>
      <!-- 레슨 목록시작 -->
      <div class="row mb-3">
        <div class="col">
          <div class="border-bottom pt-4 pr-4 pl-4 bg-light">
            <table class="table">
              <colgroup>
                <col width="15%">
                <col width="*">
                <col width="15%">
                <col width="15%">
                <col width="15%">
                <col width="15%">
              </colgroup>
              <tr>
                <th>번호</th>
                <th>레슨명</th>
                <th>강사명</th>
                <th>가격</th>
                <th>상태</th>
                <th>예약날짜</th>
              </tr>
              <tr>
                <td>1</td>
                <td></td>
              </tr>
            </table>

          </div>

        </div>

      </div>
      <!-- 레슨 목록끝 -->
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

