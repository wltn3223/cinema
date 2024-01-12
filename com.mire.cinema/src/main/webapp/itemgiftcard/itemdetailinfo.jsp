<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<title>MIRE MOVIE</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="/itemgiftcard/tab.js"></script>
<link rel="stylesheet" href="/itemgiftcard/tab.css">

<style>
.search {
	position: relative;
	width: 300px;
}

input {
	width: 80%;
	border: 1px solid black;
	border-radius: 8px;
	background-color: #1f1d1d;
	padding: 10px 10px;
	margin: 10px;
	font-size: 14px;
	color: white;
}

input::placeholder {
	color: #cccccc;
}

button {
	border: 1px solid black;
	border-radius: 8px;
	background-color: #1f1d1d;
	padding: 10px 10px;
	margin: 10px;
	color: white;
}

p {
	color: rgb(204, 204, 204);
}

.dropdown:hover .dropdown-menu {
	display: block;
	margin-top: 0;
}

.jb-900 {
	font-style: oblique;
}
</style>
</head>

<body>
	<!-- 헤더 -->
	<header>
		<%@ include file="../WEB-INF/header.jsp"%>
	</header>

	<!-- itemTab -->
	<div
		style="display: flex; justify-content: space-between; align-items: center;"
		class="container">
		<table>
			<tbody>

				<tr>
					<td colspan="2" style="font-weight: 500; font-size: 25px;">패밀리패키지</td>
				</tr>
				<tr>
					<td colspan="2">2d 일반관람권3매 + ㅇㅇ</td>
				</tr>

				<tr style="border-top: 1px solid black;">
					<td rowspan="8"><img src="/img/item02.PNG"
						style="width: 500px; height: 500px; border-right: 1px solid black; margin-right: 30px;"></td>
				</tr>

				<tr>
					<td id="hd">사용극장</td>
					<td>모든 지점</td>
				</tr>
				<tr>
					<td id="hd">유효기간</td>

					<td>구매일로부터 24개월 이내</td>
				</tr>
				<tr>
					<td id="hd">판매수량</td>

					<td>1회 8개 구매가능</td>
				</tr>
				<tr>
					<td id="hd">구매 후 취소&nbsp;&nbsp;&nbsp;&nbsp;</td>

					<td>구매일로부터 10일 이내 취소 가능</td>
				</tr>
				<tr>
					<td id="hd">수량/금액</td>

					<td><button id="decreaseBtn">-</button>
						<span id="quantity" style="color: black;">1</span> 개
						<button id="increaseBtn">+</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
						style="color: black; font-size: 30px; font-weight: 600;"
						id="totalPrice">43,000원</span></td>

				</tr>
				<tr>
					<td id="hd">원산지</td>
					<td>팝콘: 옥수수(미국산)</td>
				</tr>
				<tr>
					<td colspan="2">
						<button id="purchaseBtn">구매하기</button>
					</td>
				</tr>

			</tbody>
		</table>
	</div>
	<!-- itemTab -->

	<!-- 푸터-->
	<footer class="py-3 my-4" style="background-color: rgb(17, 17, 17);">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>

	<script>
		$(document).ready(function() {
			$.ajax({
				type : 'GET',
				url : '/item/list',
				contentType : 'application/json',
				success : function(itemGiftCards) {
					console.log(itemGiftCards);
					appendItemGiftCardToTable(itemGiftCards);
				},
				error : function(error) {
					var errorMessage = error.responseText;
					alert(errorMessage);
				}
			});
		});

		// 가격을 1000단위로 콤마(,)를 추가하는 함수
		function addCommaToPrice(price) {
			return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}

		function appendItemGiftCardToTable(itemGiftCards) {
			var div = $(".item-container");
			div.empty();

			for (var i = 0; i < itemGiftCards.length; i++) {
				var itemGiftCard = itemGiftCards[i];
				// 가격에 1000단위로 콤마 추가
				var formattedPrice = addCommaToPrice(itemGiftCard.itemPrice);
				var row = '<a href="#" onclick="loadItemInfo(\''
						+ itemGiftCard.itemName
						+ '\')">'
						+ '<div class="item">'
						+ '<img src="' + itemGiftCard.image + '" alt="' + itemGiftCard.itemName + ' 이미지" width="220" height="220">'
						+ '<p style="color: black; font-weight: bold;">'
						+ itemGiftCard.itemName
						+ '</p>'
						+ '<p style="color: black; font-size: 13px;">'
						+ itemGiftCard.itemInfo
						+ '</p>'
						+ '<p style="color: #9d00f7; font-size: 25px; font-weight: 400;">'
						+ formattedPrice + '원</p>' + '</div>' + '</a>';
				div.append(row);
			}
		}

		// 클릭 시 호출되는 함수로 선택한 아이템의 정보를 가져와서 sessionStorage에 저장
		function loadItemInfo(itemName) {
			$.ajax({
				type : 'GET',
				url : '/item/info/' + itemName,
				contentType : 'application/json',
				success : function(response) {
					console.log(response);
					// 선택한 아이템의 정보를 sessionStorage에 저장
					sessionStorage.setItem('selectedItem', JSON
							.stringify(response));
					// itemEditForm.jsp로 이동
					location.href = '/itemgiftcard/itemEditForm.jsp';
				},
				error : function(error) {
					var errorMessage = error.responseText;
					alert(errorMessage);
				}
			});
		}
	</script>

</body>

</html>
