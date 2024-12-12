<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
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
                    <h1 class="h3 mb-0 text-gray-800">주문&배송 조회</h1>
                </div>
                <div class="row mt-3">
                    <div class="col-12">
                        <form id="form-search" method="get" action="/admin/order-delivery">
                            <input type="hidden" name="page" />
                            <input type="hidden" name="rows" />
                            <div class="row g-3">
                                <div class="row col-2 align-items-center pr-2">
                                    <label for="dateInput" class="col-auto col-form-label">날짜</label>
                                    <div class="col">
                                        <%
                                            // 현재 날짜 가져오기
                                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                                            String currentDate = sdf.format(new Date()); // 현재 날짜를 "yyyy-MM-dd" 형식으로 변환
                                            request.setAttribute("currentDate", currentDate); // request에 currentDate를 설정
                                        %>
                                        <input
                                                type="date"
                                                name="day"
                                                id="dateInput"
                                                value="${param.day != null ? param.day : currentDate}"
                                                class="form-control form-control-sm rounded-pill border-gray"
                                        />
                                    </div>
                                </div>
                                <div class="col-2 ml-3 pt-2">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input"
                                               type="radio"
                                               name="sort"
                                               value="latest"
                                               onchange="changeSort()"
                                        ${empty param.sort or param.sort eq 'latest' ? 'checked' : ''}
                                        >
                                        <label class="form-check-label" >최신 순</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input"
                                               type="radio"
                                               name="sort"
                                               value="oldestDate"
                                               onchange="changeSort()"
                                        ${param.sort eq 'oldestDate' ? 'checked' : ''}
                                        >
                                        <label class="form-check-label" >오래된 순</label>
                                    </div>
                                </div>
                                <div class="col-2">
                                    <select class="form-control" name="opt">
                                        <option value="all" ${param.opt eq 'all' ? 'selected' : ''}>주문상태</option>
                                        <option value="notReady" ${param.opt eq 'notReady' ? 'selected' : '' }>상품준비중</option>
                                        <option value="ready" ${param.opt eq 'ready' ? 'selected' : '' }>상품배송중</option>
                                        <option value="complete" ${param.opt eq 'complete' ? 'selected' : '' }>배송완료</option>
                                        <option value="cancel" ${param.opt eq 'cancel' ? 'selected' : '' }>배송취소</option>
                                    </select>
                                </div>
                                <div class="col-1">
                                    <select class="form-control" name="keyword">
                                        <option value="all" ${param.keyword eq 'all' ? 'selected' : ''}>선택안함</option>
                                        <option value="orderName" ${param.keyword eq 'orderName' ? 'selected' : ''}>주문자</option>
                                    </select>
                                </div>
                                <div class="col-3">
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
                  <col width="7%">
                  <col width="25%">
                  <col width="8%">
                  <col width="8%">
                  <col width="7%">
                  <col width="10%">
                  <col width="10%">
                  <col width="8%">
                  <col width="7%">
                </colgroup>
                <thead>
                  <tr>
                    <th>배송번호</th>
                    <th>주문번호</th>
                    <th>주문자</th>
                    <th>주문상태</th>
                    <th>배송업체</th>
                    <th>배송상태</th>
                    <th>수령인 연락처</th>
                    <th>주문날짜</th>
                    <th>결제상태</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="d" items="${dto}">
                    <tr>
                      <td>${d.payType}</td>
                      <td>${d.userName}</td>
                      <td>${d.userId}</td>
                      <td>
                        <a href="javascript:void(0);" onclick="previewProd(${d.orderNo})">
                          ${d.prodName}
                        </a>
                      </td>
                      <td><fmt:formatNumber value="${d.payPrice }"/> 원</td>
                      <td>${d.payMethod}</td>
                      <td>${d.payStatus}</td>
                      <td>
                      ${d.payDate}
                      </td>
                      <td>
                      ${d.payTime}
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
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

