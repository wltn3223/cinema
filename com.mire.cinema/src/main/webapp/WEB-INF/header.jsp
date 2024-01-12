<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>미래영화관</title>
</head>
<body>
	<!-- 헤더 -->
	<div class="container">
		<header class="border-bottom lh-1 py-3">
			<div
				class="row flex-nowrap justify-content-between align-items-center">
				<div class="col-4 pt-1"></div>
				<div class="col-4 text-center">
					<a
						class="blog-header-logo text-body-emphasis text-decoration-none text-dark"
						href="/"><h2>MIRE MOVIE</h2></a>
				</div>
				<div class="col-4 d-flex justify-content-end align-items-center">
					<c:if test="${memberId eq null}">
						<a class="btn btn-sm btn-outline-secondary" href="/login.html">로그인</a>
                        &nbsp;
                        <a class="btn btn-sm btn-outline-secondary"
							href="/join.html">회원가입</a>
					</c:if>
					<c:if test="${memberId ne null}">
						<div>
							<span> ${memberId}님 환영합니다. </span>
							<button onclick="logout()" class="text-dark btn border">로그아웃

							</button>
						</div>
					</c:if>
				</div>
			</div>
		</header>
	</div>

	<div class="nav-scroller py-1 mb-3 border-bottom border-top bg-dark">
		<nav class="nav nav-underline  container text-center">
			<ul class="nav container-fluid justify-content-between">
				<li class="nav-item dropdown mx-2"><a
					class="nav-link text-light" href="#" role="button"
					data-bs-toggle="dropdown">영화</a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="#">전체영화</a></li>
						<li><a class="dropdown-item" href="#">큐레이션</a></li>
						<li><a class="dropdown-item" href="#">무비포스트</a></li>
					</ul></li>
				<li class="nav-item dropdown mx-2"><a
					class="nav-link text-light" href="#" role="button"
					data-bs-toggle="dropdown">예매</a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="#">영화예매</a></li>
						<li><a class="dropdown-item" href="#">영화예매내역</a></li>
						<li><a class="dropdown-item" href="#">영화예매취소</a></li>
					</ul></li>
				<li class="nav-item dropdown mx-2"><a
					class="nav-link text-light" href="/itemgiftcard/itemlist.jsp"
					role="button" data-bs-toggle="dropdown">상품</a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item"
							href="/itemgiftcard/itemlist.jsp">상품목록</a></li>
					</ul></li>
				<li class="nav-item dropdown"><a class="nav-link text-light"
					href="#" role="button" data-bs-toggle="dropdown">공지사항</a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="/notice/noticelist.jsp">공지사항</a></li>
						<li><a class="dropdown-item" href="#">공지사항글 작성</a></li>
						<li><a class="dropdown-item" href="#">이벤트</a></li>
					</ul></li>
				<li class="nav-item dropdown mx-2"><a
					class="nav-link text-light" href="#" role="button"
					data-bs-toggle="dropdown">고객센터</a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="#">문의내역등록</a></li>
						<li><a class="dropdown-item" href="#">문의내역조회</a></li>
						<li><a class="dropdown-item" href="#"></a></li>
					</ul></li>
				<li class="nav-item dropdown mx-2"><a
					class="nav-link text-light" href="#" role="button"
					data-bs-toggle="dropdown">My</a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="../member/memberInfo.jsp">회원
								정보 조회</a></li>
						<li><a class="dropdown-item" href="#"></a></li>
					</ul></li>
			</ul>
		</nav>
	</div>

	<!-- 추가 스크립트 -->
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script>
		function logout() {
			$.ajax({
				type : "POST",
				url : "/member/logout",
				contentType : "application/json",
				success : function() {
					location.href = "/index.jsp";

				},
				error : function(error) {
					// 에러가 발생했을 때의 처리
					var result = error.responseText;
					alert(result);
				}
			});
		}
	</script>
</body>
</html>