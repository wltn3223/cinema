<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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



            .dropdown:hover .dropdown-menu {
                display: block;
                margin-top: 0;
            }

            .jb-900 {
                font-style: oblique;
            }

            .trstyle {
                text-align: center;
            }

            .t-container {
                display: flex;
                flex-direction: column;
                align-items: center;
                margin: 20px;
            }

            .as {
                color: white;
                text-decoration: none;
            }

            .as:hover {
                text-decoration: underline;
            }

            input {
                width: 80%;
                padding: 10px;
                border: none;
                background-color: #393939;
                color: white;
            }

            .trstyle img {
                border-radius: 10px;
                width: 200px;
            }

            #slideShow {
                position: relative;
            }

            #slides {
                position: relative;
            }

            #slides img {
                display: none;

            }

            #slides img:first-child {
                display: block;
            }

            #prev,
            #next {
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                font-size: 24px;
                color: white;
                background-color: rgba(0, 0, 0, 0.5);
                border: none;
                cursor: pointer;
            }

            #prev {
                left: 10px;
            }

            #next {
                right: 10px;
            }

            #slideShow img:last-child {
                position: absolute;
                top: 0;
                right: 0;


            }

        </style>
</head>
<body>
  <main>
            
            <table border="0" width="100%" height="600px">

                <tr class="trstyle" style="background-color: #1f1d1d;">

                    <td>
                        <div class="t-container">
                            <img src="/image/main01.PNG" width="200" height="400">
                            <button class="btn btn-primary">예매하기</button>
                        </div>
                    </td>

                    <td>
                        <div class="t-container">
                            <img src="/image/main02.PNG" width="200" height="400">
                            <button class="btn btn-primary">예매하기</button>
                        </div>
                    </td>
                    <td>
                        <div class="t-container">
                            <img src="/image/main03.PNG" width="200" height="400">
                            <button class="btn btn-primary">예매하기</button>
                        </div>
                    </td>
                    <td>
                        <div class="t-container">
                            <img src="/image/main04.PNG" width="200" height="400">
                            <button class="btn btn-primary">예매하기</button>
                        </div>
                    </td>
                </tr>

                <tr class="trstyle" style="background-color: #393939;">

                    <td>
                        <input type="text" placeholder="영화명을 입력해주세요"><a href="#"><img src="/image/dot.PNG"
                                style="width: 30px; height: 30px;"></a>
                    </td>

                    <td>
                        <div class="t-container">
                            <a href="#" class="as"><img src="/image/sy.PNG" style="width: 30px; height: 30px;"> 상영시간표</a>
                        </div>
                    </td>

                    <td>
                        <div class="t-container">
                            <a href="#" class="as"><img src="/image/bo.PNG" style="width: 30px; height: 30px;"> 박스오피스</a>
                        </div>
                    </td>

                    <td>
                        <div class="t-container">
                            <a href="#" class="as"><img src="/image/ym.PNG" style="width: 30px; height: 30px;"> 빠른예매</a>
                        </div>
                    </td>
                </tr>

                <tr class="trstyle" style="background-color: #503396;">
                    <td>
                        <div class="t-container">
                            <a class="window" href="#" class="as"><img src="/image/member.PNG" style="width: 100%; height: 100%;"></a>
                        </div>
                    </td>

                    <td>
                        <div class="t-container">
                            <a href="/notice/noticelist.jsp" class="as"><img src="/image/gong.png" style="width: 100%; height: 100%;"></a>
                        </div>
                    </td>

                    <td>
                        <div class="t-container">
                            <a href="/itemgiftcard/useritemlist.jsp" class="as"><img src="/image/store.PNG" style="width: 100%; height: 100%;"></a>
                        </div>
                    </td>

                    <td>
                        <div class="t-container">
                            <a href="/notice/usernoticelist.jsp" class="as"><img src="/image/event.PNG" style="width: 100%; height: 100%;"></a>
                        </div>
                    </td>
                </tr>

                <tr class="trstyle" style="background-color: #503396;">
                    <td>
                        <div class="t-container">
                            <h4 style="color: white;">MIRE MOVIE </h4>
                            <h2 style="color: white;">GRAND OPENING </h2>

                        </div>
                    </td>

                    <td colspan="2">
                        <div class="t-container">
                            <a href="#" class="as"><img src="/image/open.PNG" style="width: 100%; height: 100%;"></a>
                        </div>
                    </td>

                    <td></td>
                </tr>

                <tr class="trstyle">
                    <td>
                        <h2 style="color: black; margin-top: 20px">미래시네마 소개</h2>
                    </td>
                </tr>
                <tr class="trstyle">
                    </td>
                    <td>
                        <div class="t-container">
                            <a href="#" class="as"><img src="/image/dolby.PNG" style="width: 100%; height: 100%;"></a>
                        </div>
                    </td>

                    <td>
                        <div class="t-container">
                            <a href="#" class="as"><img src="/image/private.PNG" style="width: 100%; height: 100%;"></a>
                        </div>
                    </td>

                    <td>
                        <div class="t-container">
                            <a href="#" class="as"><img src="/image/at.PNG" style="width: 100%; height: 100%;"></a>
                        </div>
                    </td>

                    <td>
                        <div class="t-container">
                            <a href="#" class="as"><img src="/image/comp.PNG" style="width: 100%; height: 100%;"></a>
                        </div>
                    </td>

                </tr>


            </table>

        </main>
 
 <script>
 $(document).ready(function () {
     $('.window').click(function (e) {
         e.preventDefault();

         // 할인 정보 설정
         var discountText = '<br>상품 결제시 실버 회원은 총 금액의 5% 골드 회원은 총 금액의 10% 할인됩니다.';

         // 창 열기
         openInfoWindow(discountText, 300, 50);
     });
 });

 function openInfoWindow(infoText, width, height) {
     var screenWidth = window.screen.width;
     var screenHeight = window.screen.height;

     var left = (screenWidth - width) / 2;
     var top = (screenHeight - height) / 2;

     var newWindow = window.open('', '_blank', 'width=' + width + ', height=' + height + ', left=' + left + ', top=' + top);
     newWindow.document.write('<html><head><title>할인 정보</title></head><body style="margin:0;text-align:center;">');
     newWindow.document.write('<p style="font-weight: bold;">' + infoText + '</p>');
 }

</script>


</body>
</html>