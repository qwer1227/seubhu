<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/tags.jsp" %>
<script type="text/javascript" src="../resources/static/smartEditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<!doctype html>
<html lang="ko">
<head>
  <%@include file="/WEB-INF/common/common.jsp" %>
</head>
<style>
    #marathon-table th {
        text-align: center;
    }
    #marathon-table tr{
        height: 50px;
    }
</style>
<body>
<%@include file="/WEB-INF/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">
  
  <h2>마라톤 정보 작성</h2>
  
  <div class="row p-3">
    <form method="post" action="main">
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
            <td colspan="3"><input type="text" name="title" value="" style="width: 100%"></td>
          </tr>
          <tr>
            <th>일시</th>
            <td><input type="date" name="marathon-date" style="width: 50%"></td>
            <th>접수기간</th>
            <td>
              <input type="date" name="apply-start-date" style="width: 48%">
              ~
              <input type="date" name="apply-end-date" style="width: 48%">
            </td>
          </tr>
          <tr>
            <th>장소</th>
            <td colspan="3"><input type="text" name="place" value="" style="width: 100%"></td>
          </tr>
          <tr>
            <th>홈페이지</th>
            <td><input type="text" name="url" value="" style="width: 100%"></td>
            <th>참가비</th>
            <td><input type="text" name="title" value="">원</td>
          </tr>
          <tr>
            <th>게시글</th>
            <td colspan="3">
              <%@include file="../write.jsp" %>
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
    </form>
      
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
</div>
<%@include file="/WEB-INF/common/footer.jsp" %>
</body>
</html>