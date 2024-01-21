<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>리뷰 게시판</title>
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
			<h2>리뷰 게시판</h2>
			<br>
			<table class="table table-bordered table-striped">
				<tbody id="tableBody">
				</tbody>
			</table>
		</div>
		<div class="text-end">
			<a href="/review/reviewmodify.jsp"><button
					class="btn btn-light bg-dark text-light" type="button">수정하기</button></a>
			<button class="btn btn-light bg-dark text-light" type="button"
				onclick="removeReview()">삭제하기</button>
			<a href="/review/reviewlist.jsp"><button
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
		var reviewNo = sessionStorage.getItem('reviewNo');

		if (reviewNo) {
			$.ajax({
				type : 'GET',
				url : '/review/info/' + reviewNo,
				contentType : 'application/json',
				success : function(review) {
					appendReviewToTable(review);
				},
				error : function(error) {
					var errorMessage = error.responseText;
					alert(errorMessage);
				}
			});
		} else {

			alert("Review number not available.");
		}
	});

	function appendReviewToTable(review) {
		var tbody = $("#tableBody");
		tbody.empty();

		var row = "<div class='card'>" + "<div class='card-header'>"
				+ "<h4 class='card-title'>" + "<strong>" + review.reviewTitle
				+ "</strong>" + "<span class='float-end'>"
				+ "<strong>조회수 </strong>" + review.reviewViews
				+ " | <strong>등록일 </strong>" + review.reviewDate + "</span>"
				+ "</h4>" + "<p class='card-text'><strong>평점 </strong>"
				+ review.reviewScore +"점" + "</p>" + 
				"</div>" + "<div class='card-body'>"
				+ "<p class='card-text'><strong>작성자 | </strong>관리자</p>"
				+ "<p class='card-text'>" + review.reviewContent + "</p>"
				+ "</div>" + "</div>";

		tbody.append(row);
	}

	function removeReview() {
		var reviewNo = sessionStorage.getItem('reviewNo');
		var confirmDelete = confirm("정말로 게시글을 삭제하시겠습니까?");

		if (confirmDelete) {
			$.ajax({
				type : "DELETE",
				url : "/review/" + reviewNo,
				success : function(response) {
					console.log("Delete successful:", response);
					alert("게시글이 삭제되었습니다.");
					location.href = "/review/reviewlist.jsp";
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
