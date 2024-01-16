<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<head>
<title>MIRE MOVIE</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
	<main class="container">
		<div class="container mt-3">
			<h2>영화관 리스트</h2>
			
			 <a href="/cinema/cinemamodify.jsp">
				<button class="btn btn-dark mb-2">영화관 수정</button></a>
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>영화관번호</th>
						<th>영화관이름</th>
						<th>영화관소개</th>
						<th>총상영관수</th>
						<th>영화관전화번호</th>
						<th>영화관위치</th>
					</tr>
				</thead>
				<tbody id="table tbody">

				</tbody>
			</table>
		</div>
	</main>
	<!-- 푸터-->
	<footer class="container">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>

	<script>
		$(document).ready(function() {
			$.ajax({
				type : 'GET',
				url : '/cinema/list',
				contentType : 'application/json',
				success : function(cinemas) {
					appendCinemasToTable(cinemas);
				},
				error : function(error) {
					var errorMessage = error.responseText;
					alert(errorMessage);
				}
			});
		});

		function appendCinemasToTable(cinemas) {
			var tbody = $("table tbody");
			tbody.empty();

			for (var i = 0; i < cinemas.length; i++) {
				var cinema = cinemas[i];
				var row = "<tr>"
						+ "<td>"
						+ cinema.cinemaNo
						+ "</td>"
						+ "<td>"
						+ cinema.cinemaName
						+ "</td>"+ "<td>"
						+ cinema.cinemaIntro
						+ "</td>"+ "<td>"
						+ cinema.cinemaTotalScreen
						+ "</td>"+ "<td>"
						+ cinema.cinemaPhone
						+ "</td>"+ "<td>"
						+ cinema.cinemaLocation
						+ "</td>"
				
				tbody.append(row);
			}
			$(".cinema-name").on("click", function() {
				var cinemaNo = $(this).data("cinema-no");

				// Ajax 요청을 통해 조회수 업데이트 API 호출
				$.ajax({
					type : 'PATCH',
					url : '/cinema/' + cinemaNo + '/updateViews',
					contentType : 'application/json',
					success : function(updatedCinema) {
						// 성공 시 필요한 작업 수행
						console.log("Views updated:", updatedCinema);
					},
					error : function(error) {
						// 에러 처리
						var errorMessage = error.responseText;
						alert(errorMessage);
					}
				});

				// 세션 스토리지에 공지사항 번호 저장 및 페이지 이동
				sessionStorage.setItem("CinemaNo", cinemaNo);
				location.href = "/notice/getcinema.jsp";
			});
		}
	</script>

</body>
</html>
