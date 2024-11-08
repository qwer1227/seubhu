<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
  <%@include file="/WEB-INF/common/common.jsp" %>
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
<%@include file="/WEB-INF/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">
  
  <h2> 커뮤니티 글 작성 </h2>
  
  <div class="row p-3 m-3">
    <form action="" method="post">
      <table id="community-table" style="width: 98%">
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
              <option hidden="hidden">게시판을 선택해주세요.</option>
              <option>일반</option>
              <option>자랑</option>
              <option>질문</option>
              <option>훈련일지</option>
            </select>
          </td>
          <th>임시저장시간</th>
          <td>2024년 11월 07일 오후 2시 46분</td>
        </tr>
        <tr>
          <th>글제목</th>
          <td colspan="3"><input type="text" value="" style="width: 100%"></td>
        </tr>
        <tr>
          <th>글내용</th>
          <td colspan="3">
            <%@include file="write.jsp" %>
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
  </div>
  
  <div class="row">
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
<%@include file="/WEB-INF/common/footer.jsp" %>
</body>
</html>