<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<title>Q%A 게시판</title>
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
		<div class="container mt-3">

			<div class="page-title">
				<h2 class="mb-4">Q&A 게시판</h2>
				<p>| Q&A게시판 입니다</p>
			</div>

			<div class="search-container">
				<div style="display: flex; align-items: center;">
					<div style="margin-right: 10px;">
					Q&A 검색
					</div>
					<input type="text" placeholder="제목으로 검색하세요" id="ansTitle"
						style="width: 300px; margin-right: 10px;">
					<div class="btn btn-dark"
						onclick="fetchAnswer(1, document.getElementById('ansTitle').value)">검색</div>
				</div>

				<div class="action-buttons">
					<a href="/answer/answerwrite.jsp"><button
							class="btn btn-dark mb-2">답변 작성</button></a> 
				</div>
			</div>

			<table id="cinema-list" class="table table-bordered">
				<thead>
					<tr>
						<th style="width: 5%;">번호</th>
						<th style="width: 70%;">제목</th>
						<th style="width: 10%;">작성자</th>
						<th style="width: 10%;">등록일</th>
						<th style="width: 5%;">조회수</th>
					</tr>
				</thead>
				<tbody id="answerList">
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
	    fetchAnswer(1);
	});

	function fetchAnswer(pageNum, ansTitle) {
	    var url = (ansTitle === null || ansTitle === '' || ansTitle === undefined) ?
	        '/answer/list/' + pageNum : '/answer/list/' + pageNum + '/answer/' + ansTitle;
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
	        	
	            let answers = (data.list === undefined) ? data.searchList : data.list;
	            let paginationData = data.page;
	            createPaginationButtons(paginationData.beginPage, paginationData.endPage, paginationData.prev, paginationData.next, data);
	            displayAnswers(answers);
	        })
	        .catch(error => {
	            console.error('Fetch 오류:', error.message);
	        });
	}

	function displayAnswers(answers) {
	    $('#answerList').empty();

	    for (var answer of answers) {
	        let answerInfo =
	            '<tr>' +
	            '<td>' + answer.ansNo + '</td>' +
	            '<td><a href="#" onclick="loadItemInfo(' + answer.ansNo + ')" class="answer-title" data-answer-no=' + answer.ansNo + '>' + answer.ansTitle + '</a></td>' +
	            '<td>관리자</td>' +
	            '<td>' + answer.ansDate + '</td>' +
	            '<td>' + answer.ansViews + '</td>' +
	            '</tr>';

	        $('#answerList').append(answerInfo);
	    }

	    $(".answer-title").on("click", function() {
	        var ansNo = $(this).data("answer-no");
	        sessionStorage.setItem("ansNo", ansNo);  
	        location.href = "/answer/getanswer.jsp";
	    });
	}


	function createPaginationButtons(begin, end, prev, next, data) {
	    let prevPage = begin - 1;
	    let nextPage = end + 1;
	    $('#pageNum').empty();

	    if (data.list !== undefined) {
	        $('#prev').html(prevPage ? '<button onclick="fetchAnswer(' + prevPage + ')">이전</button>' : '');
	        $('#next').html(nextPage ? '<button onclick="fetchAnswer(' + nextPage + ')">다음</button>' : '');
	        for (let i = begin; i <= end; i++) {
	            $('#pageNum').append('<button onclick="fetchAnswer(' + i + ')" class="mx-2">' + i + '</button>');
	        }
	    } else {
	        $('#prev').html(prevPage ? '<button onclick="fetchAnswer(' + prevPage + ', \'' + data.keyword + '\')">이전</button>' : '');
	        $('#next').html(nextPage ? '<button onclick="fetchAnswer(' + nextPage + ', \'' + data.keyword + '\')">다음</button>' : '');
	        for (let i = begin; i <= end; i++) {
	            $('#pageNum').append('<button onclick="fetchAnswer(' + i + ', \'' + data.keyword + '\')" class="mx-2">' + i + '</button>');
	        }
	    }
	}
	
	

    // 클릭 시 호출되는 함수로 선택한 아이템의 정보를 localStorage에 저장
    function loadItemInfo(ansNo) {
    $.ajax({
        type: 'GET',
        url: '/answer/info/' + ansNo,
        contentType: 'application/json',
        success: function (response) {
            console.log(response);
            // 선택한 아이템의 정보를 localStorage에 저장
            localStorage.setItem('selectedItemNo', ansNo);
            // adminitemEditForm.jsp로 이동
            location.href = '/answer/getanswer.jsp';
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
