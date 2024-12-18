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
	<link href="${pageContext.request.contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
				type="text/css">
	<link
		href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
		rel="stylesheet">
	<!-- Bootstrap CSS 링크 예시 페이지네이션-->
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
	<!-- Custom styles for this template-->
	<link href="${pageContext.request.contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>
<style>
    .category-nav a {
        font-size: 20px;
        font-weight: bolder;
        color: #0064FF;
        padding: 10px 20px;
        border: 2px solid #0064FF;
        border-radius: 5px;
        text-decoration: none;
        margin: 0 10px;
    }

    .category-nav a:hover {
        background-color: #0064FF;
        color: white;
    }

    .overlay-text {
        position: absolute; /* 부모 기준으로 절대 위치 설정 */
        top: 40%; /* 컨테이너의 세로 중심 */
        left: 50%; /* 컨테이너의 가로 중심 */
        transform: translate(-50%, -50%); /* 정확히 중앙으로 이동 */
        color: white; /* 텍스트 색상 */
        font-size: 1.5rem; /* 텍스트 크기 */
        font-weight: bold; /* 텍스트 굵기 */
        text-align: center; /* 텍스트 가운데 정렬 */
        background-color: rgba(0, 0, 0, 0.5); /* 텍스트 배경 반투명 설정 */
        padding: 10px; /* 텍스트 주변 여백 추가 */
        border-radius: 5px; /* 배경의 모서리 둥글게 처리 (선택 사항) */
    }
</style>
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
					<h1 class="h3 mb-0 text-gray-800">마라톤</h1>
				</div>
				<!-- Search -->
				
				<div class="row g-3 d-flex">
					<div class="col-2 mb-4 pt-2">
						<select class="form-control" name="rows" onchange="changeRows()">
							<option value="all" ${empty param.category or param.category eq 'all' ? "selected" : ""}>전체</option>
							<option value="Y" ${param.category eq 'Y' ? "selected" : ""}>진행중</option>
							<option value="N" ${param.category eq 'N' ? "selected" : ""}>마감</option>
						</select>
					</div>
					
					<div class="col-2 mb-4 pt-2">
						<select class="form-control" name="opt">
							<option value="all" ${param.opt eq 'all' ? 'selected' : ''}> 제목+내용</option>
							<option value="title" ${param.opt eq 'title' ? 'selected' : ''}> 제목</option>
							<option value="content" ${param.opt eq 'content' ? 'selected' : ''}> 내용</option>
							<option value="organ" ${param.opt eq 'organ' ? 'selected' : ''}> 주최/주관 기관</option>
						</select>
					</div>
					<div class="col-4 pt-2">
						<%@include file="/WEB-INF/views/admincommon/searchbar.jsp" %>
					</div>
				</div>
				
				<div class="row p-3 justify-content-center">
					<div class="col mb-3">
						<c:choose>
							<c:when test="${empty marathons}">
								<div class="col p-5" style="justify-content: center; text-align: center;">
									<strong>해당 검색 조건에 해당하는 마라톤 정보가 없습니다.</strong>
								</div>
							</c:when>
							<c:otherwise>
								<div class="row row-cols-1 row-cols-md-3 g-4">
									<!-- 카드 1 -->
									<c:forEach var="marathon" items="${marathons}">
										<div class="col">
											<a href="../community/marathon/detail?no=${marathon.no}" style="text-decoration-line: none">
												<div class="card">
													<img src="${marathon.thumbnail}" class="card-img-top" alt="마라톤 이미지"
															 style="height: 250px; filter: ${marathon.marathonDate.time > now.time ? 'grayscale(0%)' : 'grayscale(100%)'};">
													<c:if test="${marathon.marathonDate.time < now.time}">
														<div class="overlay-text ">종료</div>
													</c:if>
													<div class="card-body text-center">
														<h5 class="card-title">${marathon.title}</h5>
														<p class="card-text"><fmt:formatDate value="${marathon.marathonDate}"
																																 pattern="yyyy-MM-dd"/></p>
													</div>
												</div>
											</a>
										</div>
									</c:forEach>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				
				<c:if test="${not empty marathons}">
					<div class="row mb-3">
						<div class="col-12">
							<nav>
								<ul class="pagination justify-content-center">
									<li class="page-item ${paging.first ? 'disabled' : '' }">
										<a class="page-link"
											 onclick="changePage(${paging.prevPage}, event)"
											 href="marathon?page=${paging.prevPage}">이전</a>
									</li>
									<c:forEach var="num" begin="${paging.beginPage }" end="${paging.endPage }">
										<li class="page-item ${paging.page eq num ? 'active' : '' }">
											<a class="page-link"
												 onclick="changePage(${num }, event)"
												 href="marathon?page=${num }">${num }</a>
										</li>
									</c:forEach>
									<li class="page-item ${paging.last ? 'disabled' : '' }">
										<a class="page-link"
											 onclick="changePage(${paging.nextPage}, event)"
											 href="marathon?page=${paging.nextPage}">다음</a>
									</li>
								</ul>
							</nav>
						</div>
					</div>
				</c:if>
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
<script>
    function changeCategory(category) {
        let form = document.querySelector("#form-search");
        let catInput = document.querySelector("#categoryInput");
        let pageInput = document.querySelector("input[name=page]");

        catInput.value = category;
        pageInput.value = 1;

        form.submit();
    }

    function changePage(page, event) {
        event.preventDefault();
        let form = document.querySelector("#form-search");
        let pageInput = form.querySelector("input[name=page]");
        pageInput.value = page;
        form.submit();
    }

    // 검색어를 입력하고 검색버튼을 클릭했을 때
    function searchValue() {
        pageInput.value = 1;		// 정렬방식이 바뀌면
        form.submit();
    }
</script>
</html>

