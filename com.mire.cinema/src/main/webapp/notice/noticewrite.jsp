<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert Notice</title>
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
	<!-- í¤ë -->
	<header>
		<%@ include file="../WEB-INF/header.jsp"%>
	</header>
	<div class="container">
		<h2 class="mt-3">공지사항</h2>
		<div class="form-container">
			<form>
				<div class="mb-3">
					<label for="boardTitle" class="form-label">제목</label> <input
						type="text" class="form-control" id="boardTitle"
						placeholder="제목을 입력해주세요" required>
				</div>
				<div class="mb-3">
					<label for="boardContent" class="form-label">공지사항</label>
					<textarea class="form-control" id="boardContent"
						placeholder="공지사항을 입력해주세요" required></textarea>
				</div>
				<button type="button" class="btn btn-primary"
					onclick="writeNotice()">작성하기</button>
			</form>
		</div>
	</div>
	<!-- í¸í°-->
	<footer class="container">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>
</body>

<script>
	function writeNotice() {
		var boardTitle = $('#boardTitle').val();
		var boardContent = $('#boardContent').val();

		var noticeData = {
			boardTitle : boardTitle,
			boardContent : boardContent
		};

		$.ajax({
			type : 'POST',
			url : '/notice',
			contentType : 'application/json',
			dataType : 'text',
			data : JSON.stringify(noticeData),
			success : function(response) {
				alert(response);
				location.href = "/notice/noticelist.jsp";
			},
			error : function(error) {
				var errorMessage = error.responseText;
				alert(errorMessage);
			}
		});
	}
</script>
</html>
