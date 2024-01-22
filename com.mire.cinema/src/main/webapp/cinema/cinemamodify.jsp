<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>영화관 수정</title>
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
		<h2 class="mt-3">영화관 수정</h2>
		<div class="form-container">
			<form id="screenForm">
				<!-- 여기에 hidden 필드를 추가하여 영화관 번호를 유지하도록 합니다 -->
				<input type="hidden" id="cinemaNo" name="cinemaNo">

				<div class="mb-3">
					<label for="cinemaName" class="form-label">영화관 이름</label> <input
						type="text" class="form-control" id="cinemaName"
						placeholder="수정할 영화관 이름을 입력하세요" required>
				</div>
				<div class="mb-3">
					<label for="cinemaIntro" class="form-label">영화관 소개</label> <input
						type="text" class="form-control" id="cinemaIntro"
						placeholder="수정할 영화관 소개를 입력하세요" required>
				</div>
				<div class="mb-3">
					<label for="cinemaTotalScreen" class="form-label">총 상영관수</label> <input
						type="text" class="form-control" id="cinemaTotalScreen"
						placeholder="수정할 총 상영관수를 입력하세요" required>
				</div>
				<div class="mb-3">
					<label for="cinemaPhone" class="form-label">영화관 전화번호</label> <input
						type="text" class="form-control" id="cinemaPhone"
						placeholder="수정할 영화관 전화번호를 입력하세요" required>
				</div>
				<div class="mb-3">
					<label for="cinemaLocation" class="form-label">영화관위치</label> <input
						type="text" class="form-control" id="cinemaLocation"
						placeholder="수정할 영화관 위치를 입력하세요" required>
				</div>
				<!-- 영화관 정보를 불러와 폼에 출력하는 스크립트를 추가 -->
				<script>
					$(document)
							.ready(
									function() {
										var cinemaNo = sessionStorage
												.getItem('CinemaNo');

										$
												.ajax({
													type : 'GET',
													url : '/cinema/' + cinemaNo,
													contentType : 'application/json',
													success : function(cinema) {
														// 영화관 정보를 폼에 출력
														$('#cinemaNo')
																.val(
																		cinema.cinemaNo);
														$('#cinemaName')
																.val(
																		cinema.cinemaName);
														$('#cinemaIntro')
																.val(
																		cinema.cinemaIntro);
														$('#cinemaTotalScreen')
																.val(
																		cinema.cinemaTotalScreen);
														$('#cinemaPhone')
																.val(
																		cinema.cinemaPhone);
														$('#cinemaLocation')
																.val(
																		cinema.cinemaLocation);
													},
													error : function(error) {
														var errorMessage = error.responseText;
														alert(errorMessage);
													}

												});

									});
					// 영화관 정보 업데이트 함수
					function writeCinema() {
						var cinemaNo = $('#cinemaNo').val();
						var cinemaName = $('#cinemaName').val();
						var cinemaIntro = $('#cinemaIntro').val();
						var cinemaTotalScreen = $('#cinemaTotalScreen').val();
						var cinemaPhone = $('#cinemaPhone').val();
						var cinemaLocation = $('#cinemaLocation').val();

						var data = {
							cinemaNo : cinemaNo,
							cinemaName : cinemaName,
							cinemaIntro : cinemaIntro,
							cinemaTotalScreen : cinemaTotalScreen,
							cinemaPhone : cinemaPhone,
							cinemaLocation : cinemaLocation,
						};

						$.ajax({
							type : 'put',
							url : '/cinema',
							contentType : "application/json;charset=UTF-8",
							data : JSON.stringify(data),
							success : function(response) {
								alert(response);
								location.href = "/cinema/cinemalist.jsp";
							},
							error : function(error) {
								var errorMessage = error.responseText;
								alert(errorMessage);
							}
						});
					}
				</script>
				<button type="button" class="btn btn-primary"
					onclick="writeCinema()">영화관 수정</button>
			</form>
		</div>
	</div>

	<!-- 푸터 -->
	<footer class="container">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>
</body>
</html>
