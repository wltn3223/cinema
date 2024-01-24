<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>MIRE MOVIE</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
.dropdown:hover .dropdown-menu {
	display: block;
	margin-top: 0;
}

.nav-link {
	color: white;
}
</style>
</head>
<body>
	<!-- 헤더 -->
	<header>
		<%@ include file="../WEB-INF/header.jsp"%>
	</header>
	<!-- 메인 -->
	<main class="container mt-3">
		<div class="container">
			<h2>영화스케줄</h2>
			<br> <a href="/movieschedule/scheduleinsert.jsp"
				class="btn btn-dark mb-2">스케줄 추가</a> <a
				href="/movieschedule/schedulemodify.jsp" class="btn btn-dark mb-2">스케줄 수정</a>
			<a href="/movieschedule/removeschedule.jsp" class="btn btn-dark mb-2">스케줄
				삭제</a>
		</div>
		<div class="search-container">
			<div style="display: flex; align-items: center;">
				<div style="margin-right: 10px;">스케줄 검색</div>
				<input type="text" placeholder="일련번호로 검색하세요" id="scheduleNo"
					style="width: 300px; margin-right: 10px;">
				<div class="btn btn-dark"
					onclick="fetchSchedule(1, document.getElementById('scheduleNo').value)">검색</div>
			</div>
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>일련번호</th>
						<th>상영관</th>
						<th>영화</th>
						<th>영화상영시간</th>
						<th>영화상영종료시간</th>
						<th>상영관 총 좌석</th>
						
					</tr>
				</thead>
				<tbody id="scheduleList">
				</tbody>
			</table>
			<div id="paging" class="d-flex container justify-content-center mt-5">
				<div id="prev" class="mx-4"></div>
				<div id="pageNum"></div>
				<div id="next" class="mx-4"></div>
			</div>
		</div>
	</main>
	<!-- 푸터-->
	<footer class="container">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>

	<script>
    document.addEventListener('DOMContentLoaded', function () {
    	fetchSchedule(1);
    	localStorage.clear();
	});

	function fetchSchedule(pageNum, scheduleNo) {
	    var url = (scheduleNo === 0 || scheduleNo === '' || scheduleNo === undefined) ?
	        '/movieschedule/list/' + pageNum : '/movieschedule/list/' + pageNum + '/movieschedule/' + scheduleNo;
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
	                    throw new Error('서버 오류');
	                });
	            }
	            return response.json();
	        })
	        .then(data => {
	            let schedules = (data.list === undefined) ? data.searchList : data.list;
	            let paginationData = data.page;
	            createPaginationButtons(paginationData.beginPage, paginationData.endPage, paginationData.prev, paginationData.next, data);
	            displaySchedules(schedules);
	        })
	        .catch(error => {
	            console.error('Fetch 오류:', error.message);
	        });
	}
	function displaySchedules(schedules) {
	    $('#scheduleList').empty();

	    for (var movieSchedule of schedules) {
	        let scheduleInfo =
	            '<tr>' +
	            '<td>' + movieSchedule.scheduleNo + '</td>' +
	            '<td>' + movieSchedule.screenNo + '</td>' +
	            '<td>' + movieSchedule.movieNo + '</td>' +
	            '<td>' + movieSchedule.scheduleStartTime + '</td>' +
	            '<td>' + movieSchedule.scheduleFinishTime + '</td>' +
	            '<td>' + movieSchedule.screenTotalSeat + '</td>' +
	            '</tr>';

	        $('#scheduleList').append(scheduleInfo);
	    }
	}
        
        function createPaginationButtons(begin, end, prev, next, data) {
    	    let prevPage = begin - 1;
    	    let nextPage = end + 1;
    	    $('#pageNum').empty();

    	    if (data.list !== undefined) {
    	        $('#prev').html(prev ? '<button onclick="fetchSchedule(' + prevPage + ')">이전</button>' : '');
    	        $('#next').html(next ? '<button onclick="fetchSchdule(' + nextPage + ')">다음</button>' : '');
    	        for (let i = begin; i <= end; i++) {
    	            $('#pageNum').append('<button onclick="fetchSchedule(' + i + ')" class="mx-2">' + i + '</button>');
    	        }
    	    } else {
    	        $('#prev').html(prev ? '<button onclick="fetchSchedule(' + prevPage + ', \'' + data.keyword + '\')">이전</button>' : '');
    	        $('#next').html(next ? '<button onclick="fetchSchedule(' + nextPage + ', \'' + data.keyword + '\')">다음</button>' : '');
    	        for (let i = begin; i <= end; i++) {
    	            $('#pageNum').append('<button onclick="fetchSchedule(' + i + ', \'' + data.keyword + '\')" class="mx-2">' + i + '</button>');
    	        }
    	    }
    	}
    </script>
</body>
</html>
