<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/tags.jsp" %>
<!doctype html>
<html lang="ko">
<head>
    <%@include file="/WEB-INF/common/common.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/common/nav.jsp" %>
<div class="container-xxl text-center" id="wrap">

    <h2>상품 상세 페이지</h2>


    <div class="container" style="margin-top: 100px;">
        <div class="row mb-3">
            <%--상품의 사진을 화면에 표시한다.--%>
            <div class="col-6">
                <div class="mb-3">
                    <img src="https://ecimg.cafe24img.com/pg90b05313110010/brooksrunning/web/product/big/20240102/6531af333e9506981bed79075102fe43.png"/>
                </div>
                <div>
                    <img src="https://ecimg.cafe24img.com/pg90b05313110010/brooksrunning/web/product/big/20240102/6531af333e9506981bed79075102fe43.png" width="20%" />
                    <img src="https://ecimg.cafe24img.com/pg90b05313110010/brooksrunning/web/product/big/20240102/6531af333e9506981bed79075102fe43.png" width="20%" />
                    <img src="https://ecimg.cafe24img.com/pg90b05313110010/brooksrunning/web/product/big/20240102/6531af333e9506981bed79075102fe43.png" width="20%" />
                    <img src="https://ecimg.cafe24img.com/pg90b05313110010/brooksrunning/web/product/big/20240102/6531af333e9506981bed79075102fe43.png" width="20%" />
                    <img src="https://ecimg.cafe24img.com/pg90b05313110010/brooksrunning/web/product/big/20240102/6531af333e9506981bed79075102fe43.png" width="20%" />
                    <img src="https://ecimg.cafe24img.com/pg90b05313110010/brooksrunning/web/product/big/20240102/6531af333e9506981bed79075102fe43.png" width="20%" />
                    <img src="https://ecimg.cafe24img.com/pg90b05313110010/brooksrunning/web/product/big/20240102/6531af333e9506981bed79075102fe43.png" width="20%" />
                    <img src="https://ecimg.cafe24img.com/pg90b05313110010/brooksrunning/web/product/big/20240102/6531af333e9506981bed79075102fe43.png" width="20%" />
                </div>
            </div>
            <div class="col-6">
                <div class="row mb-3">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h4>상품 상세 정보</h4>
                            </div>
                            <div class="card-body">
                                <table class="table">
                                    <colgroup>
                                        <col width="15%" />
                                        <col width="35%" />
                                        <col width="15%" />
                                        <col width="35%" />
                                    </colgroup>
                                    <tr>
                                        <th>상품이름</th>
                                        <td>브룩스 신발</td>
                                        <th>상품가격</th>
                                        <th>189,000 원</th>
                                    </tr>
                                    <tr>
                                        <th>상품 설명</th>
                                        <td colspan="3">최상의 부드러움과 최고의 편안함으로 러너들의 사랑을 받고 있는 브룩스의 시그니처 러닝화 </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-12 text-end">
                        <div class="d-flex justify-content-between border p-3 bg-light">

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/common/footer.jsp" %>
</body>
</html>
