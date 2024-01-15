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
        dataType: "json", // 추가: 서버에서 받아오는 데이터 타입을 명시
        success: function (data) {
           var tbody = $("#cinema-list tbody");
            if (data.length === 0) {
                tbody.append("<tr><td colspan='6'>게시글이 없습니다.</td></tr>");
            } else {
                for (var i = 0; i < data.length; i++) {
                    var cinema = data[i];
                    // Add a click event to each row
                    var row = $("<tr>")
                        .append("<td>" + cinema.cinemaNo + "</td>")
                        .append("<td>" + cinema.cinemaName + "</td>")
                        .append("<td>" + cinema.cinemaIntro + "</td>")
                        .append("<td>" + cinema.cinemaTotalScreen + "</td>")
                        .append("<td>" + cinema.cinemaPhone + "</td>")
                        .append("<td>" + cinema.cinemaLocation + "</td>")
                        .click(createClickHandler(cinema));

                    tbody.append(row);
                }
            }
        },
        error: function (xhr, status, error) {
            // 에러 발생 시 처리
            console.error("영화관 목록 가져오기 실패:", error);
            alert("영화관 목록을 가져오는 데 실패했습니다.");
        }
    });

    // 클릭 이벤트 핸들러를 생성하는 함수
    function createClickHandler(cinema) {
        return function () {
            sessionStorage.setItem('cinema', JSON.stringify(cinema));
            window.location.href = "/cinema/modify.jsp";
        };
    }
});
</script>

<footer class="container mt-5">
    <%@ include file="../WEB-INF/footer.jsp" %>
</footer>
</body>
</html>
