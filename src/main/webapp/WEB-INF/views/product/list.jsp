<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>

<div class="container-xxl text-center" id="wrap">
    <div class="col m-5">
        <h2>상품 전체 페이지</h2>
    </div>
        <div class="row row-cols-2 row-cols-lg-5 g-2 g-lg-3">
            <div class="col " >
                <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="#" onclick="function()">러닝화</a>
            </div>
            <div class="col " >
                <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="#">러닝복</a>
            </div>
            <div class="col " >
                <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="#">러닝용품</a>
            </div>
        </div>
    <div class="row mt-3">
        <div class="col-12">
            <form id="form-search" method="get" action="list">
                <input type="hidden" name="page" />
                <div class="row g-3">
                    <div class="col-2">
                        <select class="form-control" name="rows" onchange="changeRows()">
                            <option value="5" ${param.rows eq 5 ? "selected" : "" }>5개씩 보기</option>
                            <option value="10" ${empty param.rows or param.rows eq 10 ? "selected" : "" }>10개씩 보기</option>
                            <option value="20" ${param.rows eq 20 ? "selected" : "" }>20개씩 보기</option>
                        </select>
                    </div>
                    <div class="col-4 pt-2">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input"
                                   type="radio"
                                   name="sort"
                                   value="date"
                                   onchange="changeSort()"
                            ${empty param.sort or param.sort eq 'date' ? 'checked' : '' }
                            >
                            <label class="form-check-label" >최신순</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input"
                                   type="radio"
                                   name="sort"
                                   value="name"
                                   onchange="changeSort()"
                            ${param.sort eq 'name' ? 'checked' : '' }
                            >
                            <label class="form-check-label" >이름순</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input"
                                   type="radio"
                                   name="sort"
                                   value="price"
                                   onchange="changeSort()"
                            ${param.sort eq 'price' ? 'checked' : '' }
                            >
                            <label class="form-check-label" >가격순</label>
                        </div>
                    </div>
                    <div class="col-2">
                        <select class="form-control" name="opt">
                            <option value="name" ${param.opt eq 'name' ? 'selected' : '' }>상품명</option>
                            <option value="maker" ${param.opt eq 'maker' ? 'selected' : '' }> 제조회사</option>
                            <option value="minPrice" ${param.opt eq 'minPrice' ? 'selected' : '' }> 최소가격</option>
                            <option value="maxPrice" ${param.opt eq 'maxPrice' ? 'selected' : '' }> 최대가격</option>
                        </select>
                    </div>
                    <div class="col-3">
                        <input type="text" class="form-control" name="value" value=${param.value}>
                    </div>
                    <div class="col-1">
                        <button class="btn btn-outline-primary" onclick="searchValue()">검색</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
        <div class="row row-cols-1 row-cols-md-3 g-4 mt-1 mb-5">
            <c:forEach var="prod"  items="${products }">
                <div class="col">
                    <div class="card h-100">
                    <c:forEach items="${prod.images}" var="img">
                        <a class="text-decoration-none" href="detail">
                            <img src="${img.url}" class="card-img-top" alt="...">
                        </a>
                    </c:forEach>
                        <div class="card-body">
                            <h5 class="card-title">${prod.name}</h5>
                            <div class="text-decoration-none" href="detail">
                                <div>${prod.category.name}</div>
                                <div class="card-text"><fmt:formatNumber value="${prod.price }"/> 원</div>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent border-primary" >${prod.status}</div>
                    </div>
                </div>
            </c:forEach>
        </div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>