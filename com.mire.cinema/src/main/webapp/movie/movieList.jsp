<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<title>MIRE MOVIE</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.tab p {
	font-size: 30px;
	color: black;
}

.tabnav {
	list-style: none;
	padding: 0;
	display: flex;
	margin-top: 10px;
}

.tabnav li {
	margin-right: 20px;
}

.movie-container {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-around;
}

.movie-card {
    border: 1px solid #ccc;
    border-radius: 8px;
    margin: 10px;
    padding: 15px;
    width: calc(33.33% - 20px); /* 변경된 부분 */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    text-align: left;
}

.movie-card img {
	max-width: 100%;
	height: auto;
	border-radius: 8px;
	margin-bottom: 10px;
}

#movieContainer>a {
	display: block;
	width: 28%;
	height: 300px;
	margin-bottom: 20px;
}

a {
	text-decoration: none;
}

#prev>button {
	border: none;
	font-size: 30px;
	background-color: white;
}

#pageNum>button {
	border: none;
	font-size: 30px;
	background-color: white;
}

#pageNum>button:active {
	color: red;
}

#next>button {
	border: none;
	font-size: 30px;
	background-color: white;
}
</style>
</head>

<body>
	<header>
		<%@ include file="../WEB-INF/header.jsp"%>
	</header>

	<div class="container">
		<div class="tab">
			<p>영화목록</p>
			<ul class="tabnav">
				<li><a href="#tab01">장르별</a></li>
				<li><a href="#tab02">인기순</a></li>
			</ul>

			<div class="movie-container d-flex justify-content-between"
				id="movieContainer">
				<!-- Data will be appended here using JavaScript -->
			</div>

			<div id="paging" class="d-flex container justify-content-center mt-5">
				<div id="prev" class="mx-4"></div>
				<div id="pageNum"></div>
				<div id="next" class="mx-4"></div>
			</div>
		</div>
	</div>

	<footer class="py-3 my-4">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>


</body>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
        document.addEventListener('DOMContentLoaded', function () {
            fetchMovies(1); // Initial fetch with page 1
        });

        function fetchMovies(pageNum) {
            fetch('/movie/list?pageNum=' + pageNum, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                },
            })
                .then(response => {
                    if (!response.ok) {
                        return response.json().then(errorData => {
                            alert("서버내부 오류: " + errorData.message);
                            throw new Error('Server error');
                        });
                    }
                    return response.json();
                })
                .then(data => {
                    console.log(data.page)
                    let movies = data.list;
                    let paginationData = data.page;
                    createPaginationButtons(paginationData.beginPage, paginationData.endPage, paginationData.prev, paginationData.next);
                    displayMovies(movies);
     
                })
                .catch(error => {
                    console.error('Fetch error:', error.message);
                });
        }

        function displayMovies(movies) {
            console.log('Received movies:', movies); // Log received movies to the console

            $('#movieContainer').empty();
			
          
            for (var movie of movies) {
            	console.log(movie.length)
            
                let movieCard = '<div class="movie-card">' +
                    '<h3>' + movie.movieNo + '</h3>' +
                    '<p>' + movie.movieTitle + '</p>' +
                    '<p>Genre: ' + movie.movieGenre + '</p>' +
                    '</div>';
                $('#movieContainer').append(movieCard);
                
            }
            
        }
        function createPaginationButtons(begin, end, prev, next) {
            let prevPage = begin - 1;
            let nextPage = end + 1
            $('#prev').html(prev ? '<button onclick="fetchMovies(' + prevPage + ')">이전</button>' : '');
            $('#next').html(next ? '<button onclick="fetchMovies(' + nextPage + ')">다음</button>' : '');

            $('#pageNum').empty();
            for (let i = begin; i <= end; i++) {
                $('#pageNum').append('<button onclick="fetchMovies(' + i + ')" class="mx-2">' + i + '</button>');
            }
        }
    </script>


</html>