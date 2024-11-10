<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
  <%@include file="/WEB-INF/views/common/common.jsp" %>
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
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">
  
  <h2> 마라톤 정보 상세페이지 </h2>
  
  <div class="row p-3 m-3">
    <table id="marathon-table" class="text-start">
      <colgroup>
        <col width="10%">
        <col width="40%">
        <col width="10%">
        <col width="40%">
      </colgroup>
      <tbody>
      <tr>
        <th colspan="4" style="text-align: start" class="fs-4">마라톤 이름</th>
      </tr>
      <tr>
        <th>일시</th>
        <td>2024.11.09</td>
        <th>접수기간</th>
        <td>2024.07.10 ~ 2024.10.18</td>
      </tr>
      <tr>
        <th>장소</th>
        <td colspan="3">전남 순천시 팔마로 333 (연향동, 순천팔마종합경기장) 순천팔마종합운동장 외 주로코스</td>
      </tr>
      <tr>
        <th>홈페이지</th>
        <td>http://sc-marathon.kr/</td>
        <th>참가비</th>
        <td>15,000원</td>
      </tr>
      <tr>
        <th colspan="4">
          <textarea disabled style="width: 100%">마라톤 디테일</textarea>
        </th>
      </tr>
      <tr>
        <th>다운로드</th>
        <td colspan="3">
          <input type="file" class="form-control" name="download"/>
        </td>
      </tr>
      </tbody>
    </table>
  </div>
  
  <div style="text-align: end">
    <button class="btn btn-outline-dark">
      <i class="bi bi-hand-thumbs-up"></i>
      <i class="bi bi-hand-thumbs-up-fill"></i>
    </button>
    <a type="button" href="main" class="btn btn-secondary">목록</a>
  </div>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>