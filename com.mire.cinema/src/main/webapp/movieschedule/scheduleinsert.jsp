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
	<header>
		<%@ include file="../WEB-INF/header.jsp"%>
	</header>
	<div class="container">
		<h2 class="mt-3">MOVIE SCHEDULE</h2>
		<div class="form-container">
			<form>
				<div class="mb-3">
					<label for="screenNo" class="form-label">상영관 일련번호</label> <input
						type="text" class="form-control" id="screenNo"
						placeholder="상영관 일랸번호를 입력해주세요" required>
				</div>
				<div class="mb-3">
					<label for="scheduleStartTime" class="form-label">영화시작시간</label> <input
						type="datetime-local" class="form-control" id="scheduleStartTime"
						placeholder="영화 시작시간을 입력해주세요" required>
				</div>
				<div class="mb-3">
					<label for="screenTotalSeat" class="form-label">상영관 총좌석</label> <input
						type="text" class="form-control" id="screenTotalSeat"
						placeholder="상영관의 총좌석을 입력해주세요" required>
				</div>
				<div class="mb-3">
					<label for="movieNo" class="form-label">영화 일련번호</label> <input
						type="text" class="form-control" id="movieNo"
						placeholder="상영관에 상영할 영화 일련번호를 입력해주세요" required>
				</div>
				<button type="button" class="btn btn-dark"
					onclick="scheduleInsert()">작성하기</button>
			</form>
		</div>
	</div>
	<footer class="container">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>
</body>

<script>
	function scheduleInsert() {
		var screenNo = $('#screenNo').val();
		var scheduleStartTime = $('#scheduleStartTime').val();
		var screenTotalSeat = $('#screenTotalSeat').val();
		var movieNo = $('#movieNo').val();

		var ScheduleData = {
			screenNo : screenNo,
			scheduleStartTime : scheduleStartTime,
			screenTotalSeat : screenTotalSeat,
			movieNo : movieNo
		};

		$.ajax({
			type : 'POST',
			url : '/movieschedule',
			contentType : 'application/json',
			data : JSON.stringify(ScheduleData),
			success : function(response) {
				alert(response);
				location.href = "/movieschedule/schedulelist.jsp";
			},
			error : function(error) {
				var errorMessage = error.responseText;
				console.error(errorMessage); // 에러 메시지를 콘솔에 출력
				alert(errorMessage);
			}
		});
	}
</script>
</html>
