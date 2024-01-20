<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>정보조회</title>
<link rel="stylesheet" type="text/css" href="/css/common.css">
</head>
<style>
.styled-input {
	background-color: #f8f9fa;
	border: 1px solid #ced4da;
	padding: 10px;
	border-radius: 4px;
	margin-bottom: 10px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	 
}

.btn-dark a {
	text-decoration: none;
	color: white;
}


</style>

<body>
	<header>
		<%@ include file="../WEB-INF/header.jsp"%>
	</header>

	<div class="container mt-5">
		<div class="row justify-content-center">
			<div class="col-md-6">


				<h1 class="text-center mb-4">내 정보</h1>
				<form>
					<div class="form-group">
						<label for="memberId">아이디</label> <input type="text"
							class="form-control styled-input" id="memberId"
							readonly="readonly">
					</div>
					<div class="form-group">
						<label for="memberName">이름</label> <input type="text"
							class="form-control styled-input" id="memberName"
							readonly="readonly">
					</div>
					<div class="form-group">
						<label for="memberEmail">이메일</label> <input type="email"
							class="form-control styled-input" id="memberEmail"
							readonly="readonly">
					</div>
					<div class="form-group">
						<label for="memberPhone">전화번호</label> <input type="tel"
							class="form-control styled-input" id="memberPhone"
							readonly="readonly">
					</div>
					<div class="form-group">
						<label for="memberGrade">회원등급</label> <input type="tel"
							class="form-control styled-input" id="memberGrade"
							readonly="readonly">
					</div>
					<div class="form-group">
						<label for="memberDate">가입일</label> <input type="tel"
							class="form-control styled-input" id="memberDate"
							readonly="readonly">
					</div>
					<div class="d-flex justify-content-center mt-4">
						<button class="btn btn-dark mx-2" type="button">
							<a href="/member/memberEditForm.jsp" class="text-light">비밀번호
								변경</a>
						</button>
						<button class="btn btn-dark mx-2" type="button" id="removeMember">
							<a class="text-light">회원탈퇴</a>
						</button>
						<button class="btn btn-dark mx-2" type="button">
							<a href="/" class="text-light">홈으로</a>
						</button>
					</div>
				</form>

			</div>
		</div>
	</div>
	<footer class="text-dark">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>



</body>


<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
	$(document).ready(function() {
		// document가 준비되었을 때 실행할 코드
		// getInfo 함수 호출
		getInfo();
	});
	function getInfo() {
		let memberId = '${memberId}';

		$.ajax({
			type : "get",
			url : "/member/info/" + memberId, // 서버에서 정보를 가져오는 URL을 설정
			contentType : "application/json;charset=UTF-8",
			success : function(response) {
				// 서버에서 받아온 정보를 폼에 넣기
				$('#memberId').val(response.memberId);
				$('#memberName').val(response.memberName);
				$('#memberEmail').val(response.memberEmail);
				$('#memberPhone').val(response.memberPhone);
				$('#memberGrade').val(response.memberGrade);
				$('#memberDate').val(response.memberDate);
			},
			error : function(error) {
				var errorMessage = error.responseText;
				alert(errorMessage);
			}
		});
	}
	

</script>


</html>