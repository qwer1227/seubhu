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

    #marathon-table tr {
        height: 50px;
    }
</style>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">
  
  <h2>마라톤 정보 작성</h2>
  
  <div class="row p-3">
    <form method="post" action="register" enctype="multipart/form-data">
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
          <td colspan="3"><input type="text" name="title" value="test" style="width: 100%"></td>
        </tr>
        <tr>
          <th>일시</th>
          <td style="text-align: start"><input type="date" name="marathonDate" style="width: 40%"></td>
          <th>접수기간</th>
          <td style="text-align: start">
            <input type="date" name="startDate" style="width: 40%">
            ~
            <input type="date" name="endDate" style="width: 40%">
          </td>
        </tr>
        <tr>
          <th>장소</th>
          <td colspan="3"><input type="text" name="place" value="" style="width: 100%"></td>
        </tr>
        <tr>
          <th>주최기관</th>
          <td><input type="text" name="host" value="" style="width: 100%"></td>
          <th>주관기관</th>
          <td><input type="text" name="organizer" value="" style="width: 100%"></td>
        </tr>
        <tr>
          <th>홈페이지</th>
          <td colspan="3"><input type="text" name="url" value="" style="width: 100%"></td>
        </tr>
        <tr>
          <th>게시글</th>
          <td colspan="3">
            <%@include file="../write.jsp" %>
          </td>
        </tr>
        <tr>
          <th>썸네일</th>
          <td colspan="3"><input type="text" name="thumbnail" value="" style="width: 100%"></td>
        </tr>
        </tbody>
      </table>
      <div class="row p-3">
        <div class="col d-flex justify-content-between">
          <div class="col d-flex" style="text-align: start">
            <button type="button" class="btn btn-secondary m-1" onclick="abort()">취소</button>
          </div>
          <div class="col d-flex justify-content-end">
            <button type="button" id="submit" class="btn btn-primary m-1">등록</button>
          </div>
        </div>
      </div>
    </form>
  </div>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
<script type="text/javascript">
    let formData = new FormData();

    // 등록 버튼 클릭 시, 폼에 있는 값을 전달(이미지는 슬라이싱할 때 전달했기 때문에 따로 추가 설정 안해도 됨)
    document.querySelector("#submit").addEventListener("click", function (){

        oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);

        let title = document.querySelector("input[name=title]").value;
        let content = document.querySelector("textarea[name=ir1]").value;
        let marathonDate = document.querySelector("input[name=marathonDate]").value;
        let startDate = document.querySelector("input[name=startDate]").value;
        let endDate = document.querySelector("input[name=endDate]").value;
        let host = document.querySelector("input[name=host]").value;
        let organizer = document.querySelector("input[name=organizer]").value;
        let url = document.querySelector("input[name=url]").value;
        let place = document.querySelector("input[name=place]").value;
        let thumbnail = document.querySelector("input[name=thumbnail]").value;

        formData.append("title", title);
        formData.append("content", content);
        formData.append("marathonDate", marathonDate);
        formData.append("startDate", startDate);
        formData.append("endDate", endDate);
        formData.append("host", host);
        formData.append("organizer", organizer);
        formData.append("url", url);
        formData.append("place", place);
        formData.append("thumbnail", thumbnail);

        $.ajax({
            method: "post",
            url: "/community/marathon/register",
            data: formData,
            processData: false,
            contentType: false,
            success: function (board){
                window.location.href = "detail?no=" + board.no;
            }
        })
    });

    function abort() {
        alert("글 작성을 취소하시겠습니까? 작성중이던 글은 저장되지 않습니다.");

        location.href = "main";
    }

</script>
</html>