<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>상품등록</title>
</head>

<body >
	<div class="mb-5 p-3">
		<a href="/" class="text-dark text-decoration-none">
			<h2 style="color: white;">MIRE MOVIE</h2>
		</a>
	</div>

	<div class="container mt-5">
		<div class="row justify-content-center">
			<div class="col-md-6">
				<h2 class="text-center mb-4">상품등록</h2>
				<form>
					<div class="form-group">
						<label for="itemName">상품명</label> <input type="text"
							class="form-control" id="itemName" placeholder="상품명을 입력하세요"
							required>
					</div>
					<div class="form-group">
						<label for="itemType">상품분류</label> <select class="form-control"
							id="itemType" required>
							<option value="식품">식품</option>
							<option value="음료">음료</option>
							<option value="셋트">셋트</option>
							<option value="기타">기타</option>
						</select>
					</div>
					<div class="form-group">
						<label for="itemPrice">상품금액</label>
						<div class="input-group">
							<input type="text" class="form-control" id="itemPrice"
								placeholder="상품금액을 입력하세요" required>
							<div class="input-group-append"></div>
						</div>
					</div>

					<div class="form-group">
						<label for="itemSize">사이즈</label> <input type="text"
							class="form-control" id="itemSize" placeholder="사이즈를 입력하세요"
							required>
					</div>
					<div class="form-group">
						<label for="itemInfo">상품정보</label>
						<textarea class="form-control" id="itemInfo"
							placeholder="상품정보를 입력하세요" required style="height: 200px;"></textarea>
					</div>

					<div class="text-center">
						<button type="button" onclick="iteminsert()" class="btn btn-light">상품등록</button>

					</div>

				</form>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
<style>

.container {
		
	border-radius: 8px;
	/* 컨테이너의 모서리를 둥글게 만듭니다. */
	font-size: 25px;
	padding: 20px;
	/* 컨테이너의 내부 여백을 설정합니다. */
}
</style>
<script>

function iteminsert() {
    var itemName = $('#itemName').val();
    var itemType = $('#itemType').val();
    var itemPrice = $('#itemPrice').val();
    var itemSize = $('#itemSize').val();
    var itemInfo = $('#itemInfo').val();

    var itemData = {
        itemName: itemName,
        itemType: itemType,
        itemPrice: itemPrice,
        itemSize: itemSize,
        itemInfo: itemInfo
    };

    $.ajax({
        type: 'POST',
        url: '/item',
        contentType: 'application/json',
        data: JSON.stringify(itemData),
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

</html>