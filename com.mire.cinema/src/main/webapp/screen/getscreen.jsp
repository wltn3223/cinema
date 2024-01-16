<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>MIRE MOVIE</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
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
			<h2>상영관 내용</h2>
			<a href="/screenwrite.jsp"><button class="btn btn-dark mb-2">상영관
					작성</button></a>
			<a href="/getcinemascreen.jsp"><button class="btn btn-dark mb-2">상영관 검색</button></a>
			<table class="table table-bordered table-striped">
				<thead>
					<tr>
						<th>상영관 일련번호</th>
						<th>상영관 층</th>
						<th>상영관 관</th>
						<th>상영관 총 좌석</th>
						<th>영화관 일련번호</th>
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
</body>
<script>
	$(document).ready(function() {
		var screenNo = sessionStorage.getItem('ScreenNo');

		$.ajax({
			type : 'GET',
			url : '/screen/' + screenNo,
			contentType : 'application/json',
			success : function(screen) {
				appendScreenToTable(screen);
			},
			error : function(error) {
				// 에러 처리
				var errorMessage = error.responseText;
				alert(errorMessage);
			}
		});
	});
	
	function appendScreenToTable(screen) {
		// 테이블에 공지사항 목록을 추가하는 로직
		var tbody = $("table tbody");
		tbody.empty(); // 기존 데이터 삭제

		var row = "<tr>"
			+ "<td>"
			+ screen.screenNo + "</td>" + "<td>"
			+ screen.screenFloor + "</td>" + "<td>"
			+ screen.screenHall + "</td>" + "<td>"
			+ screen.screenTotalSeat + "</td>" + "<td>"
			+ screen.cinemaName + "</td>" + "</tr>";

		tbody.append(row);
	}
</script>

</html>
