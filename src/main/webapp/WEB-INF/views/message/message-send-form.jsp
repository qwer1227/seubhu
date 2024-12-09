<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/common/tags.jsp" %>
<script type="text/javascript" src="../resources/static/smartEditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<!doctype html>
<html lang="ko">
<head>
    <%@ include file="/WEB-INF/views/common/common.jsp" %>
</head>
<style>
    #notice-table th {
        text-align: center;
    }

    #notice-table tr {
        height: 50px;
    }
</style>
<body>
<%@ include file="/WEB-INF/views/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">

    <h2>쪽지 작성</h2>

    <form action="/message/add" method="post" enctype="multipart/form-data" >
        <div class="row p-3">
            <table id="notice-table" style="width: 98%">
                <colgroup>
                    <col width="10%">
                    <col width="40%">
                    <col width="15%">
                    <col width="35%">
                </colgroup>
                <tbody>
                <!-- 보낸 사람 -->
                <tr class="form-group">
                    <th>
                        <label class="form-label" for="sender">보낸사람</label>
                    </th>
                    <td colspan="3">
                        <div class="text" id="sender">
                            ${sender}  <!-- 서버에서 보낸사람 값 삽입 -->
                        </div>
                    </td>
                </tr>

                <!-- 받는 사람 -->
                <tr class="form-group">
                    <th>
                        <label class="form-label" for="receivers" >받는사람</label>
                    </th>
                    <td colspan="3">
                        <input type="text" class="form-control" id="receivers" name="receivers"
                               placeholder="받는 사람을 콤마(,)로 구분하여 입력해 주세요." autocomplete="off">
                        <div id="receiver-suggestions" class="dropdown-menu" style="display: none; position: absolute; z-index: 1000;">
                            <!-- 검색된 닉네임이 여기 표시됩니다 -->
                        </div>
                    </td>
                </tr>

                <!-- 제목 -->
                <tr class="form-group">
                    <th>
                        <label class="form-label" for="title">제목</label>
                    </th>
                    <td colspan="3">
                        <input type="text" class="form-control" style="width: 100%" id="title" name="title"
                               placeholder="제목을 입력해 주세요." value="">
                    </td>
                </tr>

                <!-- 내용 -->
                <tr class="form-group">
                    <th>
                        <label class="form-label" for="content">내용</label>
                    </th>
                    <td colspan="3">
                        <textarea style="width: 100%" class="form-control" rows="10" id="content" name="content"
                                  placeholder="내용을 입력해 주세요."></textarea>
                    </td>
                </tr>

                <!-- 파일첨부 -->
                <tr class="form-group">
                    <th>
                        <label class="form-label" for="file">파일첨부</label>
                    </th>
                    <td colspan="3">
                        <input type="file" class="form-control" id="file" name="file"/>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <!-- 버튼 -->
        <div class="row p-3">
            <div class="col d-flex justify-content-between">
                <div class="col d-flex justify-content-end">
                    <button type="button" class="btn btn-outline-dark m-1">취소</button>
                    <button type="submit" class="btn btn-dark m-1">등록</button>
                </div>
            </div>
        </div>
    </form>

</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<script>
    document.getElementById("receivers").addEventListener("input", function () {
        const query = this.value.trim();
        if (query.length > 0) {
            fetch(`/user/search?nickname=${query}`)
                .then(response => response.json())
                .then(data => {
                    const suggestions = document.getElementById("receiver-suggestions");
                    suggestions.innerHTML = "";
                    data.forEach(user => {
                        const option = document.createElement("div");
                        option.classList.add("dropdown-item");
                        option.textContent = user.nickname;
                        option.addEventListener("click", () => {
                            const receiversInput = document.getElementById("receivers");
                            receiversInput.value += (receiversInput.value ? ", " : "") + user.nickname;
                            suggestions.style.display = "none";
                        });
                        suggestions.appendChild(option);
                    });
                    suggestions.style.display = "block";
                });
        } else {
            document.getElementById("receiver-suggestions").style.display = "none";
        }
    });

</script>
</body>
</html>
