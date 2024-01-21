	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<!DOCTYPE html>
	<html>
	<head>
	    <title>MIRE MOVIE - 문의사항</title>
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
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
	            <h2>문의사항</h2>
	            <a href="/ask/askwrite.jsp">
	                <button class="btn btn-dark mb-2">문의사항 작성</button>
	            </a>  
	            <table class="table table-striped table-bordered">
	                <thead class="table-dark">
	                    <tr>
	                        <th scope="col">일련번호</th>
	                        <th scope="col">제목</th>
	                        <th scope="col">등록일</th>
	                        <th scope="col">작성자</th>
	                    </tr>
	                </thead>
	                <tbody id="table-tbody">
	
	                </tbody>
	            </table>
	        </div>
	    </main>
	    <!-- 푸터-->
	    <footer class="container">
	        <%@ include file="../WEB-INF/footer.jsp"%>
	    </footer>
	
	    <script>
	    $(document).ready(function() {
	        $.ajax({
	            type : 'GET',
	            url : '/ask/list',
	            contentType : 'application/json',
	            success : function(asks) {
	                appendAsksToTable(asks);
	            },
	            error : function(error) {
	                var errorMessage = error.responseText;
	                alert(errorMessage);
	            }
	        });
	    });
	
	    function appendAsksToTable(asks) {
	        var tbody = $("#table-tbody"); 
	        tbody.empty();
	
	        for (var i = 0; i < asks.length; i++) {
	            var ask = asks[i];
	            var formattedDate = new Date(ask.askDate).toLocaleDateString('ko-KR', { year: 'numeric', month: 'long', day: 'numeric' });
	
	            var row = "<tr>"
	                + "<td>" + ask.askNo + "</td>"
	                + "<td><a href='#' class='ask-title' data-ask-no='" + ask.askNo + "'>" + ask.askTitle + "</a></td>"
	                + "<td>" + formattedDate + "</td>"
	                + "<td>" + ask.memberId + "</td>"
	                + "</tr>";
	            tbody.append(row);
	        }
	
	        $(".ask-title").on("click", function() {
	            var askNo = $(this).data("ask-no");
	            sessionStorage.setItem("AskNo", askNo);
	            location.href = "/ask/getask.jsp";
	        });
	    }
	</script>
	
	</body>
	</html>
