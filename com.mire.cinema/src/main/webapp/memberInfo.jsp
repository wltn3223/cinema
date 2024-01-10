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
</head>

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
							class="form-control" id="memberId" readonly="readonly"
							value="${member.memberId}">
					</div>
					<div class="form-group">
						<label for="memberName">이름</label> <input type="text"
							class="form-control" id="memberName" readonly="readonly"
							value="${member.memberName}">
					</div>
					<div class="form-group">
						<label for="memberEmail">이메일</label> <input type="email"
							class="form-control" id="memberEmail" readonly="readonly"
							value="${member.memberEmail}">
					</div>
					<div class="form-group">
						<label for="memberPhone">전화번호</label> <input type="tel"
							class="form-control" id="memberPhone" readonly="readonly"
							value="${member.memberPhone}">
					</div>
					<div class="form-group">
						<label for="memberPhone">가입일</label> <input type="tel"
							class="form-control" id="memberPhone" readonly="readonly"
							value="${member.memberDate}">
					</div>
					<div class="d-flex justify-content-center">
						<div class="text-center">
							<button class="btn btn-light bg-dark" type="button">
								<a href="/member/editForm/${member.memberId}" class="text-light">정보수정</a>
							</button>
						</div>
						<div class="text-center">
							<a href="/index.jsp"><button class="btn btn-light bg-dark text-light" type="button">
								홈으로
							</button></a>
						</div>
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
</html>