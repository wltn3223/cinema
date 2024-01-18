<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>공지사항 업데이트</title>
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
		<h2 class="mt-3">공지사항 업데이트</h2>
		<div class="form-container">
			<form id="screenForm" action="/notice/update"
				enctype="multipart/form-data" method="post">
				<div class="mb-3">
					<label for="boardNo" class="form-label">공지사항 일련번호</label> <input
						type="text" class="form-control" id="boardNo" name="boardNo"
						placeholder="수정할 공지사항 일련번호번호를 입력하세요" required>
				</div>
				<div class="mb-3">
					<label for="boardTitle" class="form-label">제목</label> <input
						type="text" class="form-control" id="boardTitle" name="boardTitle"
						placeholder="수정할 제목을 입력하세요" required>
				</div>
				<div class="mb-3">
					<label for="boardContent" class="form-label">공지사항</label> <input
						type="text" class="form-control" id="boardContent"
						name="boardContent" placeholder="수정할 공지사항을 입력하세요" required>
				</div>
				<div class="mb-3">
					<label for="imageUuid" class="form-label">이미지</label> <input
						type="file" class="form-control" id="imageUuid" name="file"
						placeholder="수정할 이미지을 넣으세요">
				</div>
				<button class="btn btn-primary">상영관 업데이트</button>
			</form>
		</div>
	</div>

	<!-- 푸터 -->
	<footer class="container">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>

</body>
</html>
