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
				url : '/notice/list', // 실제 URL은 서버의 컨트롤러 매핑에 따라 달라질 수 있음
				contentType : 'application/json',
				success : function(notices) {
					// 서버로부터의 응답 처리
					appendNoticesToTable(notices);
				},
				error : function(error) {
					// 에러 처리
					var errorMessage = error.responseText;
					alert(errorMessage);
				}
			});
		});

		function appendNoticesToTable(notices) {
			// 테이블에 공지사항 목록을 추가하는 로직
			var tbody = $("table tbody");
			tbody.empty(); // 기존 데이터 삭제

			for (var i = 0; i < notices.length; i++) {
				var notice = notices[i];
				var row = "<tr>"
						+ "<td>"
						+ notice.boardNo
						+ "</td>"
						+ "<td><a href='/notice/"
						+ notice.boardNo + "'>"
						+ notice.boardTitle + "</a></td>" + "<td>관리자</td>"
						+ "<td>" + notice.boardViews + "</td>" + "<td>"
						+ notice.boardDate + "</td>" + "</tr>";
				tbody.append(row);
			}
		}

		// 클릭 시 호출되는 함수로 선택한 아이템의 정보를 가져와서 sessionStorage에 저장
		function loadItemInfo(notices) {
			$.ajax({
				type : 'GET',
				url : '/notice/info/' + Notice,
				contentType : 'application/json',
				success : function(response) {
					console.log(response);
					// 선택한 아이템의 정보를 sessionStorage에 저장
					sessionStorage.setItem('selectedNotice', JSON
							.stringify(response));
					// itemEditForm.jsp로 이동
					location.href = '/notice/itemEditForm.jsp';
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
