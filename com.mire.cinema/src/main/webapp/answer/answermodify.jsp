<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Answer Update</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
    rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
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
        <h2 class="mt-3">Q&A 게시판</h2>
        <div class="form-container">
            <form id="editForm" action="/answer/update" method="post">
                <div class="mb-3">
                <input type="hidden" id="ansNo" name="ansNo"
						value="${answer.ansNo}">
                    <label for="ansTitle" class="form-label">제목</label> <input
                        type="text" class="form-control" id="ansTitle"
                        name="ansTitle" placeholder="수정할 제목을 입력하세요" required>
                </div>
                <div class="mb-3">
                    <label for="ansContent" class="form-label">답변 내용</label> <input
                        type="text" class="form-control" id="ansContent"
                        name="ansContent" placeholder="수정할 답변 내용을 입력하세요" required>
                </div>

                <button class="btn btn-light bg-dark text-light" type="button" onclick="updateAnswer()">수정하기</button>
                <button class="btn btn-light bg-dark text-light" type="button" onclick="removeAnswer()">삭제하기</button>
            </form>
        </div>
    </div>

    <!-- 푸터 -->
    <footer class="container">
        <%@ include file="../WEB-INF/footer.jsp"%>
    </footer>

    <script>
    $(document).ready(function() {
		getItem();
	});

	async function getItem() {
		try {
			let selectedItemNo = localStorage.getItem('selectedItemNo'); // 로컬 스토리지 사용
			if (!selectedItemNo) {
				// selectedItemNo가 없을 경우에 대한 처리
				console.warn('localStorage에서 선택한 상품 정보를 찾을 수 없습니다.');
				return;
			}

			// selectedItemNo를 사용하여 해당 아이템 정보 가져오기
			$
					.ajax({
						type : 'GET',
						url : '/answer/info/' + selectedItemNo,
						contentType : 'application/json',
						success : function(selectedItem) {
							console.log(selectedItem);
							$('#ansNo').val(selectedItem.ansNo);
							$('#ansTitle').val(selectedItem.ansTitle);
							$('#ansContent').val(selectedItem.ansContent);
													
						},
						error : function(error) {
							var errorMessage = error.responseText;
							alert(errorMessage);
						}
					});
		} catch (error) {
			alert(error);
		}
	}
    
    
    
	function updateAnswer() {
	    var ansNo = $("#ansNo").val();
	    var ansTitle = $("#ansTitle").val();
	    var ansContent = $("#ansContent").val();

	 // FormData를 사용하여 파일을 추가
		var formData = new FormData(document.getElementById('editForm'));

	    // 사용자에게 현재 입력된 값들을 보여줌
	    var confirmationMessage = "게시글을 수정하시겠습니까?";
	    var confirmUpdate = confirm(confirmationMessage);

	    if (confirmUpdate) {
	    	$.ajax({
	    	    type: "POST",
	    	    url: "/answer/update",
	    	    processData: false,
	    	    contentType: false,
	    	    data: formData,
	    	    success: function (response) {
	    	        console.log("수정 성공:", response);
	    	        alert("게시글이 수정되었습니다.");

	    	        // 수정 후 로컬 스토리지에서 선택한 상품 정보 삭제
	    	        localStorage.removeItem('selectedItemNo');

	    	        location.href = "/answer/answerlist.jsp";
	    	    },
	    	    error: function (error) {
	    	        var errorMessage = error.responseText;
	    	        alert(errorMessage);
	    	    }
	    	});

	    } else {
	        // 사용자가 수정을 취소한 경우
	        alert("게시글 수정이 취소되었습니다.");
	    }
	}


        function removeAnswer() {
            var ansNo = sessionStorage.getItem('ansNo');
            var confirmDelete = confirm("정말로 게시글을 삭제하시겠습니까?");

            if (confirmDelete) {
                // 삭제 요청
                $.ajax({
                    type: "DELETE",
                    url: "/answer/" + ansNo,
                    success: function (response) {
                        console.log("Delete successful:", response);
                        alert("게시글이 삭제되었습니다.");
                        location.href = "/answer/answerlist.jsp";
                    },
                    error: function (error) {
                        var errorMessage = error.responseText;
                        alert(errorMessage);
                    }
                });
            } else {
                // 사용자가 삭제를 취소한 경우
                alert("게시글 삭제가 취소되었습니다.");
            }
        }
    </script>
</body>
</html>
