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
          <h1 class="h3 mb-0 text-gray-800">코스 등록</h1>
        </div>
        <div class="container my-3">
          <div class="row mb-3">
            <div class="col">
              <div class="border p-2 bg-dark text-white fw-bold">코스 등록폼</div>
            </div>
          </div>
          <div class="row mb-3">
            <div class="col-12">
              <form class="border bg-light p-3"
                    method="post" action="/admin/course-register-form"
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
                  <label class="form-label">기존 지역 불러오기</label>
                      <select class="form-control mb-3" name="si" >
                        <c:forEach var="c" items="${courses}">
                          <option>${c.region.si } ${c.region.gu } ${c.region.dong }</option>
                        </c:forEach>
                      </select>
                  </div>
                <div class="col-2">
                  <label class="form-label">코스단계</label>
                  <select class="form-control mb-3" name="level">
                    <option value="">1단계</option>
                    <option value="">2단계</option>
                    <option value="">3단계</option>
                    <option value="">4단계</option>
                    <option value="">5단계</option>
                  </select>
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


