<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common/tags.jsp" %>
<script type="text/javascript" src="../resources/static/smartEditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3af1f449b9175825b32af2e204b65779"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=LIBRARY"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services,clusterer,drawing"></script>
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
    .map_wrap {position:relative;width:100%;height:350px;}
    .title {font-weight:bold;display:block;}
    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
</style>
<body>
<%@include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">
  
  <h2>크루 모집글 작성</h2>
  
  <div class="row p-3">
    <form method="post" action="register" enctype="multipart/form-data">
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
            <select id="category" name="category" class="form-control" style="width: 450px">
              <option hidden="hidden">크루 조건을 선택해주세요.</option>
              <option value="정기모임">정기 모임</option>
              <option value="번개모임">번개 모임</option>
            </select>
          </td>
          <th rowspan="2">
            장소<br>
            <button type="button" class="btn btn-outline-dark" onclick="openPostcode()">검색</button>
          </th>
          <td rowspan="4">
            <div id="map" style="width: 450px; height: 250px" class="mb-2"></div>
          </td>
        </tr>
        <tr>
          <th>크루 이름</th>
          <td><input type="text" name="name" value="" style="width: 450px"></td>
        </tr>
        <tr>
          <th>일시</th>
          <td>
            <input type="hidden" id="schedule-combined" name="schedule">
            <select id="schedule-select" name="schedule-type">
              <option value="매월">매월</option>
              <option value="매주">매주</option>
              <option value="매일">매일</option>
            </select>
            <input type="text" id="schedule-detail" name="schedule-detail" value="" style="width: 390px" placeholder="상세 모임 일시를 작성해주세요.">
          </td>
        </tr>
        <tr>
          <th>대표 이미지</th>
          <td>
            <input type="file" class="form-control" name="image" style="width: 450px"/>
          </td>
        </tr>
        <tr>
          <th>게시글</th>
          <td colspan="3">
            <textarea style="width: 100%" class="form-control" rows="10" id="description" name="description"
                      placeholder="내용을 입력해주세요."></textarea>
<%--            <%@include file="../write.jsp" %>--%>
          </td>
        </tr>
        <tr>
          <th>첨부파일</th>
          <td colspan="3">
            <input type="file" class="form-control" name="upfile"/>
        </tr>
        </tbody>
      </table>

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
    </form>
  </div>
</div>
<%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
<script type="text/javascript">
    function abort() {
        let result = confirm("작성중이던 글을 임시보관하시겠습니까?");
        if (result){
          window.location.href = "main";
        }
    }
    
    // 요소 가져오기
    const selectElement = document.getElementById('schedule-type');
    const inputElement = document.getElementById('schedule-detail');
    const hiddenField = document.getElementById('schedule-combined');
    
    // 값 결합 함수
    function combineSchedule() {
      const selectedValue = selectElement.value; // 선택된 값
      const inputValue = inputElement.value.trim(); // 입력된 텍스트 (공백 제거)
      
      // 최종 문자열 조합
      hiddenField.value = `${selectedValue} ${inputValue}`;
      document.getElementById('schedule-combined').value = hiddenField.value;
    }
    
    // 이벤트 리스너 등록
    selectElement.addEventListener('change', combineSchedule);
    inputElement.addEventListener('input', combineSchedule);
    
    // 카카오 주소 api
    function openPostcode() {
      new daum.Postcode({
        oncomplete: function(data) {
          // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
          
          // 각 주소의 노출 규칙에 따라 주소를 조합한다.
          // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
          var addr = ''; // 주소 변수
          var extraAddr = ''; // 참고항목 변수
          
          //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
          if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
            addr = data.roadAddress;
          } else { // 사용자가 지번 주소를 선택했을 경우(J)
            addr = data.jibunAddress;
          }
          
          // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
          if(data.userSelectedType === 'R'){
            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
              extraAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
              extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraAddr !== ''){
              extraAddr = ' (' + extraAddr + ')';
            }
            // 조합된 참고항목을 해당 필드에 넣는다.
            document.getElementById("address-extra").value = extraAddr;
            
          } else {
            document.getElementById("address-extra").value = '';
          }
          
          // 우편번호와 주소 정보를 해당 필드에 넣는다.
          document.getElementById('postcode').value = data.zonecode;
          document.getElementById("address").value = addr;
          // 커서를 상세주소 필드로 이동한다.
          document.getElementById("address-detail").focus();
        }
      }).open();
    }
    
    var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
    var options = { //지도를 생성할 때 필요한 기본 옵션
      center: new kakao.maps.LatLng(37.572990, 126.992240), //지도의 중심좌표.
      level: 3 //지도의 레벨(확대, 축소 정도)
    };
    
    var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
    
    // 마커가 표시될 위치입니다
    var markerPosition  = new kakao.maps.LatLng(37.572990, 126.992240);
    
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
      position: markerPosition
    });
    
    // 지도를 클릭한 위치에 표출할 마커입니다
    var marker = new kakao.maps.Marker({
      // 지도 중심좌표에 마커를 생성합니다
      position: map.getCenter()
    });
    // 지도에 마커를 표시합니다
    marker.setMap(map);
    
    // 지도에 클릭 이벤트를 등록합니다
    // 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
    kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
      
      // 클릭한 위도, 경도 정보를 가져옵니다
      var latlng = mouseEvent.latLng;
      
      // 마커 위치를 클릭한 위치로 옮깁니다
      marker.setPosition(latlng);
      
      var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
      message += '경도는 ' + latlng.getLng() + ' 입니다';
      
      var resultDiv = document.getElementById('clickLatlng');
      resultDiv.innerHTML = message;
      
    });
</script>
</html>