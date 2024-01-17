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
			<br>
			<h2>공지사항</h2>
			<br>
			<table class="table table-bordered table-striped">
				<tbody id="tableBody">
				</tbody>
			</table>
		</div>
		<div class="text-end">
			<!-- 추가: 텍스트를 오른쪽 정렬하는 클래스 -->
			<a href="/notice/noticelist.jsp"><button
					class="btn btn-dark mb-2">목록으로</button></a>
		</div>
	</main>
	<!-- 푸터-->
	<footer class="container">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>
</body>

<script>
	$(document).ready(function() {
		var boardNo = sessionStorage.getItem('BoardNo');

		$.ajax({
			type : 'GET',
			url : '/notice/' + boardNo,
			contentType : 'application/json',
			success : function(notice) {
				appendNoticeToTable(notice);
				consol.log(notice);
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

		var row = "<div class='card'>"
				+ "<div class='card-header'>"
				+ "<h4 class='card-title'>"
				+ "<strong>"
				+ notice.boardTitle
				+ "</strong>"
				+ "<span class='float-end'><strong>조회수 </strong>"
				+ notice.boardViews
				+ " | <strong>등록일 </strong>"
				+ notice.boardDate
				+ "</span>"
				+ "</h4>"
				+ "</div>"
				+ "<div class='card-body'>"
				+ "<p class='card-text'><strong>작성자 | </strong>관리자</p>"
				+ "<p class='card-text'>"
				+ notice.boardContent
				+ "</p>"
				+ "<img src='../upload/" + notice.imageUuid + "' class='img-fluid' alt='이미지'>"
				+ "</div>" + "</div>";

		tbody.append(row);
	}
</script>
</html>
