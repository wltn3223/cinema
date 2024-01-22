<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MIRE MOVIE - 문의사항</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
.search-container {
	margin-bottom: 20px;
}

.search-container input {
	width: 300px;
	margin-right: 10px;
}

.search-container button {
	margin-right: 10px;
}

.btn-dark {
	background-color: #343a40;
	border-color: #343a40;
}

.btn-dark:hover {
	background-color: #1d2124;
	border-color: #1d2124;
}

.table thead {
	background-color: #343a40;
	color: white;
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
	<main class="container mt-3">
		<h2>문의사항</h2>
		<div class="search-container">
			<div style="display: flex; align-items: center;">
				<div style="margin-right: 10px;">문의사항 검색</div>
				<input type="text" placeholder="제목으로 검색하세요" id="askTitle">
				<button class="btn btn-dark"
					onclick="fetchAsk(1, document.getElementById('askTitle').value)">검색</button>
			</div>
		</div>
		<a href="/ask/askwrite.jsp">
			<button class="btn btn-dark mb-2">문의사항 작성</button>
		</a>
		<!-- 문의사항 리스트 테이블 -->
		<table class="table table-striped table-bordered">
			<thead>
				<tr>
					<th scope="col">일련번호</th>
					<th scope="col">제목</th>
					<th scope="col">작성자</th>
					<th scope="col">등록일</th>
				</tr>
			</thead>
			<tbody id="askList">
			</tbody>
		</table>

		<!-- 페이징 부분에서도 ID 수정 -->
		<div id="paging" class="d-flex container justify-content-center mt-5">
			<div id="prev" class="mx-4"></div>
			<div id="pageNum"></div>
			<div id="next" class="mx-4"></div>
		</div>
	</main>
	<!-- 푸터-->
	<footer class="container">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>

	<script>
        document.addEventListener('DOMContentLoaded', function () {
            fetchAsk(1);
        });

        function fetchAsk(pageNum, askTitle) {
            var url = (askTitle === null || askTitle === '' || askTitle === undefined) ?
                '/ask/list/' + pageNum : '/ask/list/' + pageNum + '/ask/' + askTitle;
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
                    let asks = (data.list === undefined) ? data.searchList : data.list;
                    let paginationData = data.page;
                    createPaginationButtons(paginationData.beginPage, paginationData.endPage, paginationData.prev, paginationData.next, data);
                    displayAsks(asks);
                })
                .catch(error => {
                    console.error('Fetch 오류:', error.message);
                });
        }

        function displayAsks(asks) {
            $('#askList').empty();

            for (var ask of asks) {
                let askInfo =
                    '<tr>' +
                    '<td>' + ask.askNo + '</td>' +
                    '<td><a href="#" id="askTitle" class="ask-title" data-ask-no=' + ask.askNo + '>' + ask.askTitle + '</a></td>' +
                    '<td>' + ask.memberId + '</td>' +
                    '<td>' + ask.askDate + '</td>' +
                    '</tr>';

                $('#askList').append(askInfo);
            }

            $(".ask-title").on("click", function () {
                var askNo = $(this).data("ask-no");
                sessionStorage.setItem("AskNo", askNo);
                location.href = "/ask/getask.jsp";
            });
        }

        function createPaginationButtons(begin, end, prev, next, data) {
            let prevPage = begin - 1;
            let nextPage = end + 1;
            $('#pageNum').empty();

            if (data.list !== undefined) {
                $('#prev').html(prevPage ? '<button onclick="fetchAsk(' + prevPage + ')">이전</button>' : '');
                $('#next').html(nextPage ? '<button onclick="fetchAsk(' + nextPage + ')">다음</button>' : '');
                for (let i = begin; i <= end; i++) {
                    $('#pageNum').append('<button onclick="fetchAsk(' + i + ')" class="mx-2">' + i + '</button>');
                }
            } else {
                $('#prev').html(prevPage ? '<button onclick="fetchAsk(' + prevPage + ', \'' + data.keyword + '\')">이전</button>' : '');
                $('#next').html(nextPage ? '<button onclick="fetchAsk(' + nextPage + ', \'' + data.keyword + '\')">다음</button>' : '');
                for (let i = begin; i <= end; i++) {
                    $('#pageNum').append('<button onclick="fetchAsk(' + i + ', \'' + data.keyword + '\')" class="mx-2">' + i + '</button>');
                }
            }
        }
    </script>
</body>
</html>
