<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MyBatis 게시판 - 영화관 리스트</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .nav-link {
            color: white;
        }
    </style>
</head>
<body>
<header>
    <%@ include file="../WEB-INF/header.jsp" %>
</header>
<div class="container mt-5">
    <h2 class="mb-4">영화관 리스트</h2>
    <table id="cinema-list" class="table table-striped">
        <thead>
        <tr>
            <th>영화관번호</th>
            <th>영화관이름</th>
            <th>영화관소개</th>
            <th>총상영관수</th>
            <th>영화관전화번호</th>
            <th>영화관위치</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
    $(document).ready(function () {
        // 영화관 목록 가져오기
        $.ajax({
            url: "/cinema/list", // 영화관 목록을 가져올 서버의 URL
            type: "GET",
            dataType: "json",
            success: function (data) {
                // 영화관 목록 출력
                var tbody = $("#cinema-list tbody");
                tbody.empty();

                if (data.length === 0) {
                    tbody.append("<tr><td colspan='6'>게시글이 없습니다.</td></tr>");
                } else {
                    $.each(data, function (index, cinema) {
                        // Add a click event to each row
                        var row = $("<tr>")
                            .append("<td>" + cinema.cinemaNo + "</td>")
                            .append("<td>" + cinema.cinemaName + "</td>")
                            .append("<td>" + cinema.cinemaIntro + "</td>")
                            .append("<td>" + cinema.cinemaTotalScreen + "</td>")
                            .append("<td>" + cinema.cinemaPhone + "</td>")
                            .append("<td>" + cinema.cinemaLocation + "</td>")
                            .click(function () {
                                // Redirect to read.jsp with the cinema number
                                window.location.href = "/cinema/modify.jsp?cinemaNo=" + cinema.cinemaNo;
                            });

                        tbody.append(row);
                    });
                }
            },
            error: function (xhr, status, error) {
                // 에러 발생 시 처리
                console.error("영화관 목록 가져오기 실패:", error);
                alert("영화관 목록을 가져오는 데 실패했습니다.");
            }
        });
    });
</script>

<footer class="container mt-5">
    <%@ include file="../WEB-INF/footer.jsp" %>
</footer>
</body>
</html>
