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
              <form class="border bg-light p-3"
                    method="post" action="/admin/lesson-register-form"
                    enctype="multipart/form-data">
                <div class="form-group mb-3 col-4">
                  <label class="form-label">레슨명</label>
                  <input type="text" class="form-control" name="title" />
                </div>
                <div class="form-group mb-3 col-4">
                  <label class="form-label">가격</label>
                  <input type="text" class="form-control" name="price" />
                </div>
                <div class="col-4 mt-4" >
                  <div class="row">
                    <label class="col-4 mt-2 form-label">강사 선택</label>
                    <select class="col-6 form-control mb-3" name="lecturerNo">
                      <option value="29" selected>이상혁</option>
                      <option value="30">고길동</option>
                      <option value="27">정지훈</option>
                      <option value="25">김미미</option>
                      <option value="23">모시깽</option>
                    </select>
                  </div>
                </div>
                <div class="col-4 mt-4" >
                  <div class="row">
                    <label class="col-4 mt-2 form-label">레슨 유형</label>
                    <select class="col-6 form-control mb-3" name="subject">
                      <option value="호흡" selected>호흡</option>
                      <option value="자세">자세</option>
                      <option value="운동">운동</option>
                      <option value="3km">3km</option>
                      <option value="5km">5km</option>
                    </select>
                  </div>
                </div>
                <div class="col-4 mt-4" >
                  <div class="row">
                    <label class="col-4 mt-2 form-label">인원 설정</label>
                    <select class="col-2 form-control mb-3" name="group">
                      <option value="1" selected>1</option>
                      <option value="2">2</option>
                      <option value="3">3</option>
                      <option value="4">4</option>
                      <option value="5">5</option>
                    </select>
                    <div class="col-4 mt-2">명(최대 5명)</div>
                  </div>
                </div>
                <div class="col-4 mt-4" >
                  <div class="row">
                    <label class="col-4 mt-2 form-label">모집 상태</label>
                    <select class="col-6 form-control mb-3" name="status">
                      <option value="모집중" selected>모집중</option>
                      <option value="오픈 예정">오픈 예정</option>
                    </select>
                  </div>
                </div>
                <div class="row col-3 mb-4 pt-2">
                  <div class="col mb-4 pt-2">
                    <span>날짜</span>
                  </div>
                  <div class="row col-9 mb-4 pt-1">
                    <div class="col">
                      <input type="date" name="date" id="dateInput" value="${param.day}"/>
                    </div>
                  </div>
                </div>
                <div class="form-group mb-3 col-4">
                  <label class="form-label">레슨 계획</label>
                  <textarea name="plan" id="" cols="70" rows="5" class=""></textarea>
                </div>
                <div class="form-group col-4">
                  <label class="form-label mb-3">레슨 대표 이미지</label>
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

<script>

</script>

</body>

</html>



