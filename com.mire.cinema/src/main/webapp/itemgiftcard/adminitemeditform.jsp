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
					<table>
						<tbody>
							<tr style="border: 1px solid black;">
								<td rowspan="8" id="itemImg" class="w-50"></td>
							</tr>
						</tbody>
					</table>
					<input type="hidden" id="itemNo" name="itemNo"
						value="${item.itemNo}">
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
					

					<div class="d-flex justify-content-center">
						<div class="text-center">
							<button class="btn btn-light bg-dark text-light" type="button"
								onclick="updateInfo()">수정하기</button>
							<button class="btn btn-light bg-dark text-light" type="button"
								onclick="removeItem()">삭제하기</button>
						</div>
						<div class="text-center">
							<a href="/itemgiftcard/adminitemlist.jsp">
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
				let selectedItemNo = localStorage.getItem('selectedItemNo'); // 로컬 스토리지 사용
				if (!selectedItemNo) {
					// selectedItemNo가 없을 경우에 대한 처리
					console.warn('localStorage에서 선택한 상품 정보를 찾을 수 없습니다.');
					return;
				}

				// selectedItemNo를 사용하여 해당 아이템 정보 가져오기
				$
						.ajax({
							type : 'GET',
							url : '/item/info/' + selectedItemNo,
							contentType : 'application/json',
							success : function(selectedItem) {
								console.log(selectedItem);
								$('#itemNo').val(selectedItem.itemNo);
								// 이미지 업데이트
								$('#itemImg')
										.html(
												'<img src="../upload/' + selectedItem.imageUuid + '" class="w-100" style="height: 700px; border-right: 1px solid black; margin-right: 30px;">');

								$('#itemName').val(selectedItem.itemName);
								$('#itemType').val(selectedItem.itemType);
								$('#itemPrice').val(selectedItem.itemPrice);
								$('#itemSize').val(selectedItem.itemSize);
								$('#itemInfo').val(selectedItem.itemInfo);
							
							},
							error : function(error) {
								var errorMessage = error.responseText;
								alert(errorMessage);
							}
						});
			} catch (error) {
				alert(error);
			}
		}

		function updateInfo() {
			var itemNo = $("#itemNo").val();
			var itemName = $("#itemName").val();
			var itemType = $("#itemType").val();
			var itemPrice = $("#itemPrice").val();
			var itemSize = $("#itemSize").val();
			var itemInfo = $("#itemInfo").val();
			

			// FormData를 사용하여 파일을 추가
			var formData = new FormData(document.getElementById('editForm'));

			// 사용자에게 현재 입력된 값들을 보여줌
			var confirmationMessage = "상품명: " + itemName + "\n" + "상품분류: "
					+ itemType + "\n" + "상품금액: " + itemPrice + "\n" + "사이즈: "
					+ itemSize + "\n" + "판매 상영관: " + "\n"
					+ "상품정보: " + itemInfo + "\n\n" + "입력된 정보로 수정하시겠습니까?";

			var confirmUpdate = confirm(confirmationMessage);

			if (confirmUpdate) {
				// FormData를 사용하여 파일을 전송
				$.ajax({
					type : "POST",
					url : "/item/update",
					processData : false,
					contentType : false,
					data : formData,
					success : function(response) {
						console.log("수정 성공:", response);
						alert("상품이 수정되었습니다.");

						// 수정 후 로컬 스토리지에서 선택한 상품 정보 삭제
						localStorage.removeItem('selectedItemNo');

						location.href = "/itemgiftcard/adminitemlist.jsp";
					},
					error : function(error) {
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
			var itemNo = $("#itemNo").val();
			var confirmDelete = confirm("정말로 상품을 삭제하시겠습니까?");

			if (confirmDelete) {
				$.ajax({
					type : "DELETE",
					url : "/item/" + itemNo,
					success : function(response) {
						console.log("Delete successful:", response);
						alert("상품이 삭제되었습니다.");
						// 삭제 후 로컬 스토리지에서 선택한 상품 정보 삭제
						localStorage.removeItem('selectedItemNo');
						location.href = "/itemgiftcard/adminitemlist.jsp";
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
