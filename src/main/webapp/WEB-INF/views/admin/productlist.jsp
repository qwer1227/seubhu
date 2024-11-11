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
          <h1 class="h3 mb-0 text-gray-800">상품</h1>
        </div>
        <!-- 5-10-20개씩 보기 최신순 이름순 -->
        <form id="form-search" method="get" action="/admin/product">
          <input type="hidden" name="page" />
          <div class="rows g-3 d-flex">
            <div class="col-2 mb-4 pt-2">
              <select class="form-control" name="rows" onchange="changeRows()">
                <option value="5" ${param.rows eq 5 ? "selected" : ""}>5개씩 보기</option>
                <option value="10"${empty param.rows or param.rows eq 10 ? "selected" : ""}>10개씩 보기</option>
                <option value="20"${param.rows eq 20 ? "selected" : ""}>20개씩 보기</option>
              </select>
            </div>
            <div class="col-3 mt-2 pt-2">
              <div class="form-check form-check-inline">
                <div class="mr-2">
                  <input class="form-check-input"
                         type="radio"
                         name="sort"
                         value="latest"
                         onchange="changeSort()"/>
                  <label class="form-check-label">최신순</label>
                </div>
                <div class="mr-2">
                  <input class="form-check-input"
                         type="radio"
                         name="sort"
                         value="oldest"
                         onchange="changeSort()"/>
                  <label class="form-check-label">오래된순</label>
                </div>
              </div>
            </div>
            <div class="col-4 pt-2">
              <!-- Search -->
              <%@include file="/WEB-INF/views/admincommon/searchbar.jsp" %>
            </div>
          </div>
        </form>
        <!-- 5-10-20개씩 보기 최신순 이름순 끝 -->
      </div>
      <!-- 회원 리스트 -->
      <div class="row mb-3">
        <div class="col">
          <div class="border-bottom p-4 bg-light">
            <table class="table">
              <colgroup>
                <col width="10%">
                <col width="15%">
                <col width="*">
                <col width="15%">
                <col width="10%">
                <col width="15%">
              </colgroup>
              <thead>
              <tr>
                <th>번호</th>
                <th>카테고리</th>
                <th>상품명</th>
                <th>가격</th>
                <th>재고 수량</th>
                <th>상품 색상</th>
              </tr>
              </thead>
              <tbody>

              </tbody>
            </table>
          </div>
        </div>
      </div>
      <!-- 페이징처리 -->
        <c:if test="${not empty products}">
            <div class="row mb-3">
				<div class="col-12">
					<nav>
						<ul class="pagination justify-content-center">
						    <li class="page-item ${paging.first ? 'disabled' : '' }">
						    	<a class="page-link"
						    		onclick="changePage(${paging.prevPage}, event)"
						    		href="course?page=${paging.prevPage}">이전</a>
						    </li>
						<c:forEach var="num" begin="${paging.beginPage }" end="${paging.endPage }">
						    <li class="page-item ${paging.page eq num ? 'active' : '' }">
						    	<a class="page-link"
						    		onclick="changePage(${num }, event)"
						    		href="course?page=${num }">${num }</a>
						    </li>
						</c:forEach>
						    <li class="page-item ${paging.last ? 'disabled' : '' }">
						    	<a class="page-link"
						    		onclick="changePage(${paging.nextPage}, event)"
						    		href="course?page=${paging.nextPage}">다음</a>
						    </li>
					  	</ul>
					</nav>
				</div>
			</div>
        </c:if>
    <!-- 페이징처리 끝 -->
      <!-- end Page Content -->
    </div>
  </div>
</div>
<!-- Footer -->
<%@include file="/WEB-INF/views/admincommon/footer.jsp" %>
<!-- End of Footer -->

<%@include file="/WEB-INF/views/admincommon/common.jsp" %>

</body>
<script>
  const form =document.querySelector("#form-search");
  const pageInput = document.querySelector("input[name=page]");



  function changeSort() {
    pageInput.value = 1;
    form.submit();
  }

  // 한 화면에 표시할 행의 갯수가 변경될 때
  function changeRows() {
    pageInput.value = 1;		// 표시할 행의 갯수가 바뀌면 무조건 1페이지 요청
    form.submit();
  }

  // 검색어를 입력하고 검색버튼을 클릭했을 때
  function searchValue() {
    pageInput.value = 1;		// 정렬방식이 바뀌면
    form.submit();
  }

  // 페이지번호 링크를 클릭했을 때
  function changePage(page, event) {
    event.preventDefault();
    pageInput.value = page;	// 페이지번호 링크를 클릭했다면 해당 페이지 요청

    form.submit();
  }
</script>
</html>

