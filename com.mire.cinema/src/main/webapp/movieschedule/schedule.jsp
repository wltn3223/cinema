<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/reserve.css">
<link rel="stylesheet" href="css/header.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel='stylesheet'
	href='//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css' />
<script
	src='//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js'></script>
<link rel="stylesheet"
	href="fonts/material-design-iconic-font/css/material-design-iconic-font.min.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
* {
	font-size: 11px;
}

body {
	background-color: #FDFCF0;
}

/* header */
.header-nav-wrapper {
	background: url(../images/bg_header.gif) repeat-x 0 0;
	background-position: center;
	background-size: contain;
	height: 120px;
	padding-top: 4px;
}

.header-nav-container {
	position: fixed;
}

.header {
	display: flex;
	justify-content: space-between;
	padding-left: 40px;
	padding-right: 150px;
}

.header-inner {
	display: flex;
}

.header-inner>div {
	border-right: 1px solid #DDDDDD;
	margin-left: 8px;
	padding-right: 4px;
}

/* //header */

/* nav */
.nav-line {
	background-color: red;
	border-radius: 50px;
	height: 5px;
	/* background-image: linear-gradient(to right, white 33%, rgba(255, 255, 255, 0) 0%);
  background-position: bottom;
  background-size: 15px 1px;
  background-repeat: repeat-x; */
}

.nav-wrapper {
	/* background: url(../images/bg_header.gif) repeat-x 0 0; */
	/* width: 100%;*/
	height: 94px;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.nav-content {
	padding-top: 15px;
}

.movieLogo-wrapper {
	text-align: center;
}

.cgvLogo {
	width: 120px;
	margin-left: 150px;
	/* margin-right: -40px; */
}

.cgvMovie {
	width: auto;
	height: 28px;
}

.nav-inner {
	display: flex;
	/* margin-left: -250px; */
	margin-left: 150px;
	margin-right: auto;
	align-items: center;
	padding-bottom: 15px;
}

.nav-inner>div>button {
	padding-top: 5px;
	font-size: 14px;
	font-weight: bold;
	margin-left: 15px;
}

.search-wrapper {
	margin-left: 70px;
	height: 20px;
}

.search-wrapper>input {
	width: 100px;
	height: 20px;
}

.searchButton {
	margin: 0 !important;
	padding: 2px !important;
	background-color: red;
	color: white;
	width: 30px;
	height: 100%;
	font-size: 10px !important;
}

/* content */
.reserve-container {
	margin-top: 20px;
	display: flex;
	justify-content: center;
	height: 800px;
	/* border: 1px solid #dddddd; */
}

.reserve-container>div {
	border: 1px solid #dddddd;
}

.reserve-title {
	border-bottom: 1px solid #dddddd;
	background-color: #444444;
	text-align: center;
	color: #dddddd;
	padding: 5px;
	font-size: 13px;
	font-weight: bold;
}

.movie-part {
	width: 284px;
}

.theater-part {
	width: 264px;
}

.day-part {
	width: 91px;
}

.time-part {
	width: 384px;
}

.sort-wrapper {
	margin: 10px 6px 6px 10px;
	/* padding: 3px; */
	display: flex;
	border-bottom: 1px solid #dddddd;
	font-size: 12px;
}

.sort-wrapper>div {
	padding: 3px;
}

.sort-wrapper>div:hover {
	border-bottom: 1px solid #111111;
}

.sort-selected {
	font-weight: bold;
	border-bottom: 1px solid #111111;
}

.sort-korean {
	margin-left: 6px;
}

.reserve-date {
	padding-top: 5px;
	display: flex;
	flex-direction: column;
	align-items: center;
	height: 770px;
	overflow: scroll;
	overflow-x: hidden;
}

.movie-date-wrapper {
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 5px 2px;
}

.movie-week-of-day {
	margin-left: 5px;
	font-size: 10px;
	width: 12px;
	height: 22px;
	line-height: 22px;
}

.movie-day {
	text-align: center;
	width: 34px;
	height: 22px;
	font-size: 17px;
	font-weight: bold;
}

.saturday {
	color: #31597E;
	font-weight: bold;
}

.sunday {
	color: #AF2D2D;
	font-weight: bold;
}

.movie-date-wrapper-active {
	background-color: #333333;
}

.movie-date-wrapper-active>* {
	color: white;
}

#scheduleTable {
	max-height: 400px; /* 스크롤 최대 높이 지정 */
	overflow-y: auto; /* 세로 스크롤이 나타나도록 설정 */
}

