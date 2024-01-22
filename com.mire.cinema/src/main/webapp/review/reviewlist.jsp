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
    
</style>
</head>
<body>
	<!-- 헤더 -->
	<header>
		<%@ include file="../WEB-INF/header.jsp"%>
	</header>
	<!-- 메인 -->
	<main class="container">

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
						<th style="width: 10%;">작성자</th>
						<th style="width: 5%;">평점</th>
						<th style="width: 65%;">제목</th>
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
	$(document).ready(function () {
	    fetchReview(1);

	    function fetchReview(pageNum, reviewTitle) {
	        const movieNo = localStorage.getItem('movieNo');
	        const url = (reviewTitle === null || reviewTitle === '' || reviewTitle === undefined) ?
	            '/review/list/movie/' + movieNo + '/' + pageNum : '/review/list/movie/' + movieNo + '/' + pageNum + '/review/' + reviewTitle;
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
	                '<td>' + member.memberId + '</td>' +
	                '<td>' + review.reviewScore +'점'+ '</td>' +
	                '<td><a href="#" onclick="loadItemInfo(' + review.reviewNo + ')" class="review-title" data-review-no=' + review.reviewNo + '>' + review.reviewTitle + '</a></td>' +
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

	    function loadItemInfo(reviewNo, movieNo) {
	        $.ajax({
	            type: 'GET',
	            url: '/review/info/' + reviewNo + '?movieNo=' + movieNo,
	            contentType: 'application/json',
	            success: function (response) {
	                console.log(response);
	                localStorage.setItem('selectedItemNo', reviewNo);
	                location.href = '/review/getreview.jsp';
	            },
	            error: function (error) {
	                var errorMessage = error.responseText;
	                alert(errorMessage);
	            }
	        });
	    }
	});
	</script>
</body>
</html>