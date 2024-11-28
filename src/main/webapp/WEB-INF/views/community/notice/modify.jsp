<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<script type="text/javascript" src="../resources/static/smartEditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<!doctype html>
<html lang="ko">
<head>
  <%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<style>
    #notice-table th {
        text-align: center;
    }
    #notice-table tr{
        height: 50px;
    }
</style>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">
  
  <h2>공지사항 글 수정</h2>
  
  <div class="row p-3">
    <form method="post" action="modify" enctype="multipart/form-data">
      <input type="hidden" name="no" value="${notice.no}">
      <input type="hidden" name="fileNo" id="fileNo" value="${notice.uploadFile.no}">
    <table id="notice-table" style="width: 98%">
      <colgroup>
        <col width="20%">
        <col width="*">
      </colgroup>
      <tbody>
      <tr>
        <th>상위 노출 여부</th>
        <td>
          <div class="form-check form-switch">
            <input class="form-check-input" checked type="checkbox" role="switch"
                   id="first-check" onclick="changeFirst()">
            <input type="hidden" id="first" name="first" value="true">
            <label class="form-check-label"></label>
          </div>
        </td>
      </tr>
      <tr>
        <th>글제목</th>
        <td colspan="3"><input type="text" id="title" name="title" style="width: 100%" value="${notice.title}"></td>
      </tr>
      <tr>
        <th>글내용</th>
        <td colspan="3">
          <textarea style="width: 100%" class="form-control" rows="10" id="content" name="content"
                    placeholder="내용을 입력해주세요.">${notice.content}</textarea>
          <!--%@include file="../write.jsp"%-->
        </td>
      </tr>
      <tr>
        <th>첨부파일</th>
        <td colspan="3">
          <input type="file" class="form-control" name="upfile"/>
        </td>
      </tr>
      </tbody>
    </table>
  </div>
  
  <div class="row p-3">
    <div class="col d-flex justify-content-between">
      <div class="col d-flex" style="text-align: start">
        <button type="button" class="btn btn-secondary m-1">취소</button>
      </div>
      <div class="col d-flex justify-content-end">
        <button type="button" class="btn btn-outline-primary m-1">보관</button>
        <button type="submit" class="btn btn-primary m-1">등록</button>
      </div>
    </div>
  </div>
  </form>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
<script type="text/javascript">
    function changeFirst(){
        let checked = document.querySelector("#first");

        checked.value = document.querySelector("#first-check").checked ? "true" : "false";
    }
</script>
</html>