<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
  <%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<style>
    #content-title:hover {
        text-decoration: underline;
        font-weight: bold;
    }
</style>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">
  <div class="row p-3 justify-content-center">
    <div class="col mb-3">
      <h2> 커뮤니티 </h2>
    </div>
  </div>
  
  <div class="row">
    <div class="col-7" style="margin: 15px; border: 1px solid black">
      <table class="m-3">
        <tbody>
        <tr>
          <td>
            <a href="" style="text-decoration-line: none; color: black; font-weight: bold">공지사항 => 5개만 보여줄 예정</a>
          </td>
        </tr>
        </tbody>
      </table>
    </div>
    
    <div class="col" style="margin: 15px; border: 1px solid black">
      광고 올 자리
    </div>
  </div>
  
  <div class="row row-cols-2 row-cols-lg-5 g-2 g-lg-3">
    <div class="col ">
      <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;"
         href="#">전체</a>
    </div>
    <div class="col ">
      <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;"
         href="#">일반</a>
    </div>
    <div class="col ">
      <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;"
         href="#">자랑</a>
    </div>
    <div class="col ">
      <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;"
         href="#">질문</a>
    </div>
    <div class="col ">
      <a class="nav-link p-3 border-start border-primary border-4 bg-light" style="border-color: #0064FF;"
         href="#">훈련일지</a>
    </div>
  </div>
  
  <!--  게시글 목록 -->
  <div class="row p-3">
    <table class="table">
      <colgroup>
        <col width="5%">
        <col width="10%">
        <col width="*%">
        <col width="15%">
        <col width="10%">
        <col width="10%">
        <col width="10%">
      </colgroup>
      <thead class="text-start">
        <tr style="text-align: center">
          <th>번호</th>
          <th>분류</th>
          <th>제목</th>
          <th>작성자</th>
          <th>추천</th>
          <th>조회</th>
          <th>날짜</th>
        </tr>
      </thead>
      <tbody class="text-start">
        <c:choose>
          <c:when test="${empty boards}">
            <tr>
              <td colspan="7" style="text-align: center">등록된 게시글이 없습니다.</td>
            </tr>
          </c:when>
          <c:otherwise>
            <c:forEach var="board" items="${boards}">
              <tr style="text-align: center">
                <td>${board.no}</td>
                <td>${board.catName}</td>
                <td id="content-title" style="text-align: start">
                  <a href="detail?no=${board.no}" style="text-decoration-line: none; color: black">${board.title}</a>
                </td>
                <td>${board.user.nickname}</td>
                <td>${board.like}</td>
                <td>${board.viewCnt}</td>
                <td><fmt:formatDate value="${board.createdDate}" pattern="yyyy-MM-dd"/></td>
              </tr>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </tbody>
    </table>
  </div>
  
  <!-- 검색 및 글쓰기 기능 -->
  <form id="form-search" method="get" action="main">
    <input type="hidden" name="page" value="${param.page != null ? param.page : 1}">
    <div class="row p-3 d-flex justify-content-left">
      <div class="col-2">
        <select class="form-control" name="opt">
          <option value="title" ${param.opt eq 'title' ? 'selected' : ''}> 게시글 제목</option>
          <option value="content" ${param.opt eq 'content' ? 'selected' : ''}> 게시글 내용</option>
          <option value="writer" ${param.opt eq 'writer' ? 'selected' : ''}> 작성자</option>
          <%--        <option value="hashtag"> 해시태그</option>--%>
        </select>
      </div>
      
      <div class="col-2">
        <input type="text" class="form-control" name="value" value="">
      </div>
      <div class="col-1">
        <button class="btn btn-outline-primary" onclick="searchKeyword()">검색</button>
      </div>
      <div class="col d-flex justify-content-center">
      
      </div>
      <div class="col d-flex justify-content-end">
        <a href="form" type="button" class="btn btn-primary">글쓰기</a>
      </div>
    </div>
  </form>
  
  <!-- 페이징처리 -->
  <div>
    <ul class="pagination justify-content-center">
      <li class="page-item ${paging.first ? 'disabled' : '' }">
        <a class="page-link"
           onclick="changePage(${paging.prevPage}, event)"
           href="javascript:void(0)"><<</a>
      </li>
      
      <c:forEach var="num" begin="${paging.beginPage }" end="${paging.endPage }">
        <li class="page-item ${paging.page eq num ? 'active' : '' }">
          <a class="page-link"
             onclick="changePage(${num }, event)"
             href="javascript:void(0)">${num }</a>
        </li>
      </c:forEach>
      
      <li class="page-item ${paging.last ? 'disabled' : '' }">
        <a class="page-link"
           onclick="changePage(${paging.nextPage}, event)"
           href="javascript:void(0)">>></a>
      </li>
    </ul>
  </div>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
<script type="text/javascript">
    const pageInput = document.querySelector("input[name=page]");

    // 페이지 번호 링크를 클릭했을 때 변화
    function changePage(page, event) {
        event.preventDefault();
        // 페이지 번호 링크를 클릭했다면 해당 페이징 요청
        let form = document.querySelector("#form-search");
        let input = document.querySelector("input[name=page]");

        input.value = page;

        form.submit();
    }

    // 정렬방식이 변경될 때
    function changeSort() {
        pageInput.value = 1;
        form.submit();
    }

    // 검색어를 입력하고 검색버튼을 클릭 했을 때
    function searchValue() {
        pageInput.value = 1;
        form.submit();

    }

    // 한 화면에 표기할 행의 갯수가 변경될 때
    function changeRows() {
        pageInput.value = 1;
        form.submit();
    }
</script>
</html>