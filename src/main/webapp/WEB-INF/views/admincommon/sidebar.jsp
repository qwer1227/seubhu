<%@ page pageEncoding="UTF-8"%>

<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="home">
        <div class="sidebar-brand-icon rotate-n-15">
            <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">습습후후 <sup></sup></div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider my-0">

    <!-- Nav Item - Dashboard -->
    <li class="nav-item active">
        <a class="nav-link" href="home">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>Dashboard</span></a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading -->
    <div class="sidebar-heading">
        관리
    </div>

    <!-- 코스관리 토글 -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseOne"
           aria-expanded="true" aria-controls="collapseOne">
            <i class="fas fa-fw fa-cog"></i>
            <span>코스관리</span>
        </a>
        <div id="collapseOne" class="collapse" aria-labelledby="headingOne" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">코스</h6>
                <a class="collapse-item" href="course">코스 전체</a>
                <a class="collapse-item" href="course-register-form">코스 등록하기</a>
                <a class="collapse-item" href="course">코스 수정하기</a>
            </div>
        </div>
    </li>

    <!-- 회원관리 토글 -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
           aria-expanded="true" aria-controls="collapseTwo">
            <i class="fas fa-fw fa-cog"></i>
            <span>회원관리</span>
        </a>
        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">회원</h6>
                <a class="collapse-item" href="user">회원 전체</a>
                <a class="collapse-item" href="blacklist">블랙리스트</a>
            </div>
        </div>
    </li>

    <!-- 상품관리 토글 -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseThree"
           aria-expanded="true" aria-controls="collapseThree">
            <i class="fas fa-fw fa-cog"></i>
            <span>상품관리</span>
        </a>
        <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">상품</h6>
                <a class="collapse-item" href="product?topNo=10">남성 상품 전체</a>
                <a class="collapse-item" href="product?topNo=20">여성 상품 전체</a>
                <a class="collapse-item" href="product?topNo=30">러닝용품 전체</a>
                <a class="collapse-item" href="product-register-form">상품 등록하기</a>
            </div>
        </div>
    </li>

    <!-- 재고관리 토글 -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseFour"
           aria-expanded="true" aria-controls="collapseFour">
            <i class="fas fa-fw fa-cog"></i>
            <span>커뮤니티</span>
        </a>
        <div id="collapseFour" class="collapse" aria-labelledby="headingFour" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">커뮤니티</h6>
                <a class="collapse-item" href="">커뮤니티 바로가기</a>
                <a class="collapse-item" href="">신고글 보기</a>
                <a class="collapse-item" href="qna">1:1 문의사항</a>
            </div>
        </div>
    </li>

    <!-- 재고관리 토글 -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseFive"
           aria-expanded="true" aria-controls="collapseFive">
            <i class="fas fa-fw fa-cog"></i>
            <span>배송&재고&정산 관리</span>
        </a>
        <div id="collapseFive" class="collapse" aria-labelledby="headingFive" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">배송&재고&정산</h6>
                <a class="collapse-item" href="order">배송</a>
                <a class="collapse-item" href="product-stock?topNo=0">상품 재고 등록하기</a>
                <a class="collapse-item" href="settlement">정산관리</a>
            </div>
        </div>
    </li>

    <!-- 커뮤니티 토글 -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseSix"
           aria-expanded="true" aria-controls="collapseSix">
            <i class="fas fa-fw fa-cog"></i>
            <span>레슨관리</span>
        </a>
        <div id="collapseSix" class="collapse" aria-labelledby="headingSix" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">레슨</h6>
                <a class="collapse-item" href="lesson">레슨 전체&수정</a>
                <a class="collapse-item" href="lesson-register-form">레슨 등록하기</a>
            </div>
        </div>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider">


    <!-- Sidebar Toggler (Sidebar) -->
    <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>

</ul>