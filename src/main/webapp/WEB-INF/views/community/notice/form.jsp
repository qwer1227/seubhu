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
  
  <h2>공지사항 글 작성</h2>
  
  <div class="row p-3">
    <table id="notice-table" style="width: 98%">
      <colgroup>
        <col width="10%">
        <col width="40%">
        <col width="15%">
        <col width="35%">
      </colgroup>
      <tbody>
      <tr>
        <th>카테고리</th>
        <td style="text-align: start">
          <select>
            <option hidden="hidden">카테고리를 선택해 주세요.</option>
            <option>공지사항</option>
            <option>자주 묻는 질문</option>
          </select>
        </td>
        <th>상위 노출 여부</th>
        <td>
          <div class="form-check form-switch">
            <input class="form-check-input" checked type="checkbox" role="switch" id="flexSwitchCheckChecked">
            <label class="form-check-label" for="flexSwitchCheckChecked"></label>
          </div>
        </td>
      </tr>
      <tr>
        <th>글제목</th>
        <td colspan="3"><input type="text" value="" style="width: 100%"></td>
      </tr>
      <tr>
        <th>글내용</th>
        <td colspan="3">
          <textarea style="width: 100%" class="form-control" rows="10" id="content" name="content"
                    placeholder="내용을 입력해주세요."></textarea>
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

</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>