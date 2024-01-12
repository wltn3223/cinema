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

<body style="background-color: white;" class="container">
	<!-- 헤더 -->
	<header>
		<%@ include file="../WEB-INF/header.jsp"%>
	</header>

	<!-- itemTab -->
	<div
		style="display: flex; justify-content: space-between; align-items: center;">
		<div class="tab">
			<p style="color: black; font-size: 30px;">스토어</p>
			<a href="/itemgiftcard/iteminsert.jsp">상품등록</a>
			<ul class="tabnav">
				<li><a href="#tab01">새로운상품</a></li>
				<li><a href="#tab02">팝콘/음료/굿즈</a></li>
				<li><a href="#tab03">포인트몰</a></li>
			</ul>
			<div class="tabcontent">
				<div id="tab01">
					<a href="#"><img src="/itemgiftcard/item01.PNG" width="100%"
						height="400px" style="margin-bottom: 120px; margin-left: 70px;"></a>
					<a href="#">
						<p style="font-weight: bold; color: black; text-align: right;">>더보기</p>
					</a>
					<div class="item-container">
						<c:forEach var="item" items="${itemGiftCards}">
							<a href="#" onclick="loadItemInfo('${item.itemName}')">
								<div class="item">
									<img src="${item.image}" alt="${item.itemName} 이미지" width="220"
										height="220">
									<p style="color: black; font-weight: bold;">${item.itemName}</p>
									<p style="color: black; font-size: 13px;">${item.itemInfo}</p>
									<p style="color: #9d00f7; font-size: 25px; font-weight: 400;">${item.itemPrice}원</p>
								</div>
							</a>
						</c:forEach>
					</div>
				</div>
				<div id="tab02">
					<div class="item-container">
						<c:forEach var="item" items="${itemGiftCards}">
							<a href="#" onclick="loadItemInfo('${item.itemName}')">
								<div class="item">
									<img src="${item.image}" alt="${item.itemName} 이미지" width="220"
										height="220">
									<p style="color: black; font-weight: bold;">${item.itemName}</p>
									<p style="color: black; font-size: 13px;">${item.itemInfo}</p>
									<p style="color: #9d00f7; font-size: 25px; font-weight: 400;">${item.itemPrice}원</p>
								</div>
							</a>
						</c:forEach>
					</div>
				</div>
				<div id="tab03">
					<br>
					<h2>등록된 상품이 없습니다.</h2>
					<br>
				</div>
			</div>
		</div>
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

		function appendItemGiftCardToTable(itemGiftCards) {
			var div = $(".item-container");
			div.empty();

			for (var i = 0; i < itemGiftCards.length; i++) {
				var itemGiftCard = itemGiftCards[i];
				var row = '<a href="#" onclick="loadItemInfo(\'' + itemGiftCard.itemName + '\')">'
						+ '<div class="item">'
						+ '<img src="' + itemGiftCard.image + '" alt="' + itemGiftCard.itemName + ' 이미지" width="220" height="220">'
						+ '<p style="color: black; font-weight: bold;">'
						+ itemGiftCard.itemName
						+ '</p>'
						+ '<p style="color: black; font-size: 13px;">'
						+ itemGiftCard.itemInfo
						+ '</p>'
						+ '<p style="color: #9d00f7; font-size: 25px; font-weight: 400;">'
						+ itemGiftCard.itemPrice + '원</p>' + '</div>' + '</a>';
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
