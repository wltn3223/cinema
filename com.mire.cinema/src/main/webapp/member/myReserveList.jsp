<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyBatis 게시판 - 영화관 리스트</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
.nav-link {
	color: white;
}
</style>
</head>
<body>
	<header>
		<%@ include file="../WEB-INF/header.jsp"%>
	</header>
	<div class="container mt-5">
	<div class= "container-fluid  d-flex justify-content-between">
		<h2 class="mb-4">내 예매 내역</h2>
	
		</div>
		<table id="cinema-list" class="table table-striped container">
			<thead>
				<tr>
					<th>예매번호</th>
					<th>회원아이디</th>
					<th>영화제목</th>
					<th>시작 시간</th>
					<th>종료 시간</th>
					<th>위치</th>
					<th>좌석번호</th>
				</tr>
			</thead>
			<tbody id= "orderList">
			</tbody>
		</table>

		<div id="paging" class="d-flex container justify-content-center mt-5">
			<div id="prev" class="mx-4"></div>
			<div id="pageNum"></div>
			<div id="next" class="mx-4"></div>
		</div>
	</div>


	<footer class="container mt-5">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>
</body>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
document.addEventListener('DOMContentLoaded', function () {
   	var memberId = '${memberId}';
    fetchMembers(1,memberId); // Initial fetch with page 1
});

function fetchMembers(pageNum,memberId) {
	
	
	var url =  '/pay/list/reserve/' + pageNum + '/' +memberId;
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
           
            console.log(data.list);

            console.log(data.page);
          
            let orders = data.list;
            let paginationData = data.page;
            createPaginationButtons(paginationData.beginPage, paginationData.endPage, paginationData.prev, paginationData.next,data);
            displayMovies(orders);

        })
        .catch(error => {
            console.error('Fetch error:', error.message);
        });
}

function displayMovies(reserves) {
   
    $('#orderList').empty();
	
  
    for (var reserve of reserves) {
    
        let reserveInfo = 
        	
        	
        	'<tr>' +
            '<td>' + reserve.orderId + '</td>' +
            '<td>' + reserve.memberId + '</td>' +
            '<td>' + reserve.movieTitle + '</td>' +
            '<td>' + reserve.scheduleStartTime + '</td>' +
            '<td>' + reserve.scheduleStartTime + '</td>' +
            '<td>' + reserve.screenFloor + reserve.screenHall + '</td>' +
            '<td>' + reserve.seatNo + '</td>' +
           
            '<td>' + '<div class="btn btn-dark" onclick="cancel(\'' + reserve.orderId + '\')">주문취소</div></td>' +
        '</tr>';
           
        $('#orderList').append(reserveInfo);
        
    }
    
}
async function cancel(id) {
	console.log(id);
	var check = confirm('취소하시겠습니까?');
	if(check){
    var url = '/pay/reserve/' + id;
    const response = await fetch(url, {
        method: "DELETE", // Corrected method name
        location.reload(true);
    });

    console.log(response);
	}
}
 
 
 
function createPaginationButtons(begin, end, prev, next,data) {
    let prevPage = begin - 1;
    let nextPage = end + 1
    $('#pageNum').empty();
    
    if(data.list !== undefined){
   	 	$('#prev').html(prev ? '<button onclick="fetchMembers(' + prevPage + ')">이전</button>' : '');
    	$('#next').html(next ? '<button onclick="fetchMembers(' + nextPage + ')">다음</button>' : '');
    	  for (let i = begin; i <= end; i++) {
    	        $('#pageNum').append('<button onclick="fetchMembers(' + i + ')" class="mx-2">' + i + '</button>');
    	    }
    }
    else{	
    	console.log(data.keyword);
    		$('#prev').html(prev ? '<button onclick="fetchMembers(' + prevPage + ', \'' + data.keyword + '\')">이전</button>' : '');
    		$('#next').html(next ? '<button onclick="fetchMembers(' + nextPage + ', \'' + data.keyword + '\')">다음</button>' : '');
    		 for (let i = begin; i <= end; i++) {
    		        $('#pageNum').append('<button onclick="fetchMembers(' + i + ', \'' + data.keyword + '\')"lass="mx-2">' + i + '</button>');
    		    }
    }
   
    
   
   
}
</script>
</html>