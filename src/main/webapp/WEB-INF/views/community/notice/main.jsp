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
					<col width="3%">
					<col width="*">
					<col width="10%">
					<col width="15%">
				</colgroup>
				<thead>
				<tr style="text-align: center">
					<th></th>
					<th>제목</th>
					<th>조회</th>
					<th>날짜</th>
				</tr>
				</thead>
				<tbody style="text-align: center">
				<c:choose>
				<c:when test="${empty notices}">
					<tr>
						<td colspan="4" style="text-align: center">검색된 공지사항이 없습니다.</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="notice" items="${notices}">
						<tr>
						  <td></td>
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
				</c:otherwise>
				</c:choose>
				</tbody>
			</table>
		</div>
		<div class="row p-3 d-flex justify-content-left">
			<div class="col-2">
				<select class="form-control" name="opt">
					<option value="all" ${param.opt eq 'all' ? 'selected' : ''}> 제목+내용</option>
					<option value="title" ${param.opt eq 'title' ? 'selected' : ''}> 제목</option>
					<option value="content" ${param.opt eq 'content' ? 'selected' : ''}> 내용</option>
				</select>
			</div>
			<div class="col-4">
				<input type="text" class="form-control" name="keyword" value="${param.keyword }">
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
		
		<!-- 페이징처리 -->
		<c:if test="${paging.totalRows > 10}">
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
		</c:if>
	</form>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
<script type="text/javascript">
    function changePage(page, event) {
        event.preventDefault();
        let form = document.querySelector("#form-search");
        let pageInput = form.querySelector("input[name=page]");
        pageInput.value = page;
        form.submit();
    }

    function searchValue() {
        let pageInput = form.querySelector("input[name=page]");
        pageInput.value = 1;
        form.submit();
    }

    function searchKeyword() {
        pageInput.value = 1;
        form.submit();
    }
</script>
</html>