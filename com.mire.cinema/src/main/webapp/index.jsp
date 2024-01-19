<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>MIRE MOVIE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .dropdown:hover .dropdown-menu {
            display: block;
            margin-top: 0;
        }
        .nav-link{
            color: white;
        }
    </style>
</head>

<%
  String contextPath = request.getContextPath();
  String uploadedImagePath = contextPath + "/uploads/myimage.jpg";
%>

<body>

    <!-- 헤더 -->
    <header>
       <%@ include file="./WEB-INF/header.jsp" %>
    </header>
    <!-- 메인 -->
    <main class="container">
       <%@ include file="./WEB-INF/main.jsp"%>
    </main>
    <!-- 슬라이드쇼-->
    <footer class="container">
       <%@ include file="./WEB-INF/slide.jsp"%>
    </footer>
    <!-- 푸터-->
    <footer class="container">
       <%@ include file="./WEB-INF/footer.jsp"%>
    </footer>
    
    
</body>

<script>
$(document).ready(function() {
	console.log("클리어");
    localStorage.clear();
});

</script>

</html>

