<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert Answer</title>
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
		<h2 class="mt-3">Q&A 게시판</h2>
		<div class="form-container">
			<form id="answer">
				<div class="mb-3">
					<label for="ansTitle" class="form-label">제목</label> <input
						type="text" class="form-control" id="ansTitle"
						placeholder="제목을 입력해주세요" required>
				</div>
				<div class="mb-3">
					<label for="ansContent" class="form-label">답변 내용</label>
					<textarea class="form-control" id="ansContent"
						placeholder="내용을 입력해주세요" required></textarea>
				</div>
				<button type="button" class="btn btn-dark" onclick="writeAnswer()">작성하기</button>
			</form>
		</div>
	</div>

	<footer class="container">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>
</body>

<script>
	function writeAnswer() {
		var ansTitle = $('#ansTitle').val();
		var ansContent = $('#ansContent').val();

		var requestData = {
			ansTitle : ansTitle,
			ansContent : ansContent
		};

		$.ajax({
			type : 'POST',
			url : '/answer',
			contentType : 'application/json',
			data : JSON.stringify(requestData),
			success : function(response) {
				alert(response);
				location.href = "/answer/answerlist.jsp";
			},
			error : function(error) {
				var errorMessage = error.responseText;
				alert(errorMessage);
			}
		});
	}
</script>

</html>
