<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<script type="text/javascript" src="../resources/static/smartEditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<!doctype html>
<html lang="ko">
<head>
  <%@include file="/WEB-INF/views/common/common.jsp" %>
</head>
<style>
    #inviting-table th {
        text-align: center;
    }
    #inviting-table tr{
        height: 50px;
    }
</style>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">
  
  <h2>크루 모집글 작성</h2>
  
  <div class="row p-3">
    <form method="post" action="main">
      <table id="inviting-table" style="width: 98%">
        <colgroup>
          <col width="10%">
          <col width="40%">
          <col width="10%">
          <col width="40%">
        </colgroup>
        <tbody>
        <tr>
          <th>모집글 제목</th>
          <td colspan="3"><input type="text" name="title" value="" style="width: 100%"></td>
        </tr>
        <tr>
          <th>크루 종류</th>
          <td>
            <select>
              <option hidden="hidden">크루 조건을 선택해주세요.</option>
              <option>정기 모임</option>
              <option>번개 모임</option>
            </select>
          </td>
        </tr>
        <tr>
          <th>크루 이름</th>
          <td colspan="3"><input type="text" name="title" value="" style="width: 100%"></td>
        </tr>
        <tr>
          <th>일시</th>
<%--          <td><input type="date" name="marathon-date" style="width: 50%"></td>--%>
          <td>
            <select>
              <option>매월</option>
              <option>매주</option>
              <option>매일</option>
            </select>
            <input type="text" value="" placeholder="상세 모임 일시를 작성해주세요.">
          </td>
          <!-- 지도api 사용 -->
          <th>장소</th>
          <td>
            <input type="text" name="place" value="">
            <button class="btn btn-outline-dark btn-sm" type="button">장소 찾기</button>
          </td>
        </tr>
        <tr>
          <th>대표 이미지</th>
          <td colspan="3">
            <input type="file" class="form-control" name="upfile"/>
          </td>
        </tr>
        <tr>
          <th>게시글</th>
          <td colspan="3">
            <textarea style="width: 100%" class="form-control" rows="10" id="content" name="content"
                      placeholder="내용을 입력해주세요."></textarea>
<%--            <%@include file="../write.jsp" %>--%>
          </td>
        </tr>
        <tr>
          <th>첨부파일</th>
          <td colspan="3">
            <input type="file" class="form-control" name="image"/>
        </tr>
        </td>
        </tbody>
      </table>
    </form>
    
    <div class="row p-3">
      <div class="col d-flex justify-content-between">
        <div class="col d-flex" style="text-align: start">
          <button type="button" class="btn btn-secondary m-1" onclick="abort()">취소</button>
        </div>
        <div class="col d-flex justify-content-end">
          <button type="button" class="btn btn-outline-primary m-1">보관</button>
          <button type="submit" class="btn btn-primary m-1">등록</button>
        </div>
      </div>
    </div>
  </div>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
<script type="text/javascript">
    function abort() {
        alert("작성중이던 글을 임시보관하시겠습니까?");

        location.href = "main";
    }
</script>
</html>