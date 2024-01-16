<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<head>
    <title>MIRE MOVIE</title>
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
    <main class="container mt-3">
        <div class="container">
            <h2>상영관</h2>
            <br>
            <a href="/screen/screenwrite.jsp" class="btn btn-dark mb-2">상영관 추가</a>
            <a href="/screen/screenmodify.jsp" class="btn btn-dark mb-2">상영관 수정</a>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>상영관 일련번호</th>
                        <th>상영관 층</th>
                        <th>상영관 관</th>
                        <th>상영관 총 좌석</th>
                        <th>영화관</th>
                    </tr>
                </thead>
                <tbody id="table tbody">
                </tbody>
            </table>
        </div>
    </main>
    <!-- 푸터-->
    <footer class="container">
        <%@ include file="../WEB-INF/footer.jsp"%>
    </footer>

    <script>
        $(document).ready(function () {
            $.ajax({
                type: 'GET',
                url: '/screen/list',
                contentType: 'application/json',
                success: function (screens) {
                    appendScreenToTable(screens);
                },
                error: function (error) {
                    var errorMessage = error.responseText;
                    alert(errorMessage);
                }
            });
        });

        function appendScreenToTable(screens) {
            var tbody = $("table tbody");
            tbody.empty();

            for (var i = 0; i < screens.length; i++) {
                var screen = screens[i];
                var row = "<tr>"
                    + "<td><a href='#' class='screen-no' data-screen-no='" + screen.screenNo + "'>"
                    + screen.screenNo + "</a></td>"
                    + "<td>"
                    + screen.screenFloor + "</td>"
                    + "<td>"
                    + screen.screenHall + "</td>"
                    + "<td>"
                    + screen.screenTotalSeat + "</td>"
                    + "<td>" + screen.cinemaName + "</td>"
                    + "</tr>";
                tbody.append(row);
            }

            $(".screen-no").on("click", function () {

                var screenNo = $(this).data("screen-no");

                sessionStorage.setItem("ScreenNo", screenNo);
                location.href = "/screen/getscreen.jsp";
            });
        }
    </script>

</body>
</html>
