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
        <%@ include file="../WEB-INF/header.jsp" %>
    </header>

    <!-- itemTab -->
    <div style="display: flex; justify-content: space-between; align-items: center;" class="container">
        <table>
            <tbody>

                <tr>
                    <td colspan="2" style="font-weight: 500; font-size: 25px;" id="itemName"></td>
                </tr>
                <tr>
                    <td colspan="2" id="itemSize"></td>
                </tr>

                <tr style="border-top: 1px solid black;">
                    <td rowspan="8" id="movieImg"><img src="/img/item02.PNG"
                            style="width: 500px; height: 700px; border-right: 1px solid black; margin-right: 30px;">
                    </td>
                </tr>

                <tr>
                    <td>영화제목</td>
                    <td id="movieTitle">모든 지점</td>
                </tr>
                <tr>
                    <td >영화장르</td>

                    <td id="movieGenre"></td>
                </tr>
                <tr>
                    <td>출연배우</td>

                    <td id="movieActors"></td>
                </tr>
      
                <tr>
                    <td>영화나이제한</td>

                    <td id="movieLimit"></td>
                </tr>
                <tr>
                    <td>영화상영시간</td>

                    <td id="moviePlayTime"></td>
                </tr>
                <tr>
                    <td>영화개봉일</td>

                    <td id="movieDate"></td>
                </tr>
                <tr>
                    <td>영화소개</td>

                    <td id="movieIntro"></td>
                </tr>
              
             
            </tbody>
        </table>
        
    </div>
    <div class="container mt-4">
        <a href="/movie/adminMovieInfoEdit.jsp"><button>수정하기</button></a>
        <button onclick="remove()">삭제하기</button>
        
        </div>
    <!-- itemTab -->

    <!-- 푸터-->
    <footer class="py-3 my-4">
        <%@ include file="../WEB-INF/footer.jsp" %>
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
	    const response = await fetch('/movie/'+ movieNo);
	
	    const data = await response.json();
	    console.log(data);
	    $('#movieImg').html('<img src="../upload/' + data.imageUuid + '" style="width: 500px; height: 700px; border-right: 1px solid black; margin-right: 30px;">');
	    $('#movieTitle').text(data.movieTitle);
	     $('#movieGenre').text(data.movieGenre);
	     $('#movieActors').text(data.movieActors);
	     $('#movieLimit').text(data.movieLimit + '세');
	     $('#moviePlayTime').text(data.moviePlayTime + '분');
	     $('#movieDate').text(data.movieDate);
	     $('#movieIntro').text(data.movieIntro);

	   
	  } catch (error) {
	    
	    console.error('Error fetching data:', error.message);
	  }
	}
async function remove() {
    try {
        // Prompt the user for confirmation
        const userConfirmed = window.confirm('정말 이영화를 삭제하시겠습니까?');

        if (!userConfirmed) {
            alert("다시시도해주세요");
            return;
        }

        let movieNo = localStorage.getItem('movieNo');

        const response = await fetch('/movie/' + movieNo, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json',
            },
        
        });

        if (response.ok) {
          
            const responseText = await response.text();
            alert(responseText); 
            location.href = "/movie/movieList.jsp";
        } else {
            console.error('Failed to delete movie');
        }
    } catch (error) {
       
        alert(error.message);
    }
}


</script>
</html>