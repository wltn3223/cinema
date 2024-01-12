<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyBatis 게시판 - 영화관 수정</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<header>
		<%@ include file="../WEB-INF/header.jsp"%>
	</header>
	<div class="container mt-5">
		<h2 class="mb-4">영화관 수정</h2>
		<form id="cinemaForm">
			<div class="mb-3">
				<label for="cinemaNo" class="form-label">영화관번호</label> <input
					type="text" class="form-control" id="cinemaNo" name="cinemaNo"
					readonly>
			</div>
			<div class="mb-3">
				<label for="cinemaName" class="form-label">영화관이름</label> <input
					type="text" class="form-control" id="cinemaName" name="cinemaName"
					readonly>
			</div>
			<div class="mb-3">
				<label for="cinemaIntro" class="form-label">영화관소개</label>
				<textarea class="form-control" id="cinemaIntro" name="cinemaIntro"
					readonly></textarea>
			</div>
			<div class="mb-3">
				<label for="cinemaTotalScreen" class="form-label">총상영관수</label> <input
					type="text" class="form-control" id="cinemaTotalScreen"
					name="cinemaTotalScreen" readonly>
			</div>
			<div class="mb-3">
				<label for="cinemaPhone" class="form-label">영화관전화번호</label> <input
					type="text" class="form-control" id="cinemaPhone"
					name="cinemaPhone" readonly>
			</div>
			<div class="mb-3">
				<label for="cinemaLocation" class="form-label">영화관위치</label>
				<textarea class="form-control" id="cinemaLocation"
					name="cinemaLocation" readonly></textarea>
			</div>
			<button type="button" class="btn btn-primary" id="btnEdit">수정</button>
			<button type="submit" class="btn btn-success" id="btnSave"
				style="display: none;">저장</button>
			<button type="button" class="btn btn-secondary" id="btnCancel"
				style="display: none;">취소</button>
		</form>
	</div>


	<footer class="container mt-5">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>
</body>
<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script>
		$(document).ready(function() {
			var cinemaString = JSON.parse(sessionStorage.getItem('cinema'));
			var cinema = JSON.String(cinemaString);
			console.log(cinema);

		})

		$(document).ready(function() {
			// 페이지 로드 시 sessionStorage에서 선택한 상품 정보를 가져와서 폼에 표시
			var cinemaString = sessionStorage.getItem('cinema');
			var cinema = JSON.parse(cinemaString);
			// JSON 문자열을 객체로 변환한다.
			$('#cinemaNo').val(cinema.cinemaNo);
			$('#cinemaName').val(cinema.cinemaName);
			$('#cinemaIntro').val(cinema.cinemaIntro);
			$('#cinemaTotalScreen').val(cinema.cinemaTotalScreen);
			$('#cinemaPhone').val(cinema.cinemaPhone);
			$('#cinemaTotalScreen').val(cinema.cinemaTotalScreen);
			$('#cinemaLocation').val(cinema.cinemaLocation);
			
			

		});
		
		window.addEventListener('beforeunload', function (event) {
		    // 현재 페이지 URL 확인
		    var currentURL = window.location.href;
		    console.log(currentURL);

		    // 특정 조건에 따라 세션 스토리지를 지우기
		    if (currentURL !== 'http://localhost:8080/cinema/modify.jsp') {
		        // 세션 스토리지 지우기
		        sessionStorage.clear();
		    }
		});
	</script>



<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</html>
</html>
