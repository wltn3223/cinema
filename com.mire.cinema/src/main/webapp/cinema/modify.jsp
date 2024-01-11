<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MyBatis 게시판 - 영화관 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <header>
        <%@ include file="../WEB-INF/header.jsp" %>
    </header>
    <div class="container mt-5">
        <h2 class="mb-4">영화관 수정</h2>
        <form id="cinemaForm">
            <div class="mb-3">
                <label for="cinemaNo" class="form-label">영화관번호</label>
                <input type="text" class="form-control" id="cinemaNo" name="cinemaNo" readonly>
            </div>
            <div class="mb-3">
                <label for="cinemaName" class="form-label">영화관이름</label>
                <input type="text" class="form-control" id="cinemaName" name="cinemaName" readonly>
            </div>
            <div class="mb-3">
                <label for="cinemaIntro" class="form-label">영화관소개</label>
                <textarea class="form-control" id="cinemaIntro" name="cinemaIntro" readonly></textarea>
            </div>
            <div class="mb-3">
                <label for="cinemaTotalScreen" class="form-label">총상영관수</label>
                <input type="text" class="form-control" id="cinemaTotalScreen" name="cinemaTotalScreen" readonly>
            </div>
            <div class="mb-3">
                <label for="cinemaPhone" class="form-label">영화관전화번호</label>
                <input type="text" class="form-control" id="cinemaPhone" name="cinemaPhone" readonly>
            </div>
            <div class="mb-3">
                <label for="cinemaLocation" class="form-label">영화관위치</label>
                <textarea class="form-control" id="cinemaLocation" name="cinemaLocation" readonly></textarea>
            </div>
            <button type="button" class="btn btn-primary" id="btnEdit">수정</button>
            <button type="submit" class="btn btn-success" id="btnSave" style="display: none;">저장</button>
            <button type="button" class="btn btn-secondary" id="btnCancel" style="display: none;">취소</button>
        </form>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        $(document).ready(function () {
            // 서버에서 영화관 정보 가져오기
            $.ajax({
                url: "/cinema/list", // 수정할 영화관의 정보를 가져올 서버의 URL
                type: "GET",
                dataType: "json",
                success: function (data) {
                    // 영화관 정보를 폼에 설정
                    $("#cinemaNo").val(data.cinemaNo);
                    $("#cinemaName").val(data.cinemaName);
                    $("#cinemaIntro").val(data.cinemaIntro);
                    $("#cinemaTotalScreen").val(data.cinemaTotalScreen);
                    $("#cinemaPhone").val(data.cinemaPhone);
                    $("#cinemaLocation").val(data.cinemaLocation);
                },
                error: function (xhr, status, error) {
                    // 에러 발생 시 처리
                    console.error("영화관 정보 가져오기 실패:", error);
                    alert("영화관 정보를 가져오는 데 실패했습니다.");
                }
            });

            // 수정 버튼 클릭 시 폼 편집 모드로 전환
            $("#btnEdit").on("click", function () {
                $("input, textarea").prop("readonly", false);
                $("#btnEdit").hide();
                $("#btnSave, #btnCancel").show();
            });

            // 저장 버튼 클릭 시 수정된 정보 서버에 전송
            $("#btnSave").on("click", function () {
                var formData = $("#cinemaForm").serialize();

                $.ajax({
                    url: "/cinema/save", // 수정된 정보를 저장할 서버의 URL
                    type: "POST",
                    data: formData,
                    success: function (response) {
                        // 성공적으로 저장되었을 때의 처리
                        console.log("영화관 정보 수정 성공:", response);
                        alert("영화관 정보가 성공적으로 수정되었습니다.");

                        // 저장 후 폼을 읽기 전용 모드로 전환
                        $("input, textarea").prop("readonly", true);
                        $("#btnEdit").show();
                        $("#btnSave, #btnCancel").hide();
                    },
                    error: function (xhr, status, error) {
                        // 에러 발생 시 처리
                        console.error("영화관 정보 저장 실패:", error);
                        alert("영화관 정보를 저장하는 데 실패했습니다.");
                    }
                });
            });

            // 취소 버튼 클릭 시 폼을 읽기 전용 모드로 전환
            $("#btnCancel").on("click", function () {
                $("input, textarea").prop("readonly", true);
                $("#btnEdit").show();
                $("#btnSave, #btnCancel").hide();
            });
        });
    </script>

    <footer class="container mt-5">
        <%@ include file="../WEB-INF/footer.jsp" %>
    </footer>
</body>
</html>
