<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
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
	<main class="container">
		<div class="container mt-3">
			<h2 class="mb-4">공지사항</h2>
			<div>
    <input type="text" placeholder="제목으로 검색하세요" id="boardTitle">
    <div class="btn btn-dark"
        onclick="fetchNotice(1, document.getElementById('boardTitle').value)">검색</div>
</div>
			<a href="/notice/noticewrite.jsp">
				<button class="btn btn-dark mb-2">공지사항 작성</button>
			</a> <a href="/notice/noticemodify.jsp">
				<button class="btn btn-dark mb-2">공지사항 수정</button>
			</a> <a href="/notice/deletenotice.jsp">
				<button class="btn btn-dark mb-2">공지사항 삭제</button>
			</a>
			<table id="cinema-list" class="table table-bordered">
				<thead>
					<tr>
						<th>일련번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>조회수</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody id="noticeList">
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
	    fetchNotice(1);
	});

	function fetchNotice(pageNum, boardTitle) {
	    var url = (boardTitle === null || boardTitle === '' || boardTitle === undefined) ?
	        '/notice/list/' + pageNum : '/notice/list/' + pageNum + '/notice/' + boardTitle;
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
	            let notices = (data.list === undefined) ? data.searchList : data.list;
	            let paginationData = data.page;
	            createPaginationButtons(paginationData.beginPage, paginationData.endPage, paginationData.prev, paginationData.next, data);
	            displayMovies(notices);
	        })
	        .catch(error => {
	            console.error('Fetch 오류:', error.message);
	        });
	}

	function displayMovies(notices) {
	    $('#noticeList').empty();

	    for (var notice of notices) {
	        let noticeInfo =
	            '<tr>' +
	            '<td>' + notice.boardNo + '</td>' +
	            '<td><a href="#" id="boardTitle" class="notice-title" data-board-no=' + notice.boardNo + '>' + notice.boardTitle + '</a></td>' +
	            '<td>관리자</td>' +
	            '<td>' + notice.boardViews + '</td>' +
	            '<td>' + notice.boardDate + '</td>' +
	            '</tr>';

	        $('#noticeList').append(noticeInfo);
	    }
	 
	    $(".notice-title").on("click", function() {
			var boardNo = $(this).data("board-no");
			sessionStorage.setItem("BoardNo", boardNo);
			location.href = "/notice/getnotice.jsp";
		});
	}

	function createPaginationButtons(begin, end, prev, next, data) {
	    let prevPage = begin - 1;
	    let nextPage = end + 1;
	    $('#pageNum').empty();

	    if (data.list !== undefined) {
	        $('#prev').html(prev ? '<button onclick="fetchNotice(' + prevPage + ')">이전</button>' : '');
	        $('#next').html(next ? '<button onclick="fetchNotice(' + nextPage + ')">다음</button>' : '');
	        for (let i = begin; i <= end; i++) {
	            $('#pageNum').append('<button onclick="fetchNotice(' + i + ')" class="mx-2">' + i + '</button>');
	        }
	    } else {
	        console.log(data.keyword);
	        $('#prev').html(prev ? '<button onclick="fetchNotice(' + prevPage + ', \'' + data.keyword + '\')">이전</button>' : '');
	        $('#next').html(next ? '<button onclick="fetchNotice(' + nextPage + ', \'' + data.keyword + '\')">다음</button>' : '');
	        for (let i = begin; i <= end; i++) {
	            $('#pageNum').append('<button onclick="fetchNotice(' + i + ', \'' + data.keyword + '\')" class="mx-2">' + i + '</button>');
	        }
	    }
	}
	</script>

</body>
</html>
