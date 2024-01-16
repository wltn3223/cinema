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
			<h2>공지사항</h2>
			<a href="/notice/noticewrite.jsp">
				<button class="btn btn-dark mb-2">공지사항 작성</button>
			</a> <a href="/notice/noticemodify.jsp">
				<button class="btn btn-dark mb-2">공지사항 수정</button>
			</a> <a href="/notice/deletenotice.jsp">
				<button class="btn btn-dark mb-2">공지사항 삭제</button>
			</a>
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>일련번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>조회수</th>
						<th>등록일</th>
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
				url : '/notice/list',
				contentType : 'application/json',
				success : function(notices) {
					appendNoticesToTable(notices);
				},
				error : function(error) {
					var errorMessage = error.responseText;
					alert(errorMessage);
				}
			});
		});

		function appendNoticesToTable(notices) {
			var tbody = $("table tbody");
			tbody.empty();

			for (var i = 0; i < notices.length; i++) {
				var notice = notices[i];
				var row = "<tr>"
						+ "<td>"
						+ notice.boardNo
						+ "</td>"
						+ "<td><a href='#' class='notice-title' data-board-no='" + notice.boardNo + "'>"
						+ notice.boardTitle + "</a></td>" + "<td>관리자</td>"
						+ "<td>" + notice.boardViews + "</td>" + "<td>"
						+ notice.boardDate + "</td>" + "</tr>";
				tbody.append(row);
			}

			$(".notice-title").on("click", function() {

				var boardNo = $(this).data("board-no");

				sessionStorage.setItem("BoardNo", boardNo);
				location.href = "/notice/getnotice.jsp";

			});
		}
	</script>

</body>
</html>
