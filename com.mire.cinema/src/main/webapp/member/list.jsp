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
		<div class="container-fluid  d-flex justify-content-between">
			<h2 class="mb-4">회원목록</h2>
			<div>
				<input type="text" placeholder="아이디로 검색하세요" id="id">
				<div class="btn btn-dark ms-1"
					onclick="fetchMembers(1,document.getElementById('id').value)">회원검색</div>
			</div>
		</div>
		<table id="cinema-list" class="table table-striped container">
			<thead>
				<tr>
					<th>회원번호</th>
					<th>회원이름</th>
					<th>회원아이디</th>
					<th>회원이메일</th>
					<th>회원전화번호</th>
					<th>회원등급</th>
					<th>가입일</th>
				</tr>
			</thead>
			<tbody id="memberList">
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
   
    fetchMembers(1); // Initial fetch with page 1
});

function fetchMembers(pageNum,memberId) {
   
   
   var url = (memberId === null || memberId === '' || memberId === undefined)?
         '/member/list/' + pageNum:'/member/list/' + pageNum +'/member/' +memberId;
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
            console.log(data.searchList);
            console.log(data.page);
          
            let members = (data.list === undefined)?data.searchList:data.list;
            let paginationData = data.page;
            createPaginationButtons(paginationData.beginPage, paginationData.endPage, paginationData.prev, paginationData.next,data);
            displayMovies(members);

        })
        .catch(error => {
            console.error('Fetch error:', error.message);
        });
}

function displayMovies(members) {
   
    $('#memberList').empty();
   
  
    for (var member of members) {
    
        let memberInfo = 
           '<tr>' +
            '<td>' + member.memberNo + '</td>' +
            '<td>' + member.memberName + '</td>' +
            '<td>' + member.memberId + '</td>' +
            '<td>' + member.memberEmail + '</td>' +
            '<td>' + member.memberPhone + '</td>' +
            '<td>' + member.memberGrade + '</td>' +
            '<td>' + member.memberDate + '</td>' +
            '</tr>';
           
        $('#memberList').append(memberInfo);
        
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