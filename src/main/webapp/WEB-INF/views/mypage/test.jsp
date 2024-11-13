<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이미지 업로드</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<c:out value="${post.thumbnail}"/>

<script>
    // 모달 열기 함수
    function openModal() {
        document.getElementById('uploadModal').style.display = 'block';
    }

    // 모달 닫기 함수
    function closeModal() {
        document.getElementById('uploadModal').style.display = 'none';
    }


        // 게시글 클릭 시 AJAX로 데이터 가져오기
        $('.feed').on('click', function() {
        var postId = $(this).data("post-id");
        $.ajax({
        url: "/mypage/detail/" + postId,
        method: "GET",
        success: function(response) {
        // 서버에서 받은 게시글 정보를 모달에 표시
        $("#detailPostContent").text(response.postContent);
        $("#detailCreatedDate").text(response.postCreatedDate);
        $("#detailPostWriter").text(response.user.username);

        // 모달을 표시
        $("#feedModal").show();
    },
        error: function() {
        alert("게시글 정보를 가져오는데 실패했습니다");
    }
    });
    });

        // 이미지 미리보기 기능 및 썸네일 설정
        $('#fileInput').on('change', function(event) {
        const files = event.target.files;
        const previewContainer = $('#imagePreviewContainer');
        previewContainer.empty();  // 미리보기 영역 초기화

        if (files.length <= 5) {
        for (const file of files) {
        const reader = new FileReader();
        reader.onload = function(e) {
        const img = $('<img>');
        img.attr('src', e.target.result);

        // base64 데이터를 기반으로 파일명 생성 (기존의 currentMillis를 대체)
        const base64Data = e.target.result;
        const newFileName = base64Data.split(',')[0].replace('data:image/', '').replace(';base64', '');  // base64 데이터에서 확장자 포함한 파일명 생성

        // Base64 데이터와 새 파일명을 함께 처리
        const slicedBase64Data = sliceBase64(base64Data);

        img.on('click', function() {
        $('#imagePreviewContainer img').removeClass('selected');  // 다른 이미지 선택 해제
        img.addClass('selected');  // 클릭한 이미지를 선택 상태로 변경
        $('#thumbnailImage').val(slicedBase64Data);  // 선택된 이미지를 썸네일로 설정
        $('#thumbnailImage').data('file-name', newFileName);  // 새로운 파일명을 숨은 필드에 저장
    });

        previewContainer.append(img);
    };
        reader.readAsDataURL(file);
    }
    } else {
        alert("최대 5개의 이미지만 업로드할 수 있습니다.");
    }
    });

        // base64 문자열 슬라이싱 함수
        function sliceBase64(base64Data) {
        const prefix = base64Data.slice(0, 22);  // data:image/jpeg;base64, 부분
        const slicedData = base64Data.slice(22);  // 실제 이미지 데이터 부분만 슬라이싱
        return prefix + slicedData;  // 슬라이싱된 base64 문자열 반환
    }


        function insertPost(){
        const formData = new FormData(document.getElementById('uploadForm'));

        $.ajax({
        url: '/mypage/public/insert',  // 백엔드 업로드 엔드포인트
        type: 'POST',
        data: formData,
        processData: false,       // 파일 전송 시 필수 설정
        contentType: false,       // 파일 전송 시 필수 설정
        success: function(response) {
        alert("업로드 성공: " + response);
        closeModal();
    },
        error: function(xhr, status, error) {
        alert("업로드 실패: " + xhr.responseText);
    }
    });
    }

        // 이미지 업로드 함수
        function uploadImage() {
        const form = document.getElementById('uploadForm');
        const formData = new FormData(form);
        const files = form.querySelector('#fileInput').files;

        // 각 파일에 대해 base64 데이터와 파일 이름 설정
        if (files.length > 0) {
        for (let i = 0; i < files.length; i++) {
        const file = files[i];
        const reader = new FileReader();

        reader.onload = function(e) {
        // base64 데이터 가져오기
        const base64Data = e.target.result;
        const fileName = base64Data.split(',')[0].replace('data:image/', '').replace(';base64', ''); // 파일 이름 설정 (확장자 포함)

        // base64 데이터를 'fileNames[]' 필드로 추가
        formData.append('fileNames[]', fileName);  // 파일 이름을 별도의 필드로 추가
        formData.set('files', file, fileName);  // 파일의 이름을 base64 데이터로 설정
    };

        reader.readAsDataURL(file); // 파일을 base64로 읽어들임
    }
    }

        // AJAX로 파일 데이터와 파일 이름 전송
        $.ajax({
        url: '/mypage/public/upload',  // 백엔드 업로드 엔드포인트
        type: 'POST',
        data: formData,
        processData: false,       // 파일 전송 시 필수 설정
        contentType: false,       // 파일 전송 시 필수 설정
        success: function(response) {
        alert("업로드 성공: " + response);
        closeModal();
    },
        error: function(xhr, status, error) {
        alert("업로드 실패: " + xhr.responseText);
    }
    });
    }

</script>
</body>
</html>