.list-group-item {
	display: flex;
	flex-direction: column;
	justify-content: center;
	margin-bottom: 10px; /* 리스트 간 간격 지정 */
}

.reserve-date {
	padding-top: 5px;
	display: flex;
	flex-direction: column;
	align-items: center;
	height: 770px;
	overflow-y: auto; /* 세로 스크롤이 나타나도록 설정 */
	overflow-x: hidden;
}

#scheduleTable {
	max-height: 400px;
	overflow-y: auto;
}

.list-group-item {
	display: flex;
	flex-direction: column;
	justify-content: center;
	margin-bottom: 10px;
}

.reserve-date {
	padding-top: 5px;
	display: flex;
	flex-direction: column;
	align-items: center;
	height: 770px;
	overflow-y: auto;
	overflow-x: hidden;
}
</style>
</head>

<body>

	<header>
		<%@ include file="../WEB-INF/header.jsp"%>
	</header>
	<div class="reserve-container">
		<div class="theater-part">
			<div class="reserve-title">극장</div>
			<select id="cinemaList" class="dropdown"
				style="width: 260px; height: 30px;"></select>
		</div>
		<div class="movie-part">
			<div class="reserve-title">영화</div>
			<select id="movieList" class="dropdown"
				style="width: 280px; height: 30px;"></select>
		</div>
		<div class="day-part">
			<div class="reserve-title">날짜</div>
			<select id="dateList" class="dropdown"
				style="width: 90px; height: 30px;"></select>
		</div>
		<div class="time-part">
			<div class="reserve-title">스케줄</div>
			<div id="scheduleTable" class="schedule-list" id="scheduleContainer"></div>
		</div>
	</div>
	<footer>
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>
	<script>
		// 드롭다운 목록을 채우는 함수
		function populateDropdownList(data, elementId) {
			var dropdown = $('#' + elementId);
			dropdown.empty();
			$.each(data, function(index, value) {
				dropdown.append($('<option>').text(value).val(value));
			});
		}
		
		var selectedValues = {
			    cinema: null,
			    movie: null,
			    date: null
			};

			// 드롭다운 변경 이벤트에 대한 리스너 등록
			$('#cinemaList, #movieList, #dateList').change(function () {
			    // 현재 변경된 드롭다운의 ID를 가져옴
			    var dropdownId = $(this).attr('id');

			    // 해당 드롭다운의 값 업데이트
			    selectedValues[dropdownId] = $(this).val();

			    // 모든 값이 선택되었는지 확인
			    if (selectedValues.cinema && selectedValues.movie && selectedValues.date) {
			        // 모든 값이 선택되었을 때 실행할 함수 호출
			        updateSchedule();
			    }
			});

		// 선택한 극장, 영화, 날짜에 따라 스케줄을 업데이트하는 함수
		function updateSchedule() {
    var cinema = $('#cinemaList').val();
    var movie = $('#movieList').val();
    var date = $('#dateList').val();

    // AJAX를 사용하여 서버에 요청을 보냄
    $.ajax({
        type: 'GET',
        url: '/movieschedule/getMovieSchedule/' + movie + '/' + cinema + '/' + date,
        success: function(response) {
            console.log(response);

            // 서버에서 받아온 스케줄을 업데이트
            var scheduleList = $('#scheduleList');
            scheduleList.empty(); // 기존 내용 비우기
            
            var newRow = $("<tr>");

            for (var i = 0; i < response.length; i++) {
                var schedule = response[i];
                console.log(schedule);

                var finishTime = new Date(schedule.scheduleFinishTime);
                var startTime = new Date(schedule.scheduleStartTime);

                // HTML 생성
                var movieHtml = "<td style='display: flex; flex-direction: column; justify-content: center;'>";
                movieHtml += "<ol class='list-group' style='width:380px;'>";
                movieHtml += "<li class='list-group-item d-flex justify-content-between align-items-start'>";
                movieHtml += "<div class='ms-2 me-auto'>";
                movieHtml += "<div class='fw-bold'>" + (i + 1) + "</div>";
                movieHtml += "<p>" + startTime.toLocaleString() + " ~ " + finishTime.toLocaleString() + "</p>";
                movieHtml += "<p>"+ " | "  + schedule.screenFloor + " | " + schedule.screenHall + " | " +
                    "남은좌석: " + schedule.screenRestSeat + " | 총좌석: " + schedule.screenTotalSeat + " | " + "</p>";
                movieHtml += "</div>";
                movieHtml += "<a href='#'><span class='badge bg-white rounded-pill' onclick='reserve(" + schedule.scheduleNo + ")'>예매하기</span></a>";
                movieHtml += "</li>";
                movieHtml += "</ol>";
                movieHtml += "</td>";

                newRow.append(movieHtml);
            }

            $('#scheduleTable').append(newRow);

            var scheduleTable = $('#scheduleTable'); // Replace 'scheduleTable' with the actual ID of your table
            scheduleTable.append(newRow);

            },
        error: function() {
            toastr.error('스케줄을 가져오는데 실패했습니다.');
        }
    });
}

		populateDropdownList(cinemaList, 'cinemaList');
		populateDropdownList(movieList, 'movieList');
		populateDropdownList(dateList, 'dateList');

		// 드롭다운 변경 이벤트에 대한 리스너 등록
		$('#cinemaList, #movieList, #dateList').change(updateSchedule);

		$(document).ready(function() {

			getMovie();
		});
		
		 function formatDate(date) {
	            const month = String(date.getMonth() + 1).padStart(2, '0');
	            const day = String(date.getDate()).padStart(2, '0');
	            return `${month}-${day}`;
	        }

		function getMovie() {
			var selectElement = document.getElementById('cinemaList');
			var selectElement1 = document.getElementById('movieList');
			var selectElement2 = document.getElementById('dateList');
		    $.ajax({
		        type: 'GET',
		        url: '/movieschedule/MovieInfo',
		        success: function (data) {
		            console.log(data);
		            
		            for(const cinema of data.cinema){
		            	var option = document.createElement('option');
		            	   option.value = cinema.cinemaNo;
		            	    option.text = cinema.cinemaName;
		            	    
		            	    selectElement.appendChild(option);
		            }
		            for(const movie of data.movie){
		            	var option = document.createElement('option');
		            	   option.value = movie.movieNo;
		            	    option.text = movie.movieTitle;
		            	    
		            	    selectElement1.appendChild(option);
		            }
		            
		            var currentDate = new Date();
		            var month = currentDate.getMonth() + 1; 
		            var year = currentDate.getFullYear();
		            
		            	var option = document.createElement('option');
		            	   option.value =  year + '-' + month +'-21';
		            	    option.text = '1/21';
		            	    
		            	    var option2 = document.createElement('option');
			            	   option2.value = year + '-' + month +'-22';
			            	    option2.text = '1/22';
		            	   
		            	    
		            	    selectElement2.appendChild(option);
		            	    selectElement2.appendChild(option2);
		         
		        },
		        error: function () {
		            toastr.error('스케줄을 가져오는데 실패했습니다.');
		        }
		    });
		}
		function reserve(scheduleNo){
			console.log(scheduleNo);
			localStorage.setItem("scheduleNo",scheduleNo);
			location.href = './reserveMovie.jsp';
		}
	</script>
</body>

</html>
