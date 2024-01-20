<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>리뷰 수정</title>
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
        <h2 class="mt-3">리뷰 게시판</h2>
        <div class="form-container">
            <form id="editForm" action="/review/update" method="post">
            <div class="mb-3">
                     <label for="reviewScore" class="form-label">평점</label>
                <select class="form-select" id="reviewScore" name="reviewScore" required>
                    <option value="1">1점</option>
                    <option value="2">2점</option>
                    <option value="3">3점</option>
                    <option value="4">4점</option>
                    <option value="5">5점</option>
                </select>
                </div>
                <div class="mb-3">
                <input type="hidden" id="reviewNo" name="reviewNo"
						value="${review.reviewNo}">
                    <label for="reviewTitle" class="form-label">제목</label> <input
                        type="text" class="form-control" id="reviewTitle"
                        name="reviewTitle" placeholder="수정할 제목을 입력하세요" required>
                </div>
                <div class="mb-3">
                    <label for="reviewContent" class="form-label">리뷰 내용</label> <input
                        type="text" class="form-control" id="reviewContent"
                        name="reviewContent" placeholder="수정할 리뷰 내용을 입력하세요" required>
                </div>

                <button class="btn btn-light bg-dark text-light" type="button" onclick="updateReview()">수정하기</button>
                <button class="btn btn-light bg-dark text-light" type="button" onclick="removeReview()">삭제하기</button>
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
						url : '/review/info/' + selectedItemNo,
						contentType : 'application/json',
						success : function(selectedItem) {
							console.log(selectedItem);
							$('#reviewNo').val(selectedItem.reviewNo);
							$('#reviewScore').val(selectedItem.reviewScore);
							$('#reviewTitle').val(selectedItem.reviewTitle);
							$('#reviewContent').val(selectedItem.reviewContent);
													
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
    
    
    
	function updateReview() {
	    var reviewNo = $("#reviewNo").val();
	    var reviewScore = $("#reviewScore").val();
	    var reviewTitle = $("#reviewTitle").val();
	    var reviewContent = $("#reviewContent").val();

	 // FormData를 사용하여 파일을 추가
		var formData = new FormData(document.getElementById('editForm'));

	    // 사용자에게 현재 입력된 값들을 보여줌
	    var confirmationMessage = "리뷰를 수정하시겠습니까?";
	    var confirmUpdate = confirm(confirmationMessage);

	    if (confirmUpdate) {
	    	$.ajax({
	    	    type: "POST",
	    	    url: "/review/update",
	    	    processData: false,
	    	    contentType: false,
	    	    data: formData,
	    	    success: function (response) {
	    	        console.log("수정 성공:", response);
	    	        alert("리뷰가 수정되었습니다.");

	    	        // 수정 후 로컬 스토리지에서 선택한 상품 정보 삭제
	    	        localStorage.removeItem('selectedItemNo');

	    	        location.href = "/review/reviewlist.jsp";
	    	    },
	    	    error: function (error) {
	    	        var errorMessage = error.responseText;
	    	        alert(errorMessage);
	    	    }
	    	});

	    } else {
	        // 사용자가 수정을 취소한 경우
	        alert("리뷰 수정이 취소되었습니다.");
	    }
	}


        function removeReview() {
            var reviewNo = sessionStorage.getItem('reviewNo');
            var confirmDelete = confirm("정말로 리뷰를 삭제하시겠습니까?");

            if (confirmDelete) {
                // 삭제 요청
                $.ajax({
                    type: "DELETE",
                    url: "/review/" + reviewNo,
                    success: function (response) {
                        console.log("Delete successful:", response);
                        alert("리뷰가 삭제되었습니다.");
                        location.href = "/review/reviewlist.jsp";
                    },
                    error: function (error) {
                        var errorMessage = error.responseText;
                        alert(errorMessage);
                    }
                });
            } else {
                // 사용자가 삭제를 취소한 경우
                alert("리뷰 삭제가 취소되었습니다.");
            }
        }
    </script>
</body>
</html>
