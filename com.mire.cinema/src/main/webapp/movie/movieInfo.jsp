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
.search-container {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
	margin-top: 100px;
}

.search-container input {
	width: 70%;
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
}

.search-container .btn-dark {
	padding: 8px 12px;
	border: 1px solid #343a40;
	border-radius: 4px;
	cursor: pointer;
	background-color: #343a40;
	color: white;
}

.action-buttons {
	display: flex;
	gap: 10px;
}

.action-buttons a {
	text-decoration: none;
}

.action-buttons .btn-dark {
	padding: 8px 12px;
	border: 1px solid #343a40;
	border-radius: 4px;
	cursor: pointer;
	background-color: #343a40;
	color: white;
}

#cinema-list {
	width: 100%;
	margin-top: 20px;
}

#cinema-list th, #cinema-list td {
	text-align: center;
}

#cinema-list th, #cinema-list td {
	font-size: 14px;
	padding: 10px;
}

#paging {
	margin-top: 20px;
}

#paging button {
	padding: 8px 12px;
	margin: 0 2px;
	border: 1px solid #343a40;
	border-radius: 4px;
	cursor: pointer;
	background-color: #343a40;
	color: white;
}

.page-title {
	display: flex;
	align-items: baseline;
}

.page-title h2 {
	margin-bottom: 4px;
}

