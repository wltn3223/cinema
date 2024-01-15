<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert Notice</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
.form-container {
	margin-top: 50px;
}
</style>
</head>
<body>
	<!-- í¤ë -->
	<header>
		<%@ include file="../WEB-INF/header.jsp"%>
	</header>
	<div class="container">
		<h2 class="mt-3">상영관 추가</h2>
		<div class="form-container">
			<form id="screen">
				<div class="mb-3">
					<label for="screenFloor" class="form-label">상영관 층</label> <input
						type="text" class="form-control" id="screenFloor"
						placeholder="상영관 층을 입력해주세요(ex:1층)" required>
				</div>
				<div class="mb-3">
					<label for="screenHall" class="form-label">상영관 관</label> <input
						type="text" class="form-control" id="screenHall"
						placeholder="상영관 관을 입력해주세요(ex:1관)" required>
				</div>
				<div class="mb-3">
					<label for="screenTotalSeat" class="form-label">상영관 1개관의
						총좌석수</label> <input type="text" class="form-control" id="screenTotalSeat"
						placeholder="상영관 총좌석수를 숫자로 입력해주세요.(ex:50)" required>
				</div>
				<div class="mb-3">
					<label for="cinemaName" class="form-label">영화관 번호</label> <input
						type="text" class="form-control" id="cinemaName"
						placeholder="목록중 하나를 입력(강남,강남대로(씨티),강동,군자,동대문)" required>
				</div>
				<button type="button" class="btn btn-primary"
					onclick="writeScreen()">작성하기</button>
			</form>
		</div>
	</div>
	<!-- í¸í°-->
	<footer class="container">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>
</body>

<script>
	function writeScreen() {
		var screenFloor = $('#screenFloor').val();
		var screenHall = $('#screenHall').val();
		var screenTotalSeat = $('#screenTotalSeat').val();
		var cinemaName = $('#cinemaName').val();

		var data = {
				screenFloor: screenFloor,
				screenHall: screenHall,
				screenTotalSeat: screenTotalSeat,
				cinemaName: cinemaName,
		    };

		$.ajax({
			type : 'POST',
			url : '/screen',
			contentType : "application/json;charset=UTF-8",
			data : JSON.stringify(data),
			success : function(response) {
				alert(response);
				location.href = "/screen/screenlist.jsp";
			},
			error : function(error) {
				var errorMessage = error.responseText;
				alert(errorMessage);
			}
		});
	}
</script>
</html>
