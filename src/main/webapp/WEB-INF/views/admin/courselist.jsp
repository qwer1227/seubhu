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
          <h1 class="h3 mb-0 text-gray-800">코스</h1>
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
                  <label class="form-check-label">최신순</label>
                </div>
                <div class="mr-2">
                  <input class="form-check-input"
                         type="radio"/>
                  <label class="form-check-label">오래된순</label>
                </div>
                <div class="mr-2">
                  <input class="form-check-input"
                         type="radio"/>
                  <label class="form-check-label">이름순</label>
                </div>
              </div>
            </div>
          </div>
        </form>
        <!-- Search -->
        <%@include file="/WEB-INF/views/admincommon/searchbar.jsp" %>
        <div class="container-xxl text-center" id="wrap">
          <div class="row row-cols-1 row-cols-md-3 g-4 mt-5 mb-5">
            <div class="col mb-4">
              <div class="card h-100">
                <a class="text-decoration-none" href="detail.html">
                  <img src="${pageContext.request.contextPath}/resources/img/1.png" class="card-img-top" alt="...">
                </a>
                <div class="card-body">
                  <h5 class="card-title">Card title</h5>
                  <a class="text-decoration-none" href="detail.html">
                    <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                  </a>
                </div>
                <div class="card-footer bg-transparent border-primary" >모집중</div>
              </div>
            </div>
            <div class="col mb-4">
              <div class="card h-100">
                <a class="text-decoration-none" href="detail.html">
                  <img src="${pageContext.request.contextPath}/resources/img/2.png" class="card-img-top" alt="...">
                </a>
                <div class="card-body">
                  <h5 class="card-title">Card title</h5>
                  <a class="text-decoration-none" href="detail.html">
                    <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                  </a>
                </div>
                <div class="card-footer bg-transparent border-primary" >모집중</div>
              </div>
            </div>
            <div class="col mb-4">
              <div class="card h-100">
                <a class="text-decoration-none" href="detail.html">
                  <img src="${pageContext.request.contextPath}/resources/img/3.png" class="card-img-top" alt="...">
                </a>
                <div class="card-body">
                  <h5 class="card-title">Card title</h5>
                  <a class="text-decoration-none" href="detail.html">
                    <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                  </a>
                </div>
                <div class="card-footer bg-transparent border-primary" >모집중</div>
              </div>
            </div>
            <div class="col mb-4">
              <div class="card h-100">
                <a class="text-decoration-none" href="detail.html">
                  <img src="${pageContext.request.contextPath}/resources/img/4.png" class="card-img-top" alt="...">
                </a>
                <div class="card-body">
                  <h5 class="card-title">Card title</h5>
                  <a class="text-decoration-none" href="detail.html">
                    <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                  </a>
                </div>
                <div class="card-footer bg-transparent border-primary" >모집중</div>
              </div>
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

