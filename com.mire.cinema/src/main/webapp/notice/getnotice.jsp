<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
			<h2>공지사항</h2>
			<a href="/noticewrite.jsp"><button class="btn btn-dark mb-2">공지사항
					작성</button></a>
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>일련번호</th>
						<th>작성자</th>
						<th>제목</th>
						<th>내용</th>
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
</body>
<script>
	$(document).ready(function() {
		var boardNo = $('#boardNo').val();

		var noticeData = {
			boardNo : boardNo
		};

		$.ajax({
			type : 'GET',
			url : '/notice/' + boardNo, // 실제 URL은 서버의 컨트롤러 매핑에 따라 달라질 수 있음
			contentType : 'application/json',
			data : JSON.stringify(noticeData),
			success : function(notice) {
				appendNoticeToTable(notice);
			},
			error : function(error) {
				// 에러 처리
				var errorMessage = error.responseText;
				alert(errorMessage);
			}
		});
	});

	function appendNoticeToTable(notice) {
		// 테이블에 공지사항 목록을 추가하는 로직
		var tbody = $("table tbody");
		tbody.empty(); // 기존 데이터 삭제

		var row = "<tr>" + "<td>" + notice.boardNo + "</td>" + "<td>관리자</td>"
				+ "<td><a href='/notice/" + notice.boardNo + "'>"
				+ notice.boardTitle + "</a></td>" + "<td>"
				+ notice.boardContent + "</td>" + "<td>" + notice.boardViews
				+ "</td>" + "<td>" + notice.boardDate + "</td>" + "</tr>";

		tbody.append(row);
	}
</script>
</html>