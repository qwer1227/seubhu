<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이미지 업로드</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<!-- 이미지 업로드 모달 -->
<div id="uploadModal" style="display: none;">
    <form id="uploadForm">
        <label for="fileInput">이미지 파일:</label>
        <input type="file" id="fileInput" name="files" accept="image/*" multiple required>
        <input type="hidden" id="postNoInput" name="postNo" value="123"> <!-- 임의의 POST_NO 값 -->
        <button type="button" onclick="uploadImage()">업로드</button>
    </form>
    <button onclick="closeModal()">닫기</button>
</div>

<button onclick="openModal()">이미지 업로드</button>

<script>
    // 모달 열기 함수
    function openModal() {
        document.getElementById('uploadModal').style.display = 'block';
    }

    // 모달 닫기 함수
    function closeModal() {
        document.getElementById('uploadModal').style.display = 'none';
    }

    // 이미지 업로드 함수
    function uploadImage() {
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
</script>
</body>
</html>
