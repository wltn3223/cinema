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
                <form enctype="application/x-www-form-urlencoded">
                    <div class="form-group">
                        <label for="itemName">상품명</label> <input type="text" class="form-control" id="itemName" placeholder="상품명을 입력하세요" required>
                    </div>
                   <div class="form-group">
                        <label for="itemType">유효기간</label> <input type="text" class="form-control" id="itemType" placeholder="유효기간을 입력하세요" required>
                    </div>
                    <div class="form-group">
                        <label for="itemPrice">상품금액</label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="itemPrice" placeholder="상품금액을 입력하세요" required>
                            <div class="input-group-append"></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="itemSize">사이즈</label> <input type="text" class="form-control" placeholder="상품구성을 입력하세요" id="itemSize" placeholder="사이즈를 입력하세요" required>
                    </div>
                    <div class="form-group">
                        <label for="itemInfo">상품정보</label>
                        <textarea class="form-control" id="itemInfo" placeholder="원산지를 입력하세요" required style="height: 200px;"></textarea>
                    </div>
                     
                    <div class="form-group">
                        <label for="itemImage" class="form-label">이미지</label> <input type="file" class="form-control" id="itemImage">
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
    
        var fileInput = document.getElementById('itemImage');

        var formData = new FormData(); // formData 초기화 위치 수정

        if (fileInput.files.length > 0) {
            formData.append('file', fileInput.files[0]);
        }

        formData.append('itemName', itemName);
        formData.append('itemType', itemType);
        formData.append('itemPrice', itemPrice);
        formData.append('itemSize', itemSize);
        formData.append('itemInfo', itemInfo);
        formData.append('itemImage', itemImage);
     

        $.ajax({
            type: 'POST',
            url: '/item',
            processData: false,
            contentType: false,
            data: formData,
            success: function (response) {
                alert(response);
                location.href = "/itemgiftcard/adminitemlist.jsp";
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
