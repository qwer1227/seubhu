<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
  <%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<style>
    #community-table th {
        text-align: center;
    }

    #community-table tr {
        height: 50px;
    }
</style>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">
  
  <h2> 커뮤니티 글 작성 </h2>
  
  <div class="row p-3 m-3">
    <form id="form-register" action="modify" method="post" enctype="multipart/form-data">
      <input type="hidden" name="no" value="${board.no}">
      <input type="hidden" name="fileNo" id="fileNo" value="${board.uploadFile.no}">
      <table id="community-table" style="width: 98%">
        <colgroup>
          <col width="10%">
          <col width="40%">
          <col width="15%">
          <col width="35%">
        </colgroup>
        <tbody>
        <tr class="form-group">
          <th>
            <label class="form-label" for="category">카테고리</label>
          </th>
          <td style="text-align: start">
            <select id="category" name="catName" class="form-control">
              <option hidden="hidden">게시판을 선택해주세요.</option>
              <option value="일반게시판" ${board.catName eq '일반게시판' ? 'selected' : ''}>일반</option>
              <option value="자랑게시판" ${board.catName eq '자랑게시판' ? 'selected' : ''}>자랑</option>
              <option value="질문게시판" ${board.catName eq '훈련게시판' ? 'selected' : ''}>질문</option>
              <option value="훈련일지" ${board.catName eq '훈련일지' ? 'selected' : ''}>훈련일지</option>
            </select>
          </td>
        </tr>
        <tr class="form-group">
          <th>
            <label class="form-label" for="title">글제목</label>
          </th>
          <td colspan="3">
            <input type="text" class="form-control" style="width: 100%" id="title" name="title"
                   placeholder="제목을 입력해주세요." value="${board.title}">
          
          </td>
        </tr>
        <tr class="form-group">
          <th>
            <label class="form-label" for="content">글내용</label>
          </th>
          <td colspan="3">
            <textarea style="width: 100%" class="form-control" rows="10" id="content"
                      name="content">${board.content}</textarea>
            
            <!-- <%@include file="write.jsp" %> -->
          </td>
        </tr>
        <c:if test="${not empty board.uploadFile}">
          <c:if test="${board.uploadFile.deleted eq 'N'}">
          <tr class="form-group">
            <th>
              <label class="form-label">기존파일명</label>
            </th>
            <td colspan="3" style="text-align: start">
                ${board.uploadFile.originalName}
              <button type="button" class="btn btn-outline-dark" onclick="deleteUploadFile(${board.no}, ${board.uploadFile.no})">
                삭제
              </button>
            </td>
          </tr>
          </c:if>
        </c:if>
        <tr class="form-group">
          <th>
            <label class="form-label">첨부파일</label>
          </th>
          <td colspan="3">
            <input type="file" class="form-control" name="upfile"/>
          </td>
        </tr>
        </tbody>
      </table>
      <div class="row">
        <div class="col d-flex justify-content-between">
          <div class="col d-flex" style="text-align: start">
            <button type="button" class="btn btn-secondary m-1" onclick="abort()">취소</button>
          </div>
          <div class="col d-flex justify-content-end">
            <button type="submit" class="btn btn-primary m-1">수정</button>
          </div>
        </div>
      </div>
    </form>
  </div>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
<script type="text/javascript">
    function abort() {
        let result = confirm("수정 중이던 글을 취소하시겠습니까?");
        if (result) {
            window.location.href = "detail?no=${board.no}";
        }
    }

    function deleteUploadFile(boardNo, fileNo) {
        let result = confirm("기존에 등록된 첨부파일을 삭제하시겠습니까?");
        if (result) {
            window.location.href = `delete-file?no=\${boardNo}&fileNo=\${fileNo}`;
        }
    }
</script>
</body>
</html>