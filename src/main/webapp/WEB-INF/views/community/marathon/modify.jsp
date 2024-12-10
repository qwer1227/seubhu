<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<script type="text/javascript" src="../resources/static/smartEditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<!doctype html>
<html lang="ko">
<head>
  <%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<style>
    #marathon-table th {
        text-align: center;
    }

    #marathon-table tr {
        height: 50px;
    }
</style>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">
  
  <h2>마라톤 정보 작성</h2>
  
  <div class="row p-3">
    <form method="post" action="modify" enctype="multipart/form-data">
      <input type="hidden" name="no" value="${marathon.no}">
      <table id="marathon-table" style="width: 98%">
        <colgroup>
          <col width="10%">
          <col width="40%">
          <col width="10%">
          <col width="40%">
        </colgroup>
        <tbody>
        <tr>
          <th>마라톤 이름</th>
          <td colspan="3"><input type="text" name="title" value="${marathon.title}" style="width: 100%"></td>
        </tr>
        <tr>
          <th>일시</th>
          <td><input type="date" name="marathonDate"
                     value="<fmt:formatDate value="${marathon.marathonDate}" pattern="yyyy-MM-dd"/>" style="width: 50%">
          </td>
          <th>접수기간</th>
          <td>
            <input type="date" name="startDate"
                   value="<fmt:formatDate value="${marathon.startDate}" pattern="yyyy-MM-dd"/>" style="width: 48%">
            ~
            <input type="date" name="endDate" value="<fmt:formatDate value="${marathon.endDate}" pattern="yyyy-MM-dd"/>"
                   style="width: 48%">
          </td>
        </tr>
        <tr>
          <th>장소</th>
          <td colspan="3"><input type="text" name="place" value="${marathon.place}" style="width: 100%"></td>
        </tr>
        <tr>
          <th>주최기관</th>
          <td><input type="text" name="host" value="${host}" style="width: 100%"></td>
          <th>주관기관</th>
          <td><input type="text" name="organizer" value="${organizer}" style="width: 100%"></td>
        </tr>
        <tr>
          <th>홈페이지</th>
          <td colspan="3"><input type="text" name="url" value="${marathon.url}" style="width: 100%"></td>
        </tr>
        <tr>
          <th>게시글</th>
          <td colspan="3">
            <textarea style="width: 100%" class="form-control" rows="10" id="description"
                      name="content">${marathon.content}</textarea>
            <%--              <%@include file="../write.jsp" %>--%>
          </td>
        </tr>
        <tr>
          <th>썸네일</th>
          <td colspan="3"><input type="text" name="thumbnail" value="${marathon.thumbnail}" style="width: 100%"></td>
        </tr>
        </tbody>
      </table>
      <div class="row p-3">
        <div class="col d-flex justify-content-between">
          <div class="col d-flex" style="text-align: start">
            <button type="button" class="btn btn-secondary m-1" onclick="abort(${marathon.no})">취소</button>
          </div>
          <div class="col d-flex justify-content-end">
            <button type="button" class="btn btn-outline-primary m-1">보관</button>
            <button type="submit" class="btn btn-primary m-1">수정</button>
          </div>
        </div>
      </div>
    </form>
  </div>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
<script>
    function abort(marathonNo) {
        let result = confirm("수정 중이던 글을 취소하시겠습니까?");
        if (result) {
            window.location.href = "detail?no=" + marathonNo;
        }
    }
    function deleteUploadFile(marathonNo, fileNo) {
        let result = confirm("기존에 등록된 첨부파일을 삭제하시겠습니까?");
        if (result) {
            window.location.href = `delete-file?no=\${marathonNo}&fileNo=\${fileNo}`;
        }
    }
</script>
</html>