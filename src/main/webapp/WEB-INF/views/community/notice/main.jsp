<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
  <%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<style>
    #content-title:hover {
        text-decoration: black underline;
        font-weight: bold;
    }
</style>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">
  <div class="row p-3 justify-content-center">
    <div class="col mb-3">
      <h2> 공지사항 </h2>
    </div>
  </div>
  
  <form id="form-search" method="get" action="main">
    <input type="hidden" name="page" value="${param.page != null ? param.page : 1}">
    <div class="row p-3">
      <table class="table">
        <colgroup>
          <col width="10%">
          <col width="*%">
          <col width="10%">
          <col width="15%">
        </colgroup>
        <thead>
        <tr style="text-align: center">
          <th>번호</th>
          <th>제목</th>
          <th>조회</th>
          <th>날짜</th>
        </tr>
        </thead>
        <tbody style="text-align: center">
        <c:forEach var="notice" items="${notices}">
          <tr>
            <td>${notice.no}</td>
            <td id="content-title" style="text-align: start">
              <a href="hit?no=${notice.no}"
                 style="text-decoration-line: none; color: ${notice.first eq 'true' ? 'red' : 'black'}">
                  ${notice.title}
              </a>
            </td>
            <td>${notice.viewCnt}</td>
            <td><fmt:formatDate value="${notice.createdDate}" pattern="yyyy-MM-dd"/></td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
    <div class="row p-3 d-flex justify-content-left">
      <div class="col-4">
        <input type="text" class="form-control" name="value" value="">
      </div>
      <div class="col-1">
        <button class="btn btn-outline-primary">검색</button>
      </div>
      <div class="col d-flex justify-content-center">
      
      </div>
      <div class="col d-flex justify-content-end">
        <a href="form" type="button" class="btn btn-primary">글쓰기</a>
      </div>
    </div>
    
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
  </form>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
<script type="text/javascript">
    function changePage(page, event) {
        // 기본 동작을 막음
        event.preventDefault();
        // 페이지 번호 링크를 클릭했다면 해당 페이징 요청
        let form = document.querySelector("#form-search");
        // 페이지 번호 input 요소 선택
        let pageInput = form.querySelector("input[name=page]");
        // 페이지 번호를 원하는 값으로 설정
        pageInput.value = page;
        // 폼 제출
        form.submit();
    }
</script>
</html>