<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="stylesheet" type="text/css" href="https://fengyuanchen.github.io/cropperjs/css/cropper.css">
  <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
  <script src="https://fengyuanchen.github.io/cropper/js/cropper.js"></script>
  
  
  <title>Cropper.js</title>
  <style>
      .img-container img {
          max-width: 100%;
      }

      .photo_box {
          margin: 0 auto;
          max-width: 800px;
      }

      .upload_btn {
          width: 100%;
          justify-content: center; /* 수평 중앙 정렬 */
          align-items: center; /* 수직 중앙 정렬 */
          display: flex; /* Flexbox 활성화 */
          flex-wrap: wrap; /* 여러 줄 배치를 허용 */
          margin-top: 20px;
      }

      .upload_btn #photoBtn {
          display: none;
      }

      .upload_btn .upload a, .upload_btn a {
          border-radius: 5px; /* 둥근 모서리 */
          justify-content: center; /* 수평 중앙 정렬 */
          align-items: center; /* 수직 중앙 정렬 */
          padding: 15px 0;
          display: block;
          text-align: center;
          text-decoration: none;
          width: 240px;
          margin-left: 5px;
          margin-right: 5px;
      }

      .upload_btn .upload a {
          background-color: steelblue;
          color: #fff
      }

      .upload_btn a {
          background: gray;
          color: #fff;
          height: 62px;
      }

      .photo_them {
          position: relative;
          margin-top: 20px;
          width: 100%;
          height: 350px;
          background: #eee;
      }

      .them_img {
          position: relative;
          top: 0;
          left: 0;
          width: 100%;
          height: 100%;
          overflow: hidden; /* 박스 밖으로 나가는 이미지 숨김 */
          display: flex; /* Flexbox 활성화 */
          justify-content: center; /* 수평 중앙 정렬 */
          align-items: center; /* 수직 중앙 정렬 */
      }

      .them_img img {
          display: block;
          max-width: 100%; /* 박스 너비에 맞게 조정 */
          max-height: 100%; /* 박스 높이에 맞게 조정 */
          margin: auto; /* 중앙 정렬 */
          position: relative;
          object-fit: contain; /* 이미지 비율을 유지하며 박스에 맞춤 */
      }

      #complete {
          display: block;
          margin-top: 20px;
          padding: 15px 0;
          width: 100%;
          text-align: center;
          color: #fff;
          text-decoration: none;
          background-color: steelblue;
          border-radius: 5px; /* 둥근 모서리 */
      }
  </style>
</head>
<body>

<div class="photo_box">
  <div class="upload_btn">
    <div class="upload">
      <a type="button">
        <input type="file" accept="image/jpeg, image/png" capture="camera" id="photoBtn" onchange="readURL(this);">
        <label for="photoBtn">사진 첨부하기</label>
      </a>
    </div>
    <div>
      <a href="javascript:void(0);" id="resetPhoto">다시 올리기</a>
    </div>
  </div>
  <div class="photo_them">
    <div class="them_img">
      <img id="preview" src="">
    </div>
  </div>
  <a href="javascript:void(0);" id="complete">업로드</a>
</div>
</body>

<script>
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('preview').src = e.target.result;
            };
            reader.readAsDataURL(input.files[0]);
        } else {
            document.getElementById('preview').src = "";
        }
    }

    //1. 기본 형식
    cropper.getCroppedCanvas();

    //2. Options사용 방식
    cropper.getCroppedCanvas({
        width: 160,
        height: 90,
        minWidth: 256,
        minHeight: 256,
        maxWidth: 4096,
        maxHeight: 4096,
        fillColor: '#fff',//투명도 설정 가능
        imageSmoothingEnabled: false,
        imageSmoothingQuality: 'high',
    });

    //3. 서버에 올릴 수 있도록 파일로 변환하는 방법
    cropper.getCroppedCanvas().toBlob((blob) => {
//HTMLCanvasElement를 return 받아서 blob파일로 변환해준다
        const formData = new FormData();

        formData.append('croppedImage', blob/*, 'example.png' , 0.7*/);
        //새로운 formData를 생성해서 앞에서 변경해준 blob파일을 삽입한다.(이름 지정 가능, 맨뒤 매개변수는 화질 설정)
        // jQuery.ajax이용해서 서버에 업로드
        $.ajax('/path/to/upload', {
            method: 'POST',
            data: formData,//앞에서 생성한 formData
            processData : false,    // data 파라미터 강제 string 변환 방지
            contentType : false,    // application/x-www-form-urlencoded; 방지
            success() {
                console.log('Upload success');
            },
            error() {
                console.log('Upload error');
            },
        });
    }/*, 'image/png' */);//서버에 저장 형식 사용 가능

    window.addEventListener('DOMContentLoaded', function () {
        var image = document.querySelector('#preview');
        var cropper = new Cropper(image, {
            dragMode: 'move',
            aspectRatio: 16 / 9,
            autoCropArea: 0.65,
            restore: false,
            guides: false,
            center: false,
            highlight: false,
            cropBoxMovable: false,
            cropBoxResizable: false,
            toggleDragModeOnDblclick: false,
        });
    });
</script>
</html>
