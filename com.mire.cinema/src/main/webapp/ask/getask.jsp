<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>MIRE MOVIE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
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
            <!-- 삭제 버튼 추가 -->
            <button class="btn btn-danger mb-2" onclick="deleteAsk()">문의사항 삭제</button>
            <a href="/ask/askmodify.jsp">
                <button class="btn btn-dark mb-2">문의사항 수정</button>
            </a>
            <a href="/ask/asklist.jsp">
                <button class="btn btn-dark mb-2">문의사항 리스트 보러가기</button>
            </a>
            <table class="table table-bordered table-striped">
                <tbody id="tableBody">
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
            var askNo = sessionStorage.getItem('AskNo');

            $.ajax({
                type: 'GET',
                url: '/ask/' + askNo,
                contentType: 'application/json',
                success: function (ask) {
                    appendAskToTable(ask);
                    // 추가: 작성자 정보 가져와서 표시
                    var memberId = '<%= session.getAttribute("memberId") %>';
                    displayAuthor(memberId);
                },
                error: function (error) {
                    var errorMessage = error.responseText;
                    alert(errorMessage);
                }
            });
        });

        function appendAskToTable(ask) {
            var tbody = $("#tableBody");
            tbody.empty();

            var row = "<tr><th scope='col'>일련번호</th><td>"
                + ask.askNo
                + "</td></tr>"
                + "<tr><th scope='col'>제목</th><td>"
                + ask.askTitle
                + "</td></tr>"
                + "<tr><th scope='col'>작성자</th><td id='authorCell'></td></tr>"  // Add this line for author
                + "<tr><th scope='col'>내용</th><td>"
                + ask.askContent
                + "</td></tr>"
                + "<tr><th scope='col'>등록일</th><td>"
                + ask.askDate
                + "</td></tr>"
                + "<tr><th scope='col'>이미지</th><td><img src='../upload/" + ask.imageUuid + "' class='img-fluid' alt='이미지'></td></tr>";

            tbody.append(row);

            // 추가: 작성자 정보 가져와서 표시
            var memberId = '<%= session.getAttribute("memberId") %>';
            displayAuthor(memberId);
        }

        // 삭제 버튼 클릭 시 호출될 함수
        function deleteAsk() {
            var askNo = sessionStorage.getItem('AskNo');

            $.ajax({
                type: 'DELETE',
                url: '/ask/' + askNo,
                contentType: 'application/json',
                success: function (response) {
                    alert(response);
                    location.href = "/ask/asklist.jsp";
                },
                error: function (error) {
                    var errorMessage = error.responseText;
                    alert(errorMessage);
                }
            });
        }

        function displayAuthor(memberId) {
            // 작성자 열을 찾아서 memberId 표시
            var authorCell = $("#authorCell");
            authorCell.text(memberId);
        }
    </script>
</body>
</html>
