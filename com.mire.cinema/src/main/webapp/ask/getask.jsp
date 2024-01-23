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
        <div class="container mt-3">
            <div class="page-title">
                <h2 class="mb-4">답변안내</h2>
            </div>
            <div class="search-container">
                <div style="display: flex; align-items: center;">
                    <div style="margin-right: 10px;"></div>
                    <div class="action-buttons">
                        <a href="/answer/answerwrite.jsp">
                            <button class="btn btn-dark mb-2" id="answerBtn">답변 작성</button>
                        </a>
                    </div>
                </div>
                <table id="cinema-list" class="table table-bordered">
                    <thead>
                        <tr>
                            <th style="width: 5%;">번호</th>
                            <th style="width: 65%;">제목</th>
                            <th style="width: 10%;">작성자</th>
                            <th style="width: 10%;">등록일</th>
                            <th style="width: 10%;">조회수</th>
                        </tr>
                    </thead>
                    <tbody id="answerList">
                    </tbody>
                </table>
            </div>
        </div>
    </main>
    <!-- 푸터-->
    <footer class="container">
        <%@ include file="../WEB-INF/footer.jsp"%>
    </footer>

    <script>
        $(document).ready(function() {
            var askNo = localStorage.getItem('askNo');

            $.ajax({
                type: 'GET',
                url: '/ask/' + askNo,
                contentType: 'application/json',
                success: function (ask) {
                    console.log('Ask 정보:', ask);
                    appendAskToTable(ask);
                    // 추가: 작성자 정보 가져와서 표시
                    var memberId = '<%=session.getAttribute("memberId")%>';
        if (memberId === 'admin') {
            $("#answerBtn").show();
        } else {
            $("#answerBtn").hide();
        }
                },
                error: function (error) {
                    var errorMessage = error.responseText;
                    alert(errorMessage);
                }
            });

            fetchAnswer(askNo); // 수정
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
                + "<tr><th scope='col'>작성자</th><td>"
                + ask.memberId
                + "</td></tr>"
                + "<tr><th scope='col'>내용</th><td>"
                + ask.askContent
                + "</td></tr>"
                + "<tr><th scope='col'>등록일</th><td>"
                + ask.askDate
                + "</td></tr>"
                + "<tr><th scope='col'>이미지</th><td><img src='../upload/" + ask.imageUuid + "' class='img-fluid' alt='이미지'></td></tr>";

            tbody.append(row);

            // 추가: 작성자 정보 가져와서 표시
            var memberId = '<%=session.getAttribute("memberId")%>';
            displayAuthor(memberId);
        }

        // 삭제 버튼 클릭 시 호출될 함수
        function deleteAsk() {
            var askNo = localStorage.getItem('askNo');

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
        
        function fetchAnswer(askNo) {
            $.ajax({
                type: 'GET',
                url: '/answer/list/ask/' + askNo,
                contentType: 'application/json',
                success: function (response) {
                    console.log('답변 목록 정보:', response);
                    displayAnswers(response);
                   
                },
                error: function (error) {
                    const errorMessage = error.responseText;
                    alert(errorMessage);
                }
            });
        }
        
        
        function displayAnswers(answers) {
            console.log('Answer 정보:', answers);  // 추가
            $('#answerList').empty();

            try {
                // answers가 undefined인 경우 예외를 발생시키도록 체크
                if (!answers) {
                    throw new Error('답변 목록이 없습니다.');
                }
               
                if (answers.length > 0) {
                    for (const answer of answers) {
                        const answerInfo =
                            '<tr>' +
                            '<td>' + answer.ansNo + '</td>' +
                            '<td><a href="#" onclick="loadItemInfo(' + answer.ansNo + ')" class="answer-title" data-answer-no=' + answer.ansNo + '>' + answer.ansTitle + '</a></td>' +
                            '<td>관리자</td>' +
                            '<td>' + answer.ansDate + '</td>' +
                            '<td>' + answer.ansViews + '</td>' +
                            '</tr>';
                        $('#answerList').append(answerInfo);
                    }
                    console.log('Answer 정보:', answers);  // 추가
                } else {
                    console.error('답변 목록이 없습니다.');
                }

                $(".answer-title").on("click", function () {
                    const ansNo = $(this).data("answer-no");
                    localStorage.setItem("ansNo", ansNo);
                    location.href = "/answer/getanswer.jsp";
                });
            } catch (error) {
                console.error(error.message);
            }
        }


        function loadItemInfo(ansNo) {
            $.ajax({
                type: 'GET',
                url: '/answer/info/' + ansNo,
                contentType: 'application/json',
                success: function (response) {
                    console.log(response);
                    localStorage.setItem('selectedItemNo', ansNo);
                    location.href = '/answer/getanswer.jsp';
                },
                error: function (error) {
                    const errorMessage = error.responseText;
                    alert(errorMessage);
                }
            });
        }

        function goToAnswerWrite() {
            // localStorage에 저장된 askNo를 읽어와서 변수에 저장
            var localStorageAskNo = localStorage.getItem('askNo');

            // answerwrite.jsp로 이동하면서 askNo를 쿼리 파라미터로 전달
            location.href = "/answer/answerwrite.jsp?askNo=" + localStorageAskNo;
        }
      
    </script>
</body>
</html>
