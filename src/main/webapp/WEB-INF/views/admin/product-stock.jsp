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
                    <h1 class="h3 mb-0 text-gray-800">재고 현황</h1>
                </div>
                <div class="row mt-3">
                    <div class="col-12">
                        <form id="form-search" method="get" action="/admin/product-stock">
                            <input type="hidden" name="page" />
                            <input type="hidden" name="topNo" value="${topNo}">
                            <input type="hidden" name="catNo" value="${catNo}">
                            <div class="row g-3">
                                <div class="col-2">
                                    <select class="form-control" name="rows" onchange="changeRows()">
                                        <option value="5" ${empty param.rows or param.rows eq 5? "selected" : ""}>5개씩 보기</option>
                                        <option value="10" ${param.rows eq 10? "selected" : ""}>10개씩 보기</option>
                                        <option value="20" ${param.rows eq 20? "selected" : ""}>20개씩 보기</option>
                                    </select>
                                </div>
                                <div class="col-3 pt-2">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input"
                                               type="radio"
                                               name="sort"
                                               value="date"
                                               onchange="changeSort()"
                                               ${empty param.sort or param.sort eq 'date' ? 'checked' : ''}
                                        >
                                        <label class="form-check-label" >최신순</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input"
                                               type="radio"
                                               name="sort"
                                               value="name"
                                               onchange="changeSort()"
                                               ${param.sort eq 'name' ? 'checked' : ''}
                                        >
                                        <label class="form-check-label" >이름순</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input"
                                               type="radio"
                                               name="sort"
                                               value="price"
                                               onchange="changeSort()"
                                               ${param.sort eq 'price' ? 'checked' : ''}
                                        >
                                        <label class="form-check-label" >가격순</label>
                                    </div>
                                </div>
                                <div class="col-2">
                                    <select class="form-control" name="opt">
                                        <option value="name" ${param.opt eq 'name' ? 'selected' : ''} >상품명</option>
                                        <option value="minPrice" ${param.opt eq 'minPrice' ? 'selected' : '' }>최소가격</option>
                                        <option value="maxPrice" ${param.opt eq 'maxPrice' ? 'selected' : '' }>최대가격</option>
                                    </select>
                                </div>
                                <div class="col-4 mb-2">
                                  <!-- Search -->
                                  <%@include file="/WEB-INF/views/admincommon/searchbar.jsp" %>
                                    <!-- Search -->
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                    <div class="row mb-3">
                        <div class="col-12">
                            <div class="border-bottom pt-4 pr-4 pl-4 bg-light">
                                <table class="table">
                                    <colgroup>
                                        <col width="10%">
                                        <col width="7%">
                                        <col width="15%">
                                        <col width="*%">
                                        <col width="10%">
                                        <col width="10%">
                                        <col width="10%">
                                        <col width="10%">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th>상품번호</th>
                                            <th>브랜드</th>
                                            <th>카테고리</th>
                                            <th>상품명</th>
                                            <th>가격</th>
                                            <th>대표색상</th>
                                            <th>상태</th>
                                            <th>설정</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="p" items="${products}">
                                            <tr>
                                                <td>${p.no}</td>
                                                <td>${p.brand.name}</td>
                                                <td>${p.category.name}</td>
                                                <td>${p.name}</td>
                                                <td><fmt:formatNumber value="${p.price }"/> 원</td>
                                                <td>${p.color.name}</td>
                                                <td>${p.status}</td>
                                                <td>
                                                    <a href="/admin/product-stock-detail?no=${p.no}&colorNo=${p.color.no}">
                                                        <button type="button" class="btn btn-success">재고추가</button>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- 페이징 처리 -->
                    <div class="row mb-3">
                        <div class="col-12">
                            <nav>
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${paging.first? 'disabled' : ''}">
                                        <a class="page-link"
                                        onclick="changePage(${paging.prevPage}, event)"
                                        href="product?page=${paging.prevPage}">이전</a>
                                    </li>
                                    <c:forEach var="num" begin="${paging.beginPage}" end="${paging.endPage}">
                                        <li class="page-item ${paging.page eq num ? 'active' : ''}">
                                            <a class="page-link"
                                            onclick="changePage(${num}, event)"
                                            href="product?page=${num}">${num}</a>
                                        </li>
                                    </c:forEach>
                                    <li class="page-item ${paging.last ? 'disabled' : ''}" >
                                        <a class="page-link"
                                        onclick="changePage(${paging.nextPage}, event)"
                                        href="product?page=${paging.nextPage}">다음</a>
                                    </li>
                                </ul>
                            </nav>
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
</body>

</html>


