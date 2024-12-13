<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">

    <div class="row m-5">
        <h2>위시리스트</h2>
    </div>
    <hr class="bg-primary border border-1">

    <div class="row row-cols-1 row-cols-md-3 g-4 mt-5 mb-5">
        <c:forEach var="item" items="${wishItemDtoList}">
            <input type="hidden" name="prodNo" value="${item.product.no}"/>
            <input type="hidden" name="sizeNo" value="${item.size.no}"/>
            <input type="hidden" name="colorNo" value="${item.color.no}"/>
            <input type="hidden" name="userNo" value="${item.user.no}">
            <div class="col">
                <div class="card h-100">
                    <a class="text-decoration-none" href="/product/detail?no=${item.product.no}&colorNo=${item.color.no}">
                    <c:forEach var="img" items="${item.images}">
                        <img src="${img.url}" class="card-img-top" alt="...">
                    </c:forEach>
                    </a>
                    <div class="card-body">
                        <h5 class="card-title">${item.product.name}</h5>
                        <h5>[${item.color.name}/${item.size.size}]</h5>
                        <div>
                            <p>${item.category.name}</p>
                            <p><strong><fmt:formatNumber value="${item.product.price}"/> 원</strong></p>
                        </div>
                        <hr class="bg-primary border border-1">
                        <button class="btn btn-outline-secondary">장바구니 추가</button>
                        <button class="btn btn-outline-secondary"><i class="bi bi-heart"></i></button>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>


<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
