<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>MIRE MOVIE</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
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
			<h2>공지사항</h2>
			<a href="/notice/noticelist.jsp"><button
					class="btn btn-dark mb-2">공지사항 리스트 보러가기</button></a>
			<table class="table table-bordered table-striped">
				<tbody id="tableBody">
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
			var boardNo = sessionStorage.getItem('BoardNo');

			$.ajax({
				type : 'GET',
				url : '/notice/' + boardNo,
				contentType : 'application/json',
				success : function(notice) {
					appendNoticeToTable(notice);
				},
				error : function(error) {
					var errorMessage = error.responseText;
					alert(errorMessage);
				}
			});
		});

		function appendNoticeToTable(notice) {
			var tbody = $("#tableBody");
			tbody.empty();

			var row = "<tr><th scope='col'>일련번호</th><td>"
					+ notice.boardNo
					+ "</td></tr>"
					+ "<tr><th scope='col'>작성자</th><td>관리자</td></tr>"
					+ "<tr><th scope='col'>제목</th><td>"
					+ notice.boardTitle
					+ "</td></tr>"
					+ "<tr><th scope='col'>내용</th><td>"
					+ notice.boardContent
					+ "</td></tr>"
					+ "<tr><th scope='col'>조회수</th><td>"
					+ notice.boardViews
					+ "</td></tr>"
					+ "<tr><th scope='col'>등록일</th><td>"
					+ notice.boardDate
					+ "</td></tr>"
					+ "<tr><th scope='col'>이미지</th><td><img src='" + notice.imageUuid + "'></td></tr>";

			tbody.append(row);
		}
	</script>
</body>
</html>
