<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap 5 Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://fengyuanchen.github.io/cropperjs/css/cropper.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://fengyuanchen.github.io/cropperjs/js/cropper.js"></script>
  <style type="text/css">
    .box {
      margin: 20px auto;
      max-width: 640px;
      max-height: 430px;
    }
    .box img {
      max-width: 100%;
    }
  </style>
</head>
<body>

<div class="container">
  <div class="row">
    <div class="col-12">
      <div class="box border border-1">
        <img src=""
             id="image">
      </div>
      <div class="text-center">
        <button id="btn-cropper" class="btn btn-primary">crop</button>
      </div>
    </div>
  </div>
</div>
<script>
  let image = document.querySelector("#image")
  var cropper = new Cropper(image, {
    dragMode: 'move',
    aspectRatio: 16 / 11,
    autoCropArea: 0.5,
    restore: false,
    guides: false,
    center: false,
    highlight: false,
    cropBoxMovable: true,
    cropBoxResizable: false,
    toggleDragModeOnDblclick: false,
  });
  
  $("#btn-cropper").click(function() {
    if (cropper) {
      let boxData = cropper.getCropBoxData();
      console.log(boxData);
      
      cropper.getCroppedCanvas({
        width:334.30,
        height: 188.66
      }).toBlob(function(blob) {
        let formData = new FormData();
        formData.append('img', blob, 'photo.png');
        $.ajax({
          method:"post",
          url:"crew-thumbnail",
          data: formData,
          processData: false,
          contentType: false,
        })
      })
    }
  });
  
</script>
</body>
</html>
