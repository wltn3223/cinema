<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>문의사항 수정</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
.form-container {
	margin-top: 50px;
}
</style>
</head>
<body>
	<!-- 헤더 -->
	<header>
		<%@ include file="../WEB-INF/header.jsp"%>
	</header>

	<div class="container">
		<h2 class="mt-3">문의사항 수정</h2>
		<div class="form-container">
			<form id="askForm"> <!-- 수정된 폼 id -->
				<input type="hidden" id="askNo" name="askNo">
				<div class="mb-3">
					<label for="askTitle" class="form-label">문의사항 제목</label>
					<input type="text" class="form-control" id="askTitle" placeholder="수정할 문의사항 제목을 입력하세요" required>
				</div>
				<div class="mb-3">
					<label for="askContent" class="form-label">문의사항 내용</label>
					<input type="text" class="form-control" id="askContent" placeholder="수정할 문의사항 내용을 입력하세요" required>
				</div>
				<script>
					$(document).ready(function() {
						var askNo = localStorage.getItem('askNo');

						$.ajax({
							type : 'GET',
							url : '/ask/' + askNo,
							contentType : 'application/json',
							success : function(ask) {
								$('#askNo').val(ask.askNo);
								$('#askTitle').val(ask.askTitle);
								$('#askContent').val(ask.askContent);
							},
							error : function(error) {
								var errorMessage = error.responseText;
								alert(errorMessage);
							}
						});
					});

					function writeAsk() {
						var askNo = $('#askNo').val();
						var askTitle = $('#askTitle').val();
						var askContent = $('#askContent').val();

						var data = {
							askNo : askNo,
							askTitle : askTitle,
							askContent : askContent
						};

						$.ajax({
							type : 'PUT', // 수정된 부분
							url : '/ask',
							contentType : "application/json;charset=UTF-8",
							data : JSON.stringify(data),
							success : function(response) {
								alert(response);
								location.href = "/ask/asklist.jsp";
							},
							error : function(error) {
								var errorMessage = error.responseText;
								alert(errorMessage);
							}
						});
					}
				</script>
				<button type="button" class="btn btn-primary" onclick="writeAsk()">문의사항 수정</button>
			</form>
		</div>
	</div>

	<!-- 푸터 -->
	<footer class="container">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>
</body>
</html>
