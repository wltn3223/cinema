<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<script src="https://js.tosspayments.com/v1/payment-widget"></script>
<title>MIRE MOVIE</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="/itemgiftcard/tab.js"></script>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<link rel="stylesheet" href="/itemgiftcard/tab.css">
<link rel="stylesheet" type="text/css" href="/css/common.css">
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
					<td colspan="2" style="font-weight: 500; font-size: 25px;"
						id="itemName"></td>
				</tr>
				<tr>
					<td colspan="2" id="itemSize"></td>
				</tr>

				<tr style="border-top: 1px solid black;">
					<td rowspan="8"><img src="" id="itemImage"
						style="width: 500px; height: 500px; border-right: 1px solid black; margin-right: 30px;">
					</td>
				</tr>

				<tr>
					<td id="hd">사용극장</td>
					<td id="cinemaName"></td>
				</tr>
				<tr>
					<td id="hd">유효기간</td>

					<td id="itemType">구매일로부터 24개월 이내</td>
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

					<td><button id="decreaseBtn">-</button> <span id="quantity"
						style="color: black;"></span> 개
						<button id="increaseBtn">+</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
						style="color: black; font-size: 30px; font-weight: 600;"
						id="itemPrice"></span></td>

				</tr>
				<tr>
					<td id="hd">원산지</td>
					<td id="itemInfo"></td>
				</tr>
				<tr>
					<td colspan="2">
					 <input type="hidden" id="itemNo" name="itemNo" value="${item.itemNo}">
						<button id="purchaseBtn" onclick="requestPay()">구매하기</button>
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
	  $(document).ready(function () {
	        // 페이지 로드 시 localStorage에서 선택한 상품 정보의 상품 번호를 가져옵니다.
	        var selectedItemNo = localStorage.getItem('selectedItemNo');

	        // 만약 상품 번호가 있다면, 선택한 상품의 정보를 표시합니다.
	        if (selectedItemNo) {
	            // 여기에 선택한 상품 정보를 표시하는 코드를 추가합니다.
	            console.log('선택한 상품 번호:', selectedItemNo);

	            // 예시: 상품 번호를 사용하여 서버에서 상세 정보를 가져와 화면에 표시할 수 있습니다.
	            $.ajax({
	                type: 'GET',
	                url: '/item/info/' + selectedItemNo,
	                contentType: 'application/json',
	                success: function (response) {
	                    // 서버에서 받아온 상세 정보를 이용하여 화면에 표시하는 코드
	                    console.log('서버에서 받아온 상세 정보:', response);

	                    // 예시: 받아온 정보를 화면의 특정 요소에 표시
	                    $('#itemNo').val(response.itemNo);
	                    $('#itemName').text(response.itemName);
	                    $('#itemType').text(response.itemType);
	                    $('#itemPrice').text(response.itemPrice);
	                    $('#itemSize').text(response.itemSize);
	                    $('#itemInfo').text(response.itemInfo);
	                    $('#cinemaName').text(response.cinemaName);

	                    // 이미지 정보 표시
	                    $('#itemImage').attr('src', '../upload/' + response.imageUuid);

	                    // 개당 가격 설정
	                    var unitPrice = response.itemPrice;
	                    // 초기 수량 설정
	                    var quantity = 1;
	                    // 최대 수량 설정
	                    var maxQuantity = 8;

	                    // 수량 및 금액 업데이트 함수
	                    function updateQuantityAndPrice() {
	                        $("#quantity").text(quantity);
	                        $("#itemPrice").text((quantity * unitPrice).toLocaleString() + "원");
	                    }

	                    // 감소 버튼에 대한 이벤트 리스너
	                    $("#decreaseBtn").on("click", function () {
	                        if (quantity > 1) {
	                            quantity -= 1;
	                            updateQuantityAndPrice();
	                        }
	                    });

	                    // 증가 버튼에 대한 이벤트 리스너
	                    $("#increaseBtn").on("click", function () {
	                        if (quantity < maxQuantity) {
	                            quantity += 1;
	                            updateQuantityAndPrice();
	                        }
	                    });

	                    // 초기 업데이트
	                    updateQuantityAndPrice();
	                },
	                error: function (error) {
	                    var errorMessage = error.responseText;
	                    console.error('서버에서 상세 정보를 가져오는 중 에러 발생:', errorMessage);
	                }
	            });
	        } else {
	            // 만약 상품 번호가 없다면, 경고 메시지를 출력합니다.
	            console.warn('localStorage에서 선택한 상품 정보를 찾을 수 없습니다.');
	        }
	    });
	
		function requestPay() {
			IMP.init('imp27664032');
			var msg;

			IMP.request_pay({
				pg : 'kakaopay',
				pay_method : 'card',
				merchant_uid : "order_" + new Date().getTime(), // 상점에서 관리하는 주문 번호
				name : '주문명:asdasdasd',
				amount : 100000,
				buyer_email : 'iamport@siot.do',
				buyer_name : '구매자이름',
				buyer_tel : '010-1234-5678',
				buyer_addr : '서울특별시 강남구 삼성동',
				buyer_postcode : '123-456',
				m_redirect_url : '/'
			}, function(rsp) {
				if (rsp.success) {
					//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
					jQuery.ajax({
						url : "/pay", //cross-domain error가 발생하지 않도록 주의해주세요
						type : 'POST',
						dataType : 'json',
						contentType : 'application/json', // Specify the content type here
						data : JSON.stringify({
						    imp_uid: rsp.imp_uid,            // 결제 고유번호
					         merchant_uid: rsp.merchant_uid 
						// Add any other necessary data
						}),
					}).done(function(rsp) {
						// [2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
						if (rsp.success) {
							msg = '결제가 완료되었습니다.';
							msg += '고유ID : ' + rsp.imp_uid;
							msg += '상점 거래ID : ' + rsp.merchant_uid;
							msg += '결제 금액 : ' + rsp.paid_amount;
							msg += '카드 승인번호 : ' + rsp.apply_num;
						} else {
							console.log(rsp);
							// [3] 아직 제대로 결제가 되지 않았습니다.
							// [4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
						}
					});
				} else {
					var msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg;

					alert(msg);
				}
				alert(msg);
			});
		}
	</script>

</body>

</html>
