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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
.dropdown:hover .dropdown-menu {
	display: block;
	margin-top: 0;
}

.nav-link {
	color: white;
}
</style>
</head>
<body>
	<!-- 헤더 -->
	<header>
		<%@ include file="../WEB-INF/header.jsp"%>
	</header>
	<!-- 메인 -->
	<main class="container mt-3">
		<div class="container">
			<h2>좌석선택</h2>
			<div class="d-flex justify-content-between mb-2">
			<div class="d-flex">
				<h5>내가 선택한 좌석:</h5><h5 id=choice></h5>
				</div>
				<div class="btn btn-dark" onclick="reserve()">예매하기</div>
			</div>
			<div class="container border border-dark" style="height: 500px">
				<div class = "text-center d-flex justify-content-center">
						<div class="w-50 text-center mt-5" style="height: 100px">
						<div class="my-1" id="screen">스크린</div>
						
						<div id = seats class ="container text-center">
							
						</div>
				</div>
				
				</div>
			</div>
			
		</div>
	</main>
	<!-- 푸터-->
	<footer class="container">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>

</body>
<style>
	#screen{
	 font-size:30px;
	 border-radius:5px;
	border: 1px solid black;
	padding : 40px 0;
	
	}
	#seats{
		margin-top:80px;
		
	}
	#reserveSeat{
	background-color:gray;
		margin: 3px;
		color:black;
		text-decoration: none;
	}
	#seat{
		background-color:black;
		margin: 3px;
		color:white;
		text-decoration: none;
	}
	#seat:hover{
		background-color:white;
		color:black;
	}
	
	
</style>

	<script>
	$(document).ready(
		async function(){
			var no = localStorage.getItem("scheduleNo");
		 const response = await fetch("/movieschedule/info/" + no);
		  if (response.ok) {
		        const schedule = await response.json(); // Extract JSON from the response
		        console.log(schedule);
		       getSeats(schedule);
		    } else {
		        alert("영화 좌석표를 불러오는데 실패했습니다.");
		    }
		
		
		});
	
	async function getSeats(schedule){
		const response = await fetch("/pay/list/seats/" + schedule.scheduleNo);
		 if (response.ok) {
		        const seats = await response.json(); // Extract JSON from the response
		      		console.log(seats);
		        printSeats(schedule,seats);
		        	
		    } else {
		    	  alert("영화 좌석표 리스트를 불러오는데 실패했습니다.");
		    }
	}
	function printSeats(schedule,seats){
		const seatsContainer = document.getElementById("seats");
	
		for(var  i = 1; i<=schedule.screenTotalSeat;i++){
			if(seats.includes(i)){
				seatsContainer.innerHTML += '<span id="reserveSeat" style="width: 40px; display: inline-block;" onclick="printMsg()">' + i + '</span>';
			}else{
			
			seatsContainer.innerHTML += '<a href="#" id="seat" style="width: 40px; display: inline-block;" onclick="changeSeats(this.textContent)">' + i + '</a>';
			}
			if(i % 10 === 0){
				seatsContainer.innerHTML += '</br>';
			}
		};
		
		
	}

		

	

	function changeSeats(number){
		 var seat = document.getElementById("choice");
		    seat.innerHTML = number;
		
		
	};
	function printMsg(){
		alert("이미 예약된 좌석입니다.");
		
	}
	function reserve(){
		 var seat = document.getElementById("choice").innerHTML;
		 var no = localStorage.getItem("scheduleNo");
		 var id = '${memberId}';
		 var orderId = 'merchant_'  + Date.now();
		 
		 console.log(seat);
		 requestPay(id,seat,orderId,no)
		
	}
	function requestPay(memberId,seat,orderId,scheduleNo) {
		var price = 10000;
		IMP.init('imp27664032');
		var msg;

		IMP.request_pay({
			pg: 'kakaopay',
			pay_method: 'card',
			merchant_uid: orderId, // Include orderId as part of the request
		    name: '상품명: 영화예매 좌석:' + seat + '번' ,
		    amount: price,
			buyer_name: memberId,
			 m_redirect_url : 'http://localhost:8080/orderCompleteMobile'
			
			
		}, function(rsp) {
			if (rsp.success) {
				jQuery.ajax({
					url : "/pay/reserve", //cross-domain error가 발생하지 않도록 주의해주세요
					type : 'POST',
					contentType: 'application/json',
					data : JSON.stringify({
					    imp_uid: rsp.imp_uid,            // 결제 고유번호
				         merchant_uid: rsp.merchant_uid,
				         scheduleNo:scheduleNo,
				         seatNo:seat,
				         memberId:memberId
					// Add any other necessary data
					}),
					 success: function (data) {
			                // [2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
			                alert(data);
			              
			            },
			            error:function(){
					          console.log("Insert ajax 통신 실패!!!");
					 
					        }
			        });
				
			  } else {
		            var msg = '결제에 실패하였습니다.';
		            msg += '에러내용 : ' + rsp.error_msg;
		            alert(msg);
		        }
		    });
	}
	
</script>

</html>
