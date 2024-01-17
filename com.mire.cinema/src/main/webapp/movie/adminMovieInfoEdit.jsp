<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>영화정보</title>
<link rel="stylesheet" type="text/css" href="/css/common.css">
</head>
<style>
</style>
</head>

<body>
	<!-- 헤더 -->
	<header>
		<%@ include file="../WEB-INF/header.jsp"%>
	</header>

	<!-- itemTab -->
	<div
		style="display: flex; justify-content: space-between; align-items: center;"
		class="container">
		<form enctype="multipart/form-data" action="/movie/update" method="post">
			<table class="container-fluid">

				<tbody>


					<tr style="border-top: 1px solid black;">
						<td rowspan="8" id="movieImg" class="w-50">
						</td>
					</tr>
					<tr>
						<td>영화번호</td>
						<td id="movieNo"><input type="text" class="form-control"
							placeholder="수정할 내용을 입력하세요" name="movieNo" readonly></td>
					</tr>

					<tr>
						<td>영화제목</td>
						<td id="movieTitle"><input type="text" class="form-control"
							placeholder="수정할 내용을 입력하세요" name="movieTitle"></td>
					</tr>
					<tr>
						<td>영화장르</td>

						<td id="movieGenre"><input type="text" class="form-control"
							placeholder="수정할 내용을 입력하세요" name="movieGenre"></td>
					</tr>
					<tr>
						<td>출연배우</td>

						<td id="movieActors"><input type="text" class="form-control"
							placeholder="수정할 내용을 입력하세요" name="movieActors"></td>
					</tr>

					<tr>
						<td>영화나이제한</td>

						<td id="movieLimit"><input type="text" class="form-control"
							placeholder="수정할 내용을 입력하세요(숫자입력)" name="movieLimit"></td>
					</tr>
					<tr>
						<td>영화상영시간</td>

						<td id="moviePlayTime"><input type="text"
							class="form-control" placeholder="수정할 내용을 입력하세요(숫자만입력)" name="moviePlayTime"></td>
					</tr>

					<tr>
						<td>영화소개</td>

						<td id="movieIntro"><textarea class="form-control"
								placeholder="수정할 내용을 입력하세요" name="movieIntro"></textarea></td>
					</tr>
					<tr>
						<td>수정할 이미지 등록: <input type="file" id="file" name="file"></td>

					</tr>

				</tbody>
			</table>
			<div class="container d-flex justify-content-center mt-3 ">
				<button>영화수정</button>
				<button onclick="goback()" type="button">뒤로가기</button>
			</div>
		</form>
	</div>
	<!-- itemTab -->

	<!-- 푸터-->
	<footer class="py-3 my-4">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>
</body>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


<script>
	$(document).ready(function() {

		getMovie();
	});

	async function getMovie() {
		try {
			let movieNo = localStorage.getItem('movieNo');
			const response = await
			fetch('/movie/' + movieNo);

			const data = await response.json();
			console.log(data);
			console.log(data.responsetext)
			$('#movieImg')
					.html(
							'<img src="../upload/' + data.imageUuid + '"class="w-100" style=" height: 700px; border-right: 1px solid black; margin-right: 30px;">');
			
			$('#movieNo input').val(data.movieNo);
			$('#movieTitle input').val(data.movieTitle);
			$('#movieGenre input').val(data.movieGenre);
			$('#movieActors input').val(data.movieActors);
			$('#movieLimit input').val(data.movieLimit);
			$('#moviePlayTime input').val(data.moviePlayTime);
			$('#movieIntro input').val(data.movieIntro);

		} catch (error) {
			alert(error);
			
		}
	}
	


</script>
</html>