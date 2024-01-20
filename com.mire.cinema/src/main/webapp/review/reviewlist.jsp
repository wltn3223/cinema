<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<title>리뷰 게시판</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
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

#movieTable {
      width: 100%;
      background-color: #343a40;
      
    }
    #movieTable th, #movieTable td {
      color: white;
      padding: 8px;
      text-align: left;
    }
    
    img {
      width: 300px;
      height: 450px;
      float: right;
    }
    #movieInfo, #reservationInfo {
      width: 50%;
    }
    #posterContainer img {
    border-radius: 10px; /* 둥근 모서리 크기 조절 가능 */
    margin : 100px 70px 100px 0;
    
  }
</style>
</head>
<body>
	<!-- 헤더 -->
	<header>
		<%@ include file="../WEB-INF/header.jsp"%>
	</header>
	<!-- 메인 -->
	<main class="container">
		<div class="container mt-3">

			<div class="page-title">
				<h2 class="mb-4">리뷰 게시판</h2>
				<p>| 리뷰 게시판 입니다</p>
			</div>
<div>
  
 <table id="movieTable">
    <thead>
      <tr>
        <th><h2 style="width: 50%"></h2></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td id="movieInfo">
          <span>#미래토크 #무대인사</span><br>
          <h2 style="font-weight: bold;">토이스토리</h2><br>
          <span>장르: 애니메이션, 모험, 코미디</span><br>
        </td>
        <td rowspan="4">
          <div id="posterContainer">
            <img src="/image/main04.PNG" alt="Movie Poster">
          	
          </div>
           
        </td>
      </tr>
      <tr>
        <th style="width: 50%"></th>
      </tr>
      <tr>
        <td id="reservationInfo">
          <span><h2>주요정보</h2></span><br>
          <span>인간의 몸속에 가둬진 외계인 죄수의 탈옥을 막으려다 과거에 갇혀버린 ‘이안’(김태리)은
우여곡절 끝에 시간의 문을 열 수 있는 ‘신검’을 되찾고,
‘썬더’(김우빈)를 찾아 자신이 떠나온 미래로 돌아가려고 한다.
한편 이안을 위기의 순간마다 도와주는 ‘무륵’(류준열)은
자신의 몸속에 느껴지는 이상한 존재에 혼란을 느낀다.
그런 ‘무륵’ 속에 요괴가 있다고 의심하는 삼각산 두 신선 ‘흑설’(염정아)과 ‘청운’(조우진),
소문 속 신검을 빼앗아 눈을 뜨려는 맹인 검객 ‘능파’(진선규),
신검을 차지하려는 ‘자장’(김의성)까지 ‘이안’과 ‘무륵’을 쫓기 시작한다.</span><br>
          </td>
      </tr>
    </tbody>
  </table>


</div>

			<div class="search-container">
				<div style="display: flex; align-items: center;">
					<div style="margin-right: 10px; ">
					리뷰 검색
					</div>
					<input type="text" placeholder="제목으로 검색하세요" id="reviewTitle"
						style="width: 300px; margin-right: 10px;">
					<div class="btn btn-dark"
						onclick="fetchReview(1, document.getElementById('reviewTitle').value)">검색</div>
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
						<th style="width: 65%;">제목</th>
						<th style="width: 10%;">작성자</th>
						<th style="width: 10%;">등록일</th>
						<th style="width: 5%;">조회수</th>
					</tr>
				</thead>
				<tbody id="reviewList">
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
	    fetchReview(1);
	});
	function fetchReview(pageNum, reviewTitle) {
	    var url = (reviewTitle === null || reviewTitle === '' || reviewTitle === undefined) ?
	        '/review/list/' + pageNum : '/review/list/' + pageNum + '/review/' + reviewTitle;
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
	        	console.log(data.list);
	            console.log(data.searchList);
	            console.log(data.page);
	        	
	            let reviews = (data.list === undefined) ? data.searchList : data.list;
	            let paginationData = data.page;
	            createPaginationButtons(paginationData.beginPage, paginationData.endPage, paginationData.prev, paginationData.next, data);
	            displayReviews(reviews);
	        })
	        .catch(error => {
	            console.error('Fetch 오류:', error.message);
	        });
	}
	function displayReviews(reviews) {
	    $('#reviewList').empty();
	    for (var review of reviews) {
	        let reviewInfo =
	            '<tr>' +
	            '<td>' + review.reviewNo + '</td>' +
	            '<td>' + review.reviewScore +'점'+ '</td>' +
	            '<td><a href="#" onclick="loadItemInfo(' + review.reviewNo + ')" class="review-title" data-review-no=' + review.reviewNo + '>' + review.reviewTitle + '</a></td>' +
	            '<td>관리자</td>' +
	            '<td>' + review.reviewDate + '</td>' +
	            '<td>' + review.reviewViews + '</td>' +
	            '</tr>';
	        $('#reviewList').append(reviewInfo);
	    }
	    $(".review-title").on("click", function() {
	        var reviewNo = $(this).data("review-no");
	        sessionStorage.setItem("reviewNo", reviewNo);  
	        location.href = "/review/getreview.jsp";
	    });
	}
	function createPaginationButtons(begin, end, prev, next, data) {
	    let prevPage = begin - 1;
	    let nextPage = end + 1;
	    $('#pageNum').empty();
	    if (data.list !== undefined) {
	        $('#prev').html(prevPage ? '<button onclick="fetchReview(' + prevPage + ')">이전</button>' : '');
	        $('#next').html(nextPage ? '<button onclick="fetchReview(' + nextPage + ')">다음</button>' : '');
	        for (let i = begin; i <= end; i++) {
	            $('#pageNum').append('<button onclick="fetchReview(' + i + ')" class="mx-2">' + i + '</button>');
	        }
	    } else {
	        $('#prev').html(prevPage ? '<button onclick="fetchReview(' + prevPage + ', \'' + data.keyword + '\')">이전</button>' : '');
	        $('#next').html(nextPage ? '<button onclick="fetchReview(' + nextPage + ', \'' + data.keyword + '\')">다음</button>' : '');
	        for (let i = begin; i <= end; i++) {
	            $('#pageNum').append('<button onclick="fetchReview(' + i + ', \'' + data.keyword + '\')" class="mx-2">' + i + '</button>');
	        }
	    }
	}
	
	
    // 클릭 시 호출되는 함수로 선택한 아이템의 정보를 localStorage에 저장
    function loadItemInfo(reviewNo) {
    $.ajax({
        type: 'GET',
        url: '/review/info/' + reviewNo,
        contentType: 'application/json',
        success: function (response) {
            console.log(response);
            // 선택한 아이템의 정보를 localStorage에 저장
            localStorage.setItem('selectedItemNo', reviewNo);
            // adminitemEditForm.jsp로 이동
            location.href = '/review/getreview.jsp';
        },
        error: function (error) {
            var errorMessage = error.responseText;
            alert(errorMessage);
        }
    });
}
	
        
	</script>
</body>
</html>