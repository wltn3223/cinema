<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>상영관 업데이트</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .form-container {
            margin-top: 50px;
        }
    </style>
</head>
<body>
    <!-- 헤더 -->
    <header>
        <%@ include file="../WEB-INF/header.jsp"%>
    </header>

    <div class="container">
        <h2 class="mt-3">상영관 수정</h2>
        <div class="form-container">
            <form id="screenForm">
                <div class="mb-3">
                    <label for="screenNo" class="form-label">상영관 번호</label>
                    <input type="text" class="form-control" id="screenNo" placeholder="업데이트할 상영관 번호를 입력하세요" required>
                </div>
                <div class="mb-3">
                    <label for="screenFloor" class="form-label">상영관 층</label>
                    <input type="text" class="form-control" id="screenFloor" placeholder="업데이트할 상영관 층을 입력하세요" required>
                </div>
                <div class="mb-3">
                    <label for="screenHall" class="form-label">상영관 관</label>
                    <input type="text" class="form-control" id="screenHall" placeholder="업데이트할 상영관 관을 입력하세요" required>
                </div>
                <div class="mb-3">
                    <label for="screenTotalSeat" class="form-label">전체 좌석 수</label>
                    <input type="text" class="form-control" id="screenTotalSeat" placeholder="업데이트할 전체 좌석 수를 숫자로 입력하세요" required>
                </div>
                <button type="button" class="btn btn-primary" onclick="writeScreen()">상영관 업데이트</button>
            </form>
        </div>
    </div>

    <!-- 푸터 -->
    <footer class="container">
        <%@ include file="../WEB-INF/footer.jsp"%>
    </footer>

    <script>
        function writeScreen() {
            var screenNo = $('#screenNo').val();
            var screenFloor = $('#screenFloor').val();
            var screenHall = $('#screenHall').val();
            var screenTotalSeat = $('#screenTotalSeat').val();

            var data = {
                screenNo: screenNo,
                screenFloor: screenFloor,
                screenHall: screenHall,
                screenTotalSeat: screenTotalSeat
            };

            $.ajax({
                type: 'put',
                url: '/screen/modify',
                contentType: "application/json;charset=UTF-8",
                data: JSON.stringify(data),
                success: function(response) {
                    alert(response);
                    location.href = "/screen/screenlist.jsp";
                },
                error: function(error) {
                    var errorMessage = error.responseText;
                    alert(errorMessage);
                }
            });
        }
    </script>
    
</body>
</html>
