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
		<div style="flex: 0 0 auto;" id="movieImg"></div>
		<div style="flex: 1;">
			<div style="font-weight: 500; font-size: 25px;" id="itemName">영화
				정보</div>
			<div id="itemSize"></div>
			<form id="editForm" enctype="multipart/form-data" action="/item/update" method="post">
    <div>
        <div class="form-group">
            <label class="h6" for="movieNo">영화번호</label>
            <input type="text" class="form-control" id="movieNo" name="movieNo">
        </div>
    
        <div class="form-group">
            <label class="h6" for="movieTitle">영화제목</label>
            <input type="text" class="form-control" id="movieTitle" name="movieTitle">
        </div>
    </div>
    <div>
        <div class="form-group">
            <label class="h6" for="movieGenre">영화장르</label>
            <input type="text" class="form-control" id="movieGenre" name="movieGenre">
        </div>
    </div>
    <div>
        <div class="form-group">
            <label class="h6" for="movieActors">출연배우</label>
            <input type="text" class="form-control" id="movieActors" name="movieActors">
        </div>
    </div>
    <div>
        <div class="form-group">
            <label class="h6" for="movieLimit">영화나이제한</label>
            <input type="text" class="form-control" id="movieLimit" name="movieLimit">
        </div>
    </div>
    <div>
        <div class="form-group">
            <label class="h6" for="moviePlayTime">영화상영시간</label>
            <input type="text" class="form-control" id="moviePlayTime" name="moviePlayTime">
        </div>
    </div>
    <div>
        <div class="form-group">
            <label class="h6" for="movieDate">영화개봉일</label>
            <input type="text" class="form-control" id="movieDate" name="movieDate">
        </div>
    </div>
    <div>
        <div class="form-group">
            <label class="h6" for="movieIntro">영화소개</label>
            <input type="text" class="form-control" id="movieIntro" name="movieIntro">
        </div>
    </div>
    <div class="form-group">
        <label class="h6" for="file">파일등록</label>
        <input type="file" class="form-control-file" id="file" name="file">
    </div>
</form>
		</div>
	</div>

	<div class="container d-flex justify-content-center mt-3">
		<div class="input-group">
			<button class="btn btn-primary" onclick="updateInfo()">영화수정</button>
			<button class="btn btn-secondary ms-2" onclick="goBack()"
			type="button">뒤로가기</button>
		</div>
	</div>

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

			const data = await
			response.json();
			console.log(data);
			console.log(data.responsetext)
			$('#movieImg')
					.html(
							'<img src="../upload/' + data.imageUuid + '" style="width: 500px; height: 700px; border-right: 1px solid black; margin-right: 30px;">');
			
			$('#movieNo').val(data.movieNo);
			$('#movieTitle').val(data.movieTitle);
			$('#movieGenre').val(data.movieGenre);
			$('#movieActors').val(data.movieActors);
			$('#movieLimit').val(data.movieLimit + '세');
			$('#moviePlayTime').val(data.moviePlayTime + '분');
			$('#movieDate').val(data.movieDate);
			$('#movieIntro').val(data.movieIntro);

		} catch (error) {
			alert(error);

		}
	}
	function updateInfo() {
		
		

		// FormData를 사용하여 파일을 추가
		var formData = new FormData(document.getElementById('editForm'));


		var confirmUpdate = confirm("수정하시겠습니까?");

		if (confirmUpdate) {
			// FormData를 사용하여 파일을 전송
			$.ajax({
				type : "POST",
				url : "/movie/update",
				processData : false,
				contentType : false,
				data : formData,
				success : function(response) {
					console.log("수정 성공:", response);
					alert("상품이 수정되었습니다.");

					// 수정 후 로컬 스토리지에서 선택한 상품 정보 삭제
					localStorage.removeItem('movieNo');

					location.href = "/movie/adminMovieList.jsp";
				},
				error : function(error) {
					var errorMessage = error.responseText;
					alert(errorMessage);
				}
			});
		} else {
			// 사용자가 수정을 취소한 경우
			alert("상품 수정이 취소되었습니다.");
		}
	}

	function goBack() {
		location.href = '/movie/adminMovieList.jsp';
	}
</script>
</html>