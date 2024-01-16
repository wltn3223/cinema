<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"
        href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <title>상품수정</title>
</head>

<body>
    <header>
        <%@ include file="../WEB-INF/header.jsp"%>
    </header>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <h1 class="text-center mb-4">상품 수정</h1>
                <form id="editForm" enctype="multipart/form-data"
                    action="/item/update" method="post">
                    <table class="container-fluid">
                        <tbody>
                            <tr style="border-top: 1px solid black;">
                                <td rowspan="8" id="itemImg" class="w-50"></td>
                            </tr>
                        </tbody>
                        <div class="form-group">
                            <label for="itemName">상품명</label> <input type="text"
                                class="form-control" id="itemName" name="itemName"
                                placeholder="상품명을 입력하세요" required>
                        </div>
                        <div class="form-group">
                            <label for="itemType">유효기간</label> <input type="text"
                                class="form-control" id="itemType" name="itemType"
                                placeholder="유효기간을 입력하세요" required>
                        </div>
                        <div class="form-group">
                            <label for="itemPrice">상품금액</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="itemPrice"
                                    name="itemPrice" placeholder="상품금액을 입력하세요" required>
                                <div class="input-group-append"></div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="itemSize">사이즈</label> <input type="text"
                                class="form-control" placeholder="상품구성을 입력하세요" id="itemSize"
                                name="itemSize" placeholder="사이즈를 입력하세요" required>
                        </div>
                        <div class="form-group">
                            <label for="itemInfo">상품정보</label>
                            <textarea class="form-control" id="itemInfo" name="itemInfo"
                                placeholder="원산지를 입력하세요" required style="height: 200px;"></textarea>
                        </div>

                        <div class="form-group">
                            <label for="itemImage" class="form-label">이미지</label> <input
                                type="file" class="form-control" id="file" name="file">
                        </div>
                        <div class="form-group">
                            <label for="cinemaName">상영관 정보</label> <select
                                class="form-control" id="cinemaName" name="cinemaName" required>
                                <option value="모든 상영관">모든 상영관</option>
                                <option value="강남">강남</option>
                                <option value="강남대로(씨티)">강남대로(씨티)</option>
                                <option value="강동">강동</option>
                                <option value="군자">군자</option>
                                <option value="동대문">동대문</option>
                            </select>
                        </div>

                        <div class="d-flex justify-content-center">
                            <div class="text-center">
                                <button class="btn btn-light bg-dark text-light" type="button"
                                    onclick="updateInfo()">수정하기</button>
                                <button class="btn btn-light bg-dark text-light" type="button"
                                    onclick="removeItem()">삭제하기</button>
                            </div>
                            <div class="text-center">
                                <a href="/itemgiftcard/itemlist.jsp">
                                    <button class="btn btn-light bg-dark text-light" type="button">목록으로</button>
                                </a>
                            </div>
                        </div>
                </form>
            </div>
        </div>
    </div>
    <footer class="text-dark">
        <%@ include file="../WEB-INF/footer.jsp"%>
    </footer>

    <script>
        $(document).ready(function() {
            getItem();
        });

        async function getItem() {
            try {
                let selectedItem = sessionStorage.getItem('selectedItem');
                if (!selectedItem) {
                    // selectedItem이 없을 경우에 대한 처리
                    console.warn('sessionStorage에서 선택한 상품 정보를 찾을 수 없습니다.');
                    return;
                }

                selectedItem = JSON.parse(selectedItem);
                console.log('selectedItem:', selectedItem);

                // 이미지 업데이트
                $('#itemImg').html('<img src="../upload/' + selectedItem.imageUuid + '" class="w-100" style="height: 700px; border-right: 1px solid black; margin-right: 30px;">');

                // 나머지 항목 업데이트
                $('#itemName').val(selectedItem.itemName);
                $('#itemType').val(selectedItem.itemType);
                $('#itemPrice').val(selectedItem.itemPrice);
                $('#itemSize').val(selectedItem.itemSize);
                $('#itemInfo').val(selectedItem.itemInfo);
                $('#cinemaName').val(selectedItem.cinemaName);

            } catch (error) {
                alert(error);
            }
        }
    </script>

    <script
        src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>
