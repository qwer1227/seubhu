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
          <h1 class="h3 mb-0 text-gray-800">상품 재고 등록</h1>
        </div>
        <div class="container my-3">
          <div class="row mb-3">
            <div class="col-6">
              <div class="border p-2 bg-dark text-white fw-bold">재고 등록</div>
            </div>
          </div>
          <div class="row mb-3">
            <div class="col-6">
              <form id="getForm"
                    class="border bg-light p-3"
                    method="get" action="/admin/product-stock-detail"
                    enctype="multipart/form-data">
                <div class="form-group mb-3 col-4">
                  <input type="hidden" name="no" value="${param.no}">
                  <input type="hidden" name="colorNo" value="${param.colorNo}">
                  <label class="form-label">상품번호 ${product.no}</label>
                </div>
                <div class="form-group mb-3 col">
                  <label class="form-label">상품명: ${product.name}</label>
                </div>
                <div class="row form-group mb-3 col">
                  <div class="form-group mb-3 col-6">
                    <label class="form-label">색상:</label>
                      <select class="form-control" name="colorName">
                        <c:forEach var="c" items="${colors}">
                          <option value="${c.name}">${c.name}</option>
                        </c:forEach>
                      </select>
                  </div>
                </div>
                <div class="text-end" style="text-align: right">
                  <button type="submit" id="getSubmitButton" class="btn btn-primary">재고 조회</button>
                </div>
              </form>
                <c:if test="${not empty colorSize}">
                  <form id="postForm" class="border bg-light p-3" method="post" action="/admin/product-stock-detail">
                  <input type="hidden" name="no" value="${param.no}">
                  <input type="hidden" name="colorNo" value="${param.colorNo}">
                  <input type="hidden" name="colorName" value="${param.colorName}">
                    <div class="text-end">
                      <div id="Container" class="mb-2">
                        <c:forEach var="cs" items="${colorSize}">
                          <label class="form-label">사이즈: ${cs.size.size}</label>
                          <input type="hidden" name="size" value="${cs.size.size}"><br>
                          <label class="form-label">수량:</label>
                          <input type="text" class="form-control col-4" name="amount" value="${cs.size.amount}"><br>
                        </c:forEach>
                      </div>
                      <div>
                        <button type="submit" class="btn btn-primary">재고 등록</button>
                      </div>
                    </div>
                  </form>
                </c:if>
                    <!-- sizeMessage가 있을 때만 표시 -->
                  <c:if test="${empty colorSize}">
                      <div class="alert alert-danger">
                        <p class="mr-3">${sizeMessage}</p>
                        <a href="register-size?no=${param.no}&colorNo=${param.colorNo}">
                            <button type="button" class="btn btn-primary">
                                사이즈 등록하러 가기
                            </button>
                        </a>
                      </div>
                  </c:if>
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
    getSubmitButton.addEventListener("click", function () {
      console.log("GET 요청 실행!");
      // 기본 GET 동작은 유지, 페이지 새로고침 후 서버 응답에 따라 POST 폼 보임.
    });
  });
</script>
</body>

</html>



