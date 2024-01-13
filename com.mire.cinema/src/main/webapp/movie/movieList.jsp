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

.movie {
	box-sizing: border-box;
	text-align: center;
	background-color: #ffffff;
	padding: 10px;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	height: 100%;
}

.movie img {
	max-width: 80%;
	height: 80%;
	margin-bottom: 10px;
	border-radius: 8px;
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



		</div>
	</div>

	<footer class="py-3 my-4">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>

	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script>
	document.addEventListener('DOMContentLoaded', function () {
		  fetch('/movie/list', {
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
		      alert(JSON.stringify(data));
		      console.log(JSON.stringify(data));
		    })
		    .catch(error => {
		      console.error('Fetch error:', error.message);
		    });
		});
	
		
	</script>
</body>



</html>