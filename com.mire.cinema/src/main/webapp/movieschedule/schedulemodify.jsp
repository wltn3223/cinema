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
					<label for="scheduleNo" class="form-label">스케줄 일련번호</label> <input
						type="text" class="form-control" id="scheduleNo" required>
				</div>
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
					onclick="loadAndShowData()">데이터 불러오기</button>
				<button type="button" class="btn btn-primary"
					onclick="updateAndRedirect()">작성하기</button>
			</form>
		</div>
	</div>
	<footer class="container">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>

	<script>
		$(document).ready(function() {
			// 페이지 로드 시 로컬 스토리지에서 값 가져와 폼에 표시
			loadAndShowData();
		});

		function loadAndShowData() {
			var storedSchedule = localStorage.getItem('selectedMovieSchedule');

			if (storedSchedule) {
				var schedule = JSON.parse(storedSchedule);

				$('#scheduleNo').val(schedule.scheduleNo);
				$('#screenNo').val(schedule.screenNo);
				$('#scheduleStartTime').val(schedule.scheduleStartTime);
				$('#screenTotalSeat').val(schedule.screenTotalSeat);
				$('#movieNo').val(schedule.movieNo);
			}
		}

		function updateAndRedirect() {
			var scheduleNo = $('#scheduleNo').val();
			var screenNo = $('#screenNo').val();
			var scheduleStartTime = $('#scheduleStartTime').val();
			var screenTotalSeat = $('#screenTotalSeat').val();
			var movieNo = $('#movieNo').val();
		
			$.ajax({
				type : "GET",
				url : "/movie/" + movieNo,
				success : function(response) {
					// Extract moviePlayTime from the response
					var moviePlayTime = response.moviePlayTime;

					// Check if moviePlayTime is a valid number
					if (!isNaN(moviePlayTime)) {
						// Calculate scheduleFinishTime
						var scheduleFinishTime = calculateFinishTime(
								scheduleStartTime, moviePlayTime);

						// Update local storage with the new data
						var storedSchedule = {
							scheduleNo : scheduleNo,
							screenNo : screenNo,
							scheduleStartTime : scheduleStartTime,
							scheduleFinishTime : scheduleFinishTime,
							screenTotalSeat : screenTotalSeat,
							movieNo : movieNo
						};

						localStorage.setItem('selectedMovieSchedule', JSON
								.stringify(storedSchedule));

						// Proceed with sending updated data
						sendUpdatedData(scheduleNo,screenNo, scheduleStartTime,
								scheduleFinishTime, screenTotalSeat, movieNo);
					} else {
						console.error('Invalid moviePlayTime value:',
								moviePlayTime);
						alert('영화의 상영 시간이 올바르지 않습니다.');
					}
				},
				error : function(error) {
					console.error(error);
					alert("에러 발생");
				}
			});
		}

		function calculateFinishTime(startTime, playTime) {
			try {
				console.log('startTime:', startTime);
				console.log('playTime:', playTime);

				var startTimeObj = new Date(startTime);

				// Convert playTime to a number
				playTime = parseFloat(playTime);

				if (isNaN(playTime)) {
					throw new Error('Invalid playTime value.');
				}

				var finishTimeObj = new Date(startTimeObj.getTime() + playTime
						* 60000);

				// Format the finish time to match the format of startTime
				var finishTime = finishTimeObj.toISOString().slice(0, 16);

				console.log('finishTime:', finishTime);

				return finishTime;
			} catch (error) {
				console.error('Error in calculateFinishTime:', error);
				return null; // Handle the error appropriately or modify as needed
			}
		}

		function sendUpdatedData(scheduleNo,screenNo, scheduleStartTime,
				scheduleFinishTime, screenTotalSeat, movieNo) {
			console.log('scheduleFinishTime in sendUpdatedData:',
					scheduleFinishTime);

			$.ajax({
				type : "POST",
				url : "/movieschedule/update",
				data : JSON.stringify({
					scheduleNo : scheduleNo,
					screenNo : screenNo,
					scheduleStartTime : scheduleStartTime,
					scheduleFinishTime : scheduleFinishTime,
					screenTotalSeat : screenTotalSeat,
					movieNo : movieNo
				}),
				contentType : "application/json",
				success : function(response) {
					console.log(response);
					alert(response);
					// Redirect handling
					localStorage.removeItem('selectedMovieSchedule');
					window.location.href = '/movieschedule/schedulelist.jsp';
				},
				error : function(error) {
					console.error(error);
					alert("에러 발생");
				}
			});
		}
	</script>
</body>
</html>
