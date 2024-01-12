<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <title>MIRE MOVIE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        h1,
        h2,
        span {
            color: white;
        }

        .search {
            position: relative;
            width: 300px;
        }

        input {
            width: 80%;
            border: 1px solid black;
            border-radius: 8px;
            background-color: #1f1d1d;
            padding: 10px 10px;
            margin: 10px;
            font-size: 14px;
            color: white;
        }

        input::placeholder {
            color: #cccccc;
        }

        button {
            border: 1px solid black;
            border-radius: 8px;
            background-color: #1f1d1d;
            padding: 10px 10px;
            margin: 10px;
            color: white;
        }

        p {
            color: rgb(204, 204, 204);
        }

        .dropdown:hover .dropdown-menu {
            display: block;
            margin-top: 0;
        }

        .jb-900 {
            font-style: oblique;
        }
    </style>
</head>


<body style=" background-color: black;" class="container">
    <!-- 헤더 -->
    <header>
       <%@ include file="header.jsp" %>
    </header>

  
    <!-- 메인 -->
    <main>
        <h1 style="height: 500px;"> 메인 부분</h1>
    </main>
    <!-- 푸터-->
    <footer class="py-3 my-4" style="background-color: rgb(17,17,17);">
       <%@ include file="footer.jsp"%>
    </footer>
</body>


</html>