.page-title p {
	font-size: 14px;
	color: #6c757d;
}
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

			<div>

				<div class="form-group">
					<label class="h6" for="movieTitle">영화제목</label>
					<div class="form-control" id="movieTitle"></div>
				</div>
			</div>
			<div>

				<div class="form-group">
					<label class="h6" for="movieGenre">영화장르</label>
					<div class="form-control" id="movieGenre"></div>
				</div>
			</div>
			<div>

				<div class="form-group">
					<label class="h6" for="movieActors">출연배우</label>
					<div class="form-control" id="movieActors"></div>
				</div>
			</div>
			<div>

				<div class="form-group">
					<label class="h6" for="movieLimit">영화나이제한</label>
					<div class="form-control" id="movieLimit"></div>
				</div>
			</div>
			<div>

				<div class="form-group">
					<label class="h6" for="moviePlayTime">영화상영시간</label>
					<div class="form-control" id="moviePlayTime"></div>
				</div>
			</div>
			<div>

				<div class="form-group">
					<label class="h6" for="movieDate">영화개봉일</label>
					<div class="form-control" id="movieDate"></div>
				</div>
			</div>
			<div>

				<div class="form-group">
					<label class="h6" for="movieIntro">영화소개</label>
					<div class="form-control" id="movieIntro"></div>
				</div>
				<div  class="form-group">
						<label class="h6" for="averageScore" style="font-weight: bold; font-size:20px; margin-top:10px;">평균평점</label>
						<div class="form-control" id="averageScore" style="color:skyblue; font-size:28px;"></div>
					</div>
				</div>
			</div>
		</div>
		<!-- itemTab -->
		<!-- 메인 -->
		<main class="container">

			<div class="search-container">
				
					
				</div>

				<div class="action-buttons">
					<a href="/review/reviewwrite.jsp"><button
							class="btn btn-dark mb-2">리뷰 작성</button></a>
				</div>
			</div>

			<table id="cinema-list" class="table table-bordered">
				<thead>
					<tr>
						<th style="width: 5%;">번호</th>
			
						<th style="width: 5%;">평점</th>
						<th style="width: 60%;">제목</th>
						<th style="width: 10%;">등록일</th>
						<th style="width: 5%;">조회수</th>
					</tr>
				</thead>
				<tbody id="reviewList">
					<!-- 리뷰 목록이 표시될 자리 -->
				</tbody>
			</table>
			<div id="paging" class="d-flex container justify-content-center mt-5">
				<div id="prev" class="mx-4"></div>
				<div id="pageNum"></div>
				<div id="next" class="mx-4"></div>
			</div>
		</main>

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
 document.addEventListener('DOMContentLoaded', function () {
	    const movieNo = localStorage.getItem('movieNo');
	    fetchMovie(movieNo);
	    fetchReviews(movieNo);
	    
	});

	async function fetchMovie(movieNo) {
	    try {
	        const response = await fetch('/movie/' + movieNo);
	        if (!response.ok) {
	            throw new Error('네트워크 응답이 올바르지 않습니다');
	        }
	        const data = await response.json();
	        console.log('영화 데이터:', data);

	        displayMovieInfo(data);

	    } catch (error) {
	        console.error('영화를 불러오는 중 오류 발생:', error.message);
	    }
	}

 function displayMovieInfo(movie) {
     $('#movieImg').html('<img src="../upload/' + movie.imageUuid + '" style="width: 500px; height: 700px; border-right: 1px solid black; margin-right: 30px;">');
     $('#movieTitle').text(movie.movieTitle);
     $('#movieGenre').text(movie.movieGenre);
     $('#movieActors').text(movie.movieActors);
     $('#movieLimit').text(movie.movieLimit + '세');
     $('#moviePlayTime').text(movie.moviePlayTime + '분');
     $('#movieDate').text(movie.movieDate);
     $('#movieIntro').text(movie.movieIntro);
 }

 async function fetchReviews(movieNo) {
	    try {
	        // 리뷰 데이터를 가져오는 API 호출
	        const response = await fetch('/review/list/movie/' + movieNo);
	        
	        // 네트워크 응답이 성공적이지 않은 경우 오류 처리
	        if (!response.ok) {
	            throw new Error('네트워크 응답이 올바르지 않습니다');
	        }

	        // JSON 형식으로 응답 데이터 파싱
	        const data = await response.json();
	        console.log('리뷰 데이터:', data);

	        // 각 리뷰 정보를 로컬 스토리지에 저장
	     

	        // 리뷰 정보를 화면에 표시하는 함수 호출
	        displayReviews(data);

	    } catch (error) {
	        console.error('리뷰를 불러오는 중 오류 발생:', error.message);
	    }
	}


 function displayReviews(reviews) {
	    $('#reviewList').empty();
	    const localStorageMovieNo = localStorage.getItem('movieNo');
	    
	    // 특정 키에 대한 세션 스토리지 값 확인
	    const sessionStorageValue = sessionStorage.getItem('reviewTitle');
	    const localStorageValue = localStorage.getItem('reviewTitle');
		
	    if (sessionStorageValue !== null) {
	        console.log('세션 스토리지에 값이 있습니다:', sessionStorageValue);
	    } else {
	        console.log('세션 스토리지에 값이 없습니다.');
	    }
		console.log(reviews);
	    var score = 0;
	    var memberId = '<%= session.getAttribute("memberId") %>';
		if (reviews.length > 0) {
	        for (const review of reviews) {
	                const reviewInfo =
	                    '<tr>' +
	                    
	                    '<td>' + review.reviewNo + '</td>' +
	                    '<td>' + review.reviewScore + '점' + '</td>' +
	                    '<td><a href="#" onclick="loadItemInfo(' + review.reviewNo + ')" class="review-title" data-review-no=' + review.reviewNo + '>' + review.reviewTitle + '</a></td>' +
	                    '<td>' + review.reviewDate + '</td>' +
	                    '<td>' + review.reviewViews + '</td>' +
	                    '</tr>';
	                $('#reviewList').append(reviewInfo);
	            
	        score =  score + review.reviewScore;
	        }
	        
	        score = score/reviews.length;
	        console.log(score)
	        console.log(memberId)
	        $('#averageScore').text(score.toFixed(1) + '점');
	    } else {
	        console.error('리뷰 목록이 없습니다.');
	    }

	    $(".review-title").on("click", function () {
	        const reviewNo = $(this).data("review-no");
	        sessionStorage.setItem("reviewNo", reviewNo);
	        location.href = "/review/getreview.jsp";
	    });
	}




 function loadItemInfo(reviewNo) {
     $.ajax({
         type: 'GET',
         url: '/review/info/' + reviewNo,
         contentType: 'application/json',
         success: function (response) {
             console.log(response);
             localStorage.setItem('selectedItemNo', reviewNo);
             location.href = '/review/getreview.jsp';
         },
         error: function (error) {
             const errorMessage = error.responseText;
             alert(errorMessage);
         }
     });
 }

 function fetchReview(page, reviewTitle) {
     // 리뷰 목록을 페이지 및 제목에 따라 가져오는 함수 추가
     $.ajax({
         type: 'GET',
         url: '/review/list/movie/' + localStorage.getItem('movieNo') + '?page=' + page + '&reviewTitle=' + reviewTitle,
         contentType: 'application/json',
         success: function (response) {
             console.log(response);
             displayReviews(response.list);
             displayPaging(response.pageMaker);
         },
         error: function (error) {
             const errorMessage = error.responseText;
             alert(errorMessage);
         }
     });
 }

 function loadItemInfo(reviewNo) {
     $.ajax({
         type: 'GET',
         url: '/review/info/' + reviewNo,
         contentType: 'application/json',
         success: function (response) {
             console.log(response);
             localStorage.setItem('selectedItemNo', reviewNo);
             location.href = '/review/getreview.jsp';
         },
         error: function (error) {
             const errorMessage = error.responseText;
             alert(errorMessage);
         }
     });
 }
    </script>
</html>