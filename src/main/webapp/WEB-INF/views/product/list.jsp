<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/common/common.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/common/nav.jsp" %>

<div class="container-xxl text-center" id="wrap">
    <div class="col m-5">
        <h2>상품 전체 페이지</h2>
    </div>
        <div class="row row-cols-2 row-cols-lg-5 g-2 g-lg-3">
            <div class="col " >
                <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="#">러닝화</a>
            </div>
            <div class="col " >
                <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="#">러닝복</a>
            </div>
            <div class="col " >
                <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;" href="#">러닝용품</a>
            </div>
        </div>
        <div class="row row-cols-1 row-cols-md-3 g-4 mt-5 mb-5">
            <div class="col">
                <div class="card h-100">
                    <a class="text-decoration-none" href="detail">
                        <img src="image1.PNG" class="card-img-top" alt="...">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title">Card title</h5>
                        <a class="text-decoration-none" href="detail">
                            <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                        </a>
                    </div>
                    <div class="card-footer bg-transparent border-primary" >판매중</div>
                </div>
            </div>
            <div class="col">
                <div class="card h-100">
                    <a class="text-decoration-none" href="detail">
                        <img src="image1.PNG" class="card-img-top" alt="...">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title">Card title</h5>
                        <a class="text-decoration-none" href="detail">
                            <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                        </a>
                    </div>
                    <div class="card-footer bg-transparent border-primary" >판매중</div>
                </div>
            </div>
            <div class="col">
                <div class="card h-100">
                    <a class="text-decoration-none" href="detail">
                        <img src="image1.PNG" class="card-img-top" alt="...">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title">Card title</h5>
                        <a class="text-decoration-none" href="detail">
                            <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                        </a>
                    </div>
                    <div class="card-footer bg-transparent border-primary" >판매중</div>
                </div>
            </div>
            <div class="col">
                <div class="card h-100">
                    <a class="text-decoration-none" href="detail">
                        <img src="image1.PNG" class="card-img-top" alt="...">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title">Card title</h5>
                        <a class="text-decoration-none" href="detail">
                            <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                        </a>
                    </div>
                    <div class="card-footer bg-transparent border-primary" >판매중</div>
                </div>
            </div>
        </div>
    </div>

<%@include file="/WEB-INF/common/footer.jsp" %>
</body>
</html>