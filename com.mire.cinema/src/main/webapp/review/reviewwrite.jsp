<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>리뷰 작성</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
.form-container {
	margin-top: 50px;
}
</style>
</head>
<body>

	<header>
		<%@ include file="../WEB-INF/header.jsp"%>
	</header>
	<div class="container">
		<h2 class="mt-3">리뷰 게시판</h2>
		<div class="form-container">
			<form id="review">
				 <div class="mb-3">
                <label for="reviewScore" class="form-label">평점</label>
                <select class="form-select" id="reviewScore" name="reviewScore" required>
                    <option value="1">1점</option>
                    <option value="2">2점</option>
                    <option value="3">3점</option>
                    <option value="4">4점</option>
                    <option value="5">5점</option>
                </select>
            </div>
				<div class="mb-3">
					<label for="reviewTitle" class="form-label">제목</label> <input
						type="text" class="form-control" id="reviewTitle"
						placeholder="제목을 입력해주세요" required>
				</div>
				<div class="mb-3">
					<label for="reviewContent" class="form-label">답변 내용</label>
					<textarea class="form-control" id="reviewContent"
						placeholder="내용을 입력해주세요" required></textarea>
				</div>
				<button type="button" class="btn btn-dark" onclick="writeReview()">작성하기</button>
			</form>
		</div>
	</div>

	<footer class="container">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>
</body>

<script>
	function writeReview() {
		var reviewScore = $('#reviewScore').val();
		var reviewTitle = $('#reviewTitle').val();
		var reviewContent = $('#reviewContent').val();

		var requestData = {
			reviewScore : reviewScore,
			reviewTitle : reviewTitle,
			reviewContent : reviewContent
		};

		$.ajax({
			type : 'POST',
			url : '/review',
			contentType : 'application/json',
			data : JSON.stringify(requestData),
			success : function(response) {
				alert(response);
				location.href = "/review/reviewlist.jsp";
			},
			error : function(error) {
				var errorMessage = error.responseText;
				alert(errorMessage);
			}
		});
	}
</script>

</html>
