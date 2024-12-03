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
        <h1 class="h3 mb-0 text-gray-800">1:1 문의사항</h1>
    </div>



    <!-- QnA List -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">문의사항 목록</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                            <th>상태</th>
                            <th>관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="qna" items="${qnaList}">
                            <tr>
                                <td>${qna.qnaNo}</td>
                                <td><a href="/mypage/qna/${qna.qnaNo}">${qna.title}</a></td>
                                <td>${qna.writer}</td>
                                <td>${qna.createdDate}</td>
                                <td>${qna.status}</td>
                                <td>
                                    <a href="/mypage/qna/update/${qna.qnaNo}" class="btn btn-sm btn-primary">수정</a>
                                    <a href="/mypage/qna/delete/${qna.qnaNo}" class="btn btn-sm btn-danger" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <nav aria-label="Page navigation example">
                <ul class="pagination justify-content-center">
                    <c:if test="${pagination.hasPreviousPage}">
                        <li class="page-item">
                            <a class="page-link" href="?page=${pagination.previousPage}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach var="pageNum" begin="${pagination.startPage}" end="${pagination.endPage}">
                        <li class="page-item ${pageNum == pagination.currentPage ? 'active' : ''}">
                            <a class="page-link" href="?page=${pageNum}">${pageNum}</a>
                        </li>
                    </c:forEach>
                    <c:if test="${pagination.hasNextPage}">
                        <li class="page-item">
                            <a class="page-link" href="?page=${pagination.nextPage}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
            <!-- Search -->
            <div class="card mb-4">
                <div class="card-header py-3">
                    <h6 class="m-0 font-weight-bold text-primary">검색 조건</h6>
                </div>
                <div class="card-body">
                    <form action="/mypage/qna" method="get" class="row g-3">
                        <div class="col-md-4">
                            <label for="opt" class="form-label">검색 조건</label>
                            <select class="form-select" id="opt" name="opt">
                                <option value="">선택하세요</option>
                                <option value="title" ${param.opt == 'title' ? 'selected' : ''}>제목</option>
                                <option value="writer" ${param.opt == 'writer' ? 'selected' : ''}>작성자</option>
                                <option value="status" ${param.opt == 'status' ? 'selected' : ''}>상태</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="value" class="form-label">검색 값</label>
                            <input type="text" class="form-control" id="value" name="value" value="${param.value}">
                        </div>
                        <div class="col-md-4 align-self-end">
                            <button type="submit" class="btn btn-primary w-100">검색</button>
                        </div>
                    </form>
                </div>
            </div>

            <%@include file="/WEB-INF/views/admincommon/searchbar.jsp" %>
        </div>
    </div>
</div>


<!-- Footer -->
<%@include file="/WEB-INF/views/admincommon/footer.jsp" %>
<!-- End of Footer -->

<%@include file="/WEB-INF/views/admincommon/common.jsp" %>

</body>

</html>

