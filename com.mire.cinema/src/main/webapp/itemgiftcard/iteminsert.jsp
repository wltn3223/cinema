<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <title>상품등록</title>
</head>
<body>
    <div class="mb-5 p-3">
        <a href="/" class="text-dark text-decoration-none">
            <h2 style="color: white;">MIRE MOVIE</h2>
        </a>
    </div>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <h2 class="text-center mb-4">상품등록</h2>
                <form enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="itemName">상품명</label> <input type="text" class="form-control" id="itemName" placeholder="상품명을 입력하세요" required>
                    </div>
                    <div class="form-group">
                        <label for="itemType">상품분류</label> <select class="form-control" id="itemType" required>
                            <option value="팝콘">팝콘</option>
                            <option value="음료">음료</option>
                            <option value="굿즈">굿즈</option>
                            <option value="세트">세트</option>
                            <option value="기타">기타</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="itemPrice">상품금액</label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="itemPrice" placeholder="상품금액을 입력하세요" required>
                            <div class="input-group-append"></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="itemSize">사이즈</label> <input type="text" class="form-control" id="itemSize" placeholder="사이즈를 입력하세요" required>
                    </div>
                    <div class="form-group">
                        <label for="itemInfo">상품정보</label>
                        <textarea class="form-control" id="itemInfo" placeholder="상품정보를 입력하세요" required style="height: 200px;"></textarea>
                    </div>
                     
                    <div class="form-group">
                        <label for="itemImage" class="form-label">이미지</label> <input type="file" class="form-control" id="itemImage">
                    </div>
                    <div class="form-group">
                        <label for="cinemaNo">상영관정보</label> <select class="form-control" id="cinemaNo" required>
                            <option value="1">강남</option>
                            <option value="2">강남대로(씨티)</option>
                            <option value="3">강동</option>
                            <option value="4">군자</option>
                            <option value="5">동대문</option>
                        </select>
                    </div>
                    <div class="text-center">
                        <button type="button" onclick="itemInsert()" class="btn btn-light">상품등록</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        function itemInsert() {
            var itemName = $('#itemName').val();
            var itemType = $('#itemType').val();
            var itemPrice = $('#itemPrice').val();
            var itemSize = $('#itemSize').val();
            var itemInfo = $('#itemInfo').val();
            var itemImage = $('#itemImage')[0].files[0];
            var cinemaNo = $('#cinemaNo').val();

            var formData = new FormData();
            formData.append('itemName', itemName);
            formData.append('itemType', itemType);
            formData.append('itemPrice', itemPrice);
            formData.append('itemSize', itemSize);
            formData.append('itemInfo', itemInfo);
            formData.append('itemImage', itemImage);
            formData.append('cinemaNo', cinemaNo);

            $.ajax({
                type: 'POST',
                url: '/item',
                processData: false,
                contentType: false,
                data: formData,
                success: function (response) {
                    alert(response);
                    location.href = "/itemgiftcard/itemlist.jsp";
                },
                error: function (error) {
                    var errorMessage = error.responseText;
                    alert(errorMessage);
                }
            });
        }
    </script>
</body>
</html>
