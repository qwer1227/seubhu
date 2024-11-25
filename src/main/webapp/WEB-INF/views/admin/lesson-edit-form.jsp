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
          <h1 class="h3 mb-0 text-gray-800">레슨 수정</h1>
        </div>
        <div class="container my-3">
          <div class="row mb-3">
            <div class="col">
              <div class="border p-2 bg-dark text-white fw-bold">레슨 수정 폼</div>
            </div>
          </div>
          <div class="row mb-3">
            <div class="col-12">
                <div class="row p-3">
                  <div class="col-6">
                    <label for="title">레슨명</label>
                    <input type="text" class="form-control" name="title" id="title" value="${lesson.title}">
                  </div>
                </div>
                <div class="row p-3">
                  <div class="col-2">
                    <label>과정</label>
                    <select name="subject" class="form-control" id="subject">
                      <option value="${lesson.subject}">${lesson.subject}</option>
                      <option value="호흡">호흡</option>
                      <option value="자세">자세</option>
                      <option value="운동">운동</option>
                    </select>
                  </div>
                  <div class="col-2">
                    <label for="lecturerName">강사명</label>
                    <input type="text" class="form-control" name="lecturerName" id="lecturerName" value="${lesson.lecturer.name}">
                  </div>
                  <div class="col-2">
                    <label for="price">가격</label>
                    <input type="number" class="form-control" name="price" id="price" value="${lesson.price}">
                  </div>
                </div>
                <div class="row row-cols-1 p-3">
                  <div class="col-1 pb-3">
                    게시글
                  </div>
                  <div class="col">
                    <textarea class="form-control" rows="10" cols="10" name="plan">${lesson.plan}</textarea>
                  </div>
                </div>
                <div class="row p-3">
                  <div class="col-3">
                    <label>시작 시간</label><br>
                    <label>기존</label>
                    <input type="datetime-local" class="form-control" name="start" id="startDate" value="${lesson.start}" timeZone="GMT">
                  </div>
                  <div class="col-3">
                    <label>종료 시간</label><br>
                    <label>기존</label>
                    <input type="datetime-local" class="form-control" name="end" id="endDate" value="${lesson.end}" timeZone="GMT">
                  </div>
                </div>
                <div class="row p-3 ">
                  <div class="col-5">
                    <label>썸네일 이미지</label>
                    <c:if test="${not empty images['THUMBNAIL']}">
                      <img src="${pageContext.request.contextPath}/resources/lessonImg/${images['THUMBNAIL']}"
                           class="img-fluid" alt="Thumbnail" style="width: 100%; height: 500px;"/>
                    </c:if>
                  </div>
                </div>
                <div class="row p-3 ">
                  <div class="col-5">
                    <label>본문 이미지</label>
                      <c:if test="${not empty images.MAIN_IMAGE}">
                        <img src="${pageContext.request.contextPath}/resources/lessonImg/${images['MAIN_IMAGE']}"
                             alt="Main Image"/>
                      </c:if>
                  </div>
                </div>
                <div class="row p-3">
                  <div class="col d-flex justify-content-end">
                    <a href="/lesson" class="btn btn-secondary m-1">취소</a>
                    <a href="/admin/lesson-edit-form?lessonNo=${lessonNo}">
                      <button type="submit" class="btn btn-primary m-1">수정</button>
                    </a>
                  </div>
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

<script>

  // ${lesson.subject} 값을 JavaScript 변수에 저장
  const lessonSubject = "${lesson.subject}"; // 서버에서 전달된 값

  // select 태그와 option 태그 가져오기
  const subjectSelect = document.getElementById("subject");
  const options = subjectSelect.querySelectorAll("option");

  // 일치하는 옵션 숨기기
  options.forEach(option => {
    if (option.value === lessonSubject) {
      option.style.display = "none"; // 화면에서 숨기기
    }
  });

</script>

</body>

</html>



