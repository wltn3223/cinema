<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MyBatis 게시판 - 영화관 수정</title>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
   <header>
      <%@ include file="../WEB-INF/header.jsp"%>
   </header>
   <div class="container mt-5">
      <div class="row justify-content-center">
         <div class="col-md-6">
            <h1 class="text-center mb-4">영화관 수정</h1>
            <form>
               <div class="form-group">
                  <label for="cinemaNo">영화관번호</label>
                  <input type="text" class="form-control" id="cinemaNo" readonly>
               </div>
               <div class="form-group">
                  <label for="cinemaName">영화관이름</label>
                  <input type="text" class="form-control" id="cinemaName">
               </div>
               <div class="form-group">
                  <label for="cinemaIntro">영화관소개</label>
                  <textarea class="form-control" id="cinemaIntro" style="height: 200px;"></textarea>
               </div>
               <div class="form-group">
                  <label for="cinemaTotalScreen">총상영관수</label>
                  <input type="text" class="form-control" id="cinemaTotalScreen">
               </div>
               <div class="form-group">
                  <label for="cinemaPhone">영화관전화번호</label>
                  <input type="text" class="form-control" id="cinemaPhone">
               </div>
               <div class="form-group">
                  <label for="cinemaLocation">영화관위치</label>
                  <textarea class="form-control" id="cinemaLocation" style="height: 200px;"></textarea>
               </div>
               <div class="d-flex justify-content-center">
                  <div class="text-center">
                     <button class="btn btn-light bg-dark text-light" type="button" onclick="updateInfo()">수정하기</button>
                     <!-- You can add a button for deletion if needed -->
                  </div>
                  <div class="text-center">
                     <a href="/cinema/list.jsp">
                        <button class="btn btn-light bg-dark text-light" type="button">목록으로</button>
                     </a>
                  </div>
               </div>
            </form>
         </div>
      </div>
   </div>
   <footer class="text-dark">
      <%@ include file="../WEB-INF/footer.jsp"%>
   </footer>

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
   <script>
      $(document).ready(function() {
         // Load cinema information from sessionStorage
         var cinemaString = sessionStorage.getItem('cinema');
         var cinema = JSON.parse(cinemaString);

         // Populate form fields with cinema information
         $('#cinemaNo').val(cinema.cinemaNo);
         $('#cinemaName').val(cinema.cinemaName);
         $('#cinemaIntro').val(cinema.cinemaIntro);
         $('#cinemaTotalScreen').val(cinema.cinemaTotalScreen);
         $('#cinemaPhone').val(cinema.cinemaPhone);
         $('#cinemaLocation').val(cinema.cinemaLocation);
      });

      function updateInfo() {
         var cinemaNo = $("#cinemaNo").val();
         var cinemaName = $("#cinemaName").val();
         var cinemaIntro = $("#cinemaIntro").val();
         var cinemaTotalScreen = $("#cinemaTotalScreen").val();
         var cinemaPhone = $("#cinemaPhone").val();
         var cinemaLocation = $("#cinemaLocation").val();

         // Implement your logic for updating cinema information
         // ...

         // Redirect to cinema list page after updating
         location.href = "/cinema/list.jsp";
      }
   </script>
   
</body>
</html>
