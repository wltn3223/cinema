<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Q%A 게시판</title>
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
			<h2>Q&A 게시판</h2>
			<br>
			<table class="table table-bordered table-striped">
				<tbody id="tableBody">
				</tbody>
			</table>
		</div>
		<div class="text-end">
			<a href="/answer/answermodify.jsp"><button class="btn btn-light bg-dark text-light" type="button">수정하기</button></a>
			<button class="btn btn-light bg-dark text-light" type="button"
				onclick="removeAnswer()">삭제하기</button>
			<a href="/answer/answerlist.jsp"><button
					class="btn btn-light bg-dark text-light"">목록으로</button></a>
		</div>
	</main>
	<!-- 푸터-->
	<footer class="container">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>
</body>
<script>
	$(document).ready(function() {
		var ansNo = localStorage.getItem('ansNo');
		if (ansNo) {
			$.ajax({
				type : 'GET',
				url : '/answer/info/' + ansNo,
				contentType : 'application/json',
				success : function(answer) {
					appendAnswerToTable(answer);
				},
				error : function(error) {
					var errorMessage = error.responseText;
					alert(errorMessage);
				}
			});
		} else {
			// 'ansNo' 값이 없을 때의 처리
			alert("Answer number not available.");
		}
	});
	function appendAnswerToTable(answer) {
		var tbody = $("#tableBody");
		tbody.empty();
		var row = "<div class='card'>" + "<div class='card-header'>"
				+ "<h4 class='card-title'>" + "<strong>" + answer.ansTitle
				+ "</strong>" + "<span class='float-end'><strong>조회수 </strong>"
				+ answer.ansViews + " | <strong>등록일 </strong>" + answer.ansDate
				+ "</span>" + "</h4>" + "</div>" + "<div class='card-body'>"
				+ "<p class='card-text'><strong>작성자 | </strong>관리자</p>"
				+ "<p class='card-text'>" + answer.ansContent + "</p>"
				+ "</div>" + "</div>";

		tbody.append(row);
	}






	function removeAnswer() {
		var ansNo = localStorage.getItem('ansNo');
		var confirmDelete = confirm("정말로 게시글을 삭제하시겠습니까?");

		if (confirmDelete) {
			$.ajax({
				type : "DELETE",
				url : "/answer/" + ansNo,
				success : function(response) {
					console.log("Delete successful:", response);
					alert("게시글이 삭제되었습니다.");
					location.href = "/answer/answerlist.jsp";
				},
				error : function(error) {
					var errorMessage = error.responseText;
					alert(errorMessage);
				}
			});
		} else {
			// 사용자가 삭제를 취소한 경우
			alert("게시글 삭제가 취소되었습니다.");
		}
	}
</script>
</html>