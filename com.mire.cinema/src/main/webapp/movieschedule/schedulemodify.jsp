<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>상영관 업데이트</title>
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
	<!-- 헤더 -->
	<header>
		<%@ include file="../WEB-INF/header.jsp"%>
	</header>

	<div class="container">
		<h2 class="mt-3">상영관 수정</h2>
		<div class="form-container">
			<form>
				<div class="mb-3">
					<label for="scheduleNo" class="form-label">스케줄 일련번호</label> <input
						type="text" class="form-control" id="scheduleNo"
						placeholder="업데이트할 스케줄 번호를 입력하세요" required>
				</div>
				<div class="mb-3">
					<label for="screenNo" class="form-label">상영관 일련번호</label> <input
						type="text" class="form-control" id="screenNo"
						placeholder="업데이트할 상영관 번호를 입력하세요" required>
				</div>
				<div class="mb-3">
					<label for="movieNo" class="form-label">영화 일련번호</label> <input
						type="text" class="form-control" id="movieNo"
						placeholder="업데이트할 영화를 숫자로 입력하세요" required>
				</div>
				<div class="mb-3">
					<label for="scheduleStartTime" class="form-label">상영시작시간</label> <input
						type="datetime-local" class="form-control" id="scheduleStartTime"
						placeholder="업데이트할 상영시간을 입력하세요" required>
				</div>
				<button class="btn btn-primary" onclick="update()">상영관 업데이트</button>
			</form>
		</div>
	</div>


	<!-- 푸터 -->
	<footer class="container">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>

	<script>
		function update() {
			var scheduleNo = $('#scheduleNo').val();
			var screenNo = $('#screenNo').val();
			var movieNo = $('#movieNo').val();
			var scheduleStartTime = $('#scheduleStartTime').val();

			// 필수 항목 검사
			if (!scheduleNo || !screenNo || !movieNo || !scheduleStartTime) {
				alert("모든 필수 항목을 입력하세요.");
				return;
			}

			// scheduleStartTime을 Date 객체로 변환
			var scheduleStartTime = new Date(scheduleStartTimeStr);

			// 서버에서 영화 정보를 받아오기
			$.ajax({
				type : "GET",
				url : "/movie/" + movieNo,
				contentType : "application/json",
				success : function(movieResponse) {
					var moviePlayTime = movieResponse.moviePlayTime;

					// scheduleFinishTime 계산
					var scheduleFinishTime = new Date(scheduleStartTime
							.getTime()
							+ (moviePlayTime * 60000));

					var data = {
						scheduleNo : scheduleNo,
						screenNo : screenNo,
						movieNo : movieNo,
						scheduleStartTime : scheduleStartTime,
						scheduleFinishTime : scheduleFinishTime
					};

					// 실제 업데이트 요청
					$.ajax({
						type : "POST",
						url : "/movieschedule/update",
						contentType : "application/json;charset=UTF-8",
						data : JSON.stringify(data),
						success : function(response) {
							alert(response);
							location.href = "/movieschedule/schedulelist.jsp";
							localStorage.clear();
						},
						error : function(error) {
							var errorMessage = error.responseText;
							alert(errorMessage);
						}
					});
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
