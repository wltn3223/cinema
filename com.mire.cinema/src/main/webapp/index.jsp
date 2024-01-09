<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
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


<body>
    <!-- 헤더 -->
    <header>
       <%@ include file="header.jsp" %>
    </header>
    <!-- 메인 -->
    <main class="container" id="main">
        <h1 style="height: 500px;"> 메인 부분</h1>
    </main>
    <!-- 푸터-->
    <footer class="container">
       <%@ include file="footer.jsp"%>
    </footer>
</body>


</html>