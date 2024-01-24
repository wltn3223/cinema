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
<link rel="stylesheet" type="text/css" href="/css/common.css">
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
	width: calc(25% - 20px); /* 변경된 부분 */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	text-align: left;
}

.movie-card img {
	max-width: 100%;
	width: 100%;
	height: 400px;
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

			<div class="search-container">
				<div style="display: flex; align-items: center;">
					<div style="margin-right: 10px;">영화검색</div>
					<input type="text" placeholder="영화제목으로 검색하세요" id="movieTitle"
						style="width: 300px; margin-right: 10px;">
					<div class="btn btn-dark"
						onclick="fetchMovies(1, document.getElementById('movieTitle').value)">검색</div>
				</div>


				<div class="movie-container d-flex justify-content-between"
					id="movieContainer"></div>

				<div id="paging"
					class="d-flex container justify-content-center mt-5">
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
	fetchMovies(1); 
});

function fetchMovies(pageNum,movieTitle) {
	
	
	var url = (movieTitle === null || movieTitle === '' || movieTitle === undefined)?
			'/movie/list/' + pageNum:'/movie/list/' + pageNum +'/movie/' +movieTitle;
	console.log(url);
    fetch(url, {
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
           
            let movies = (data.list === undefined)?data.searchList:data.list;
            let paginationData = data.page;
            createPaginationButtons(paginationData.beginPage, paginationData.endPage, paginationData.prev, paginationData.next,data);
            displayMovies(movies);

        })
        .catch(error => {
            console.error('Fetch error:', error.message);
        });
}

function displayMovies(movies) {

    $('#movieContainer').empty();

    for (var movie of movies) {
    
			let movieCard = 
			    '<div class="movie-card" onclick="getMovie(' + movie.movieNo + ')" style="cursor:pointer; display: flex; flex-direction: column;">' +
			        '<img src="../upload/' + movie.imageUuid + '">' +
			        '<div class="d-flex align-items-center ">' + 
			            '<div class="p-2 rounded bg-dark" style="font-size: 17px; color:white;">' + movie.movieLimit + '</div>' +
			            '<h4>제목:' + movie.movieTitle + '</h4>' +
			        '</div>' +
			        '<div style="font-size: 16px;">개봉일: ' + movie.movieDate + '</div>' +
			        '<button class="btn btn-secondary mt-auto" onclick="reserveMovie(' + movie.movieNo + ')">예매</button>' +
			    '</div>';
			    
			$('#movieContainer').append(movieCard);
    }
}

function createPaginationButtons(begin, end, prev, next,data) {
    let prevPage = begin - 1;
    let nextPage = end + 1
    $('#pageNum').empty();
    
    if(data.list !== undefined){
   	 	$('#prev').html(prev ? '<button onclick="fetchMovies(' + prevPage + ')">이전</button>' : '');
    	$('#next').html(next ? '<button onclick="fetchMovies(' + nextPage + ')">다음</button>' : '');
    	  for (let i = begin; i <= end; i++) {
    	        $('#pageNum').append('<button onclick="fetchMovies(' + i + ')" class="mx-2">' + i + '</button>');
    	    }
    }
    else{	
    	console.log(data.keyword);
    		$('#prev').html(prev ? '<button onclick="fetchMovies(' + prevPage + ', \'' + data.keyword + '\')">이전</button>' : '');
    		$('#next').html(next ? '<button onclick="fetchMovies(' + nextPage + ', \'' + data.keyword + '\')">다음</button>' : '');
    		 for (let i = begin; i <= end; i++) {
    		        $('#pageNum').append('<button onclick="fetchMovies(' + i + ', \'' + data.keyword + '\')"lass="mx-2">' + i + '</button>');
    		    }
    }
   
   
}
function getMovie(movieNo){
	console.log(movieNo);
	localStorage.setItem('movieNo',movieNo);
	location.href = '/movie/adminMovieInfo.jsp';
};


</script>


</html>