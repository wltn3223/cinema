<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
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
            <h2>영화스케줄</h2>
            <br>
            <a href="/screen/screenwrite.jsp" class="btn btn-dark mb-2">스케줄 추가</a>
            <a href="/screen/screenmodify.jsp" class="btn btn-dark mb-2">스케줄 수정</a>
            <a href="/screen/screenmodify.jsp" class="btn btn-dark mb-2">스케줄 삭제</a>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>영화</th>
                        <th>상영관</th>
                        <th>영화상영시간</th>
                        <th>영화상영종료시간 </th>
                        <th>상영관 총 좌석</th>
                    </tr>
                </thead>
                <tbody id="table-body">
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
                url: '/movieschedule/list',
                contentType: 'application/json',
                success: function (movieSchedules) {
                    appendScreenToTable(movieSchedules);
                },
                error: function (error) {
                    var errorMessage = error.responseText;
                    alert(errorMessage);
                }
            });
        });

        function appendScreenToTable(movieSchedules) {
            var tbody = $("#table-body");
            tbody.empty();

            for (var i = 0; i < movieSchedules.length; i++) {
                var movieSchedule = movieSchedules[i];
                var row = "<tr>"
                    + "<td>" + movieSchedule.screenNo + "</td>"
                    + "<td>" + movieSchedule.movieNo + "</td>"
                    + "<td>" + movieSchedule.scheduleStartTime + "</td>"
                    + "<td>" + movieSchedule.scheduleFinishTime + "</td>"
                    + "<td>" + movieSchedule.screenTotalSeat + "</td>"
                    + "</tr>";
                tbody.append(row);
            }
        }
    </script>
</body>
</html>
