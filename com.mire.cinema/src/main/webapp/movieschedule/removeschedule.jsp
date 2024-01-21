<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>상영관 업데이트</title>
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
	<!-- 헤더 -->
	<header>
		<%@ include file="../WEB-INF/header.jsp"%>
	</header>

	<div class="container">
		<h2 class="mt-3">공지사항 삭제</h2>
		<div class="form-container">
			<form id="screenForm">
				<div class="mb-3">
					<label for="scheduleNo" class="form-label">스케줄 일련번호</label> <input
						type="text" class="form-control" id="scheduleNo"
						placeholder="삭제할 스케줄 일련번호번호를 입력하세요" required>
				</div>
				
				<button type="button" class="btn btn-primary"
					onclick="writeNotice()">상영관 삭제</button>
			</form>
		</div>
	</div>

	<!-- 푸터 -->
	<footer class="container">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>

	<script>
		function writeNotice() {
			var scheduleNo = $('#scheduleNo').val();

			var data = {
					scheduleNo : scheduleNo,
			};

			$.ajax({
				type : 'Delete',
				url : '/movieschedule/'+ scheduleNo,
				contentType : "application/json;charset=UTF-8",
				data : JSON.stringify(data),
				success : function(response) {
					alert(response);
					location.href = "/movieschedule/schedulelist.jsp";
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
