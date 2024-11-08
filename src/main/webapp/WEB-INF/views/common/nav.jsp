<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    <%-- 폰트 스타일 --%>
    * {
        font-family: 'Noto Sans KR', sans-serif;
    }

    <%-- 푸터 간격 CSS --%>
    html,
    body {
        margin: 0;
        padding: 0;
        height: 100%;
    }

    #wrap {
        min-height: 100%;
        position: relative;
        padding-bottom: 60px;
    }

    footer {
        bottom: 0;
    }
</style>
<nav class="navbar navbar-expand-lg bg-body-tertiary mb-5"
     style="border-top: 2px solid#0064FF; border-bottom:2px solid#0064FF;">
    <div class="container-xxl" style="height: 60px;">
        <a class="navbar-brand" href="index.html" style="color: #0064FF;
  font-size: 30px; font-weight: bolder;">습습후후</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup"
                aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="product/list">상품</a>
                <div class="divider" style="border-left: 1px solid #0e0d0d; margin: 0 7px;"></div>
                <a class="nav-link" href="#">코스</a>
                <div class="divider" style="border-left: 1px solid #0e0d0d; margin: 0 7px;"></div>
                <a class="nav-link " href="#">레슨</a>
                <div class="divider" style="border-left: 1px solid #0e0d0d; margin: 0 7px;"></div>
                <a class="nav-link " href="#">커뮤</a>
                <div class="divider" style="border-left: 1px solid #0e0d0d; margin: 0 7px;"></div>
                <a class="nav-link " href="#">로그인</a>
                <div style="padding: 0 20px;"></div>
            </div>
        </div>
    </div>
</nav>