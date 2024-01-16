<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>MIRE MOVIE</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</head>
<link rel="stylesheet" type="text/css" href="/css/common.css">
<body>
	<!-- 헤더 -->
	<header>
		<%@ include file="../WEB-INF/header.jsp"%>
	</header>
	<!-- 메인 -->
	<div class="container mt-5">
		<div class="row justify-content-center">
			<div class="col-md-6">
				<h1 class="text-center mb-4">영화등록</h1>

				<form id="movie" enctype="application/x-www-form-urlencoded">
					<div class="form-group">
						<label for="movieTitle">영화제목</label> <input type="text"
							class="form-control" id="movieTitle">
					</div>
					<div class="form-group">
						<label for="movieGenre">장르</label> <input type="text"
							class="form-control" id="movieGenre">
					</div>

					<div class="form-group">
						<label for="movieActors">출연배우</label> <input type="text"
							class="form-control" id="movieActors">
					</div>

					<div class="form-group">
						<label for="moviePlayTime">상영시간</label> <input type="text"
							class="form-control" id="moviePlayTime">
					</div>
					<div class="form-group">
						<label for="movieLimit">연령제한</label> <input type="text"
							class="form-control" id="movieLimit">
					</div>

					<div class="form-group">
						<label for="movieIntro">영화소개</label>
						<textarea class="form-control" id="movieIntro"
							style="height: 200px;"></textarea>
					</div>
					<div class="form-group">
						<label for="movieDate">개봉일</label>
						<input type ="date" id ="movieDate">
					</div>
					<div class="form-group">
						<label for="movieImage">대표이미지</label>
						<input type ="file" id ="movieImage">
					</div>

				</form>
				<div class="text-center">
					<button class="bg-dark text-light my-3" type="button"
						onclick="submit()">영화등록</button>
						<a href="/"><button class="bg-dark text-light">홈으로</button></a>
			
			</div>
		</div>
	</div>
	<!-- 푸터-->
	<footer class="container">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>
</body>
<script>
function submit() {
	
	var movieDate = new Date(document.getElementById('movieDate').value);

    var formData = new FormData();
    formData.append('movieTitle', document.getElementById('movieTitle').value);
    formData.append('movieGenre', document.getElementById('movieGenre').value);
    formData.append('movieActors', document.getElementById('movieActors').value);
    formData.append('moviePlayTime', document.getElementById('moviePlayTime').value);
    formData.append('movieLimit', document.getElementById('movieLimit').value);
    formData.append('movieIntro', document.getElementById('movieIntro').value);
    formData.append('movieDate', movieDate);

   
    var fileInput = document.getElementById('movieImage');
    
   
    if (fileInput.files.length > 0) {
        formData.append('file', fileInput.files[0]);
    }

    $.ajax({
        url: '/movie',
        type: 'POST',
        data: formData,
        processData: false, 
        contentType: false,  
        success: function(response) {
            alert(response)
            location.href = "/movie/adminMovieList.jsp";
        },
        error: function(error) {
            alert(error.responseText);
        }
    });
}
</script>
</html>
