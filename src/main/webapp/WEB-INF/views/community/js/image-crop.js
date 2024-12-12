const myModalThumbnail = new bootstrap.Modal('#modal-thumbnail')

let image = document.querySelector("#image")

let cropper = null;
let formData = new FormData();

// 이미지 슬라이싱 기본 설정
function initCropper() {
    cropper = new Cropper(image, {
        dragMode: 'move',
        aspectRatio: 16 / 11,
        autoCropArea: 0.6,
        restore: false,
        guides: false,
        center: false,
        highlight: false,
        cropBoxMovable: true,
        cropBoxResizable: true,
        toggleDragModeOnDblclick: false,
    });
}

// 모달의 설정 버튼 클릭 시, 임시로 썸네일 이미지 저장
$("#btn-cropper").click(function () {
    if (cropper) {
        let boxData = cropper.getCropBoxData();
        console.log(boxData);

        cropper.getCroppedCanvas({
            width: 334.30,
            height: 188.66
        }).toBlob(function (blob) {
            formData.append('image', blob, 'thumbnail.png');
        })
    }
});

// 등록 버튼 클릭 시, 폼에 있는 값을 전달(이미지는 슬라이싱할 때 전달했기 때문에 따로 추가 설정 안해도 됨)
document.querySelector("#submit").addEventListener("click", function (){
    let title = document.querySelector("input[name=title]").value;
    let description = document.querySelector("textarea[name=description]").value;
    let name = document.querySelector("input[name=name]").value;
    let type = document.querySelector("select[name=type]").value;
    let detail = document.querySelector("input[name=detail]").value;
    let location = document.querySelector("input[name=location]").value;
    let upfile = document.querySelector("input[name=upfile]")

    formData.append("title", title);
    formData.append("description", description);
    formData.append("name", name);
    formData.append("type", type);
    formData.append("detail", detail);
    formData.append("location", location);
    if (upfile.files.length > 0) {
        formData.append("upfile", upfile.files[0]);
    }

    $.ajax({
        method: "post",
        url: "register",
        data: formData,
        processData: false,
        contentType: false,
        success: function (crew){
            window.location.href = "detail?no=" + crew.no;
        }
    })
});

// 첨부한 이미지 미리보기 기능을 제공
function readURL(input) {
    if (cropper) {
        cropper.destroy()
    }

    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function(e) {
            document.getElementById('image').src = e.target.result;
            initCropper();
        };
        reader.readAsDataURL(input.files[0]);
    } else {
        document.getElementById('image').src = "";
    }
}