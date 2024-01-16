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
				<form enctype="multipart/form-data">
					<div class="form-group">
						<label for="itemName">상품명</label> <input type="text"
							class="form-control" id="itemName" placeholder="상품명을 입력하세요"
							required>
					</div>
					<div class="form-group">
						<label for="itemType">유효기간</label> <input type="text"
							class="form-control" id="itemType" placeholder="유효기간을 입력하세요"
							required>
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
							class="form-control" placeholder="상품구성을 입력하세요" id="itemSize"
							placeholder="사이즈를 입력하세요" required>
					</div>
					<div class="form-group">
						<label for="itemInfo">상품정보</label>
						<textarea class="form-control" id="itemInfo"
							placeholder="원산지를 입력하세요" required style="height: 200px;"></textarea>
					</div>


					<div class="form-group">
						<label for="itemImage" class="form-label">이미지</label> <input
							type="file" class="form-control" id="itemImage" name="file">
					</div>
					<div class="form-group">
						<label for="cinemaName">상영관 정보</label> <select
							class="form-control" id="cinemaName" required>
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


	<script type="text/javascript">
		$(document).ready(function() {
			// 페이지 로드 시 sessionStorage에서 선택한 상품 정보를 가져와서 폼에 표시
			var selectedItem = sessionStorage.getItem('selectedItem');
			if (selectedItem) {
				selectedItem = JSON.parse(selectedItem);
				$('#itemName').val(selectedItem.itemName);
				$('#itemType').val(selectedItem.itemType);
				$('#itemPrice').val(selectedItem.itemPrice);
				$('#itemSize').val(selectedItem.itemSize);
				$('#itemInfo').val(selectedItem.itemInfo);
				$('#cinemaName').val(selectedItem.cinemaName);
				$('#itemImage').val(selectedItem.itemImage);
			} else {
				console.error('sessionStorage에 선택된 항목 정보가 없습니다.');
			}
		});

		function updateInfo() {
		    var itemName = $("#itemName").val();
		    var itemType = $("#itemType").val();
		    var itemPrice = $("#itemPrice").val();
		    var itemSize = $("#itemSize").val();
		    var itemInfo = $("#itemInfo").val();
		    var cinemaName = $("#cinemaName").val();

		    // FormData를 사용하여 파일을 추가
		    var formData = new FormData();
		    formData.append('file', $('#itemImage')[0].files[0]);
		    formData.append('itemName', itemName);
		    formData.append('itemType', itemType);
		    formData.append('itemPrice', itemPrice);
		    formData.append('itemSize', itemSize);
		    formData.append('itemInfo', itemInfo);
		    formData.append('cinemaName', cinemaName);

		    // 사용자에게 현재 입력된 값들을 보여줌
		    var confirmationMessage = "상품명: " + itemName + "\n" + "상품분류: "
		        + itemType + "\n" + "상품금액: " + itemPrice + "\n" + "사이즈: "
		        + itemSize + "\n" + "판매 상영관: " + cinemaName + "\n" + "상품정보: " + itemInfo + "\n\n"
		        + "입력된 정보로 수정하시겠습니까?";

		    var confirmUpdate = confirm(confirmationMessage);

		    if (confirmUpdate) {
		        // FormData를 사용하여 파일을 전송
		        $.ajax({
		            type: "PUT",
		            url: "/item",
		            processData: false,
		            contentType: false,
		            data: formData,
		            success: function (response) {
		                console.log("수정 성공:", response);
		                alert("상품이 수정되었습니다.");

		                // 수정 후 세션 스토리지에서 선택한 상품 정보 삭제
		                sessionStorage.removeItem('selectedItem');

		                location.href = "/itemgiftcard/itemlist.jsp";
		            },
		            error: function (error) {
		                var errorMessage = error.responseText;
		                alert(errorMessage);
		            }
		        });
		    } else {
		        // 사용자가 수정을 취소한 경우
		        alert("상품 수정이 취소되었습니다.");
		    }
		}

		function removeItem() {
			var itemName = $("#itemName").val();
			var confirmDelete = confirm("정말로 상품을 삭제하시겠습니까?");

			if (confirmDelete) {
				$.ajax({
					type : "DELETE",
					url : "/item/" + itemName,
					success : function(response) {
						console.log("Delete successful:", response);
						alert("상품이 삭제되었습니다.");
						// 삭제 후 세션 스토리지에서 선택한 상품 정보 삭제
						sessionStorage.removeItem('selectedItem');
						location.href = "/itemgiftcard/itemlist.jsp";
					},
					error : function(error) {
						var errorMessage = error.responseText;
						alert(errorMessage);
					}
				});
			} else {
				// 사용자가 삭제를 취소한 경우
				alert("상품 삭제가 취소되었습니다.");
			}
		}
	</script>

	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>
