<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>정보조회</title>
</head>

<body>
	<header>
		<%@ include file="../WEB-INF/header.jsp"%>
	</header>

	<div class="container mt-5">
		<div class="row justify-content-center">
			<div class="col-md-6">
				<h1 class="text-center mb-4">비밀번호 변경</h1>
				<form>
					<div class="form-group">
						<label for="memberId">아이디</label> <input type="text"
							class="form-control" id="memberId" readonly="readonly"
							value="${memberId}">
					</div>
					
					<div class="form-group">
						<label for="memberPasswd">기존 비밀번호 입력</label> <input type="email"
							class="form-control" id="memberPasswd">
					</div>
					
					<div class="form-group">
						<label for="memberEditPasswd">변경할 비밀번호 입력</label> <input type="email"
							class="form-control" id="memberEditPasswd">
					</div>
					
					<div class="form-group">
						<label for="memberEditPasswd1">변경할 비밀번호 입력 확인</label> <input type="email"
							class="form-control" id="memberEditPasswd1">
					</div>
					
	
					<div class="d-flex justify-content-center">
						<div class="text-center">
							<button class="btn btn-light bg-dark text-light" type="button" onclick="checkPassword()">
								수정하기
							</button>
						</div>
						<div class="text-center">
							<a href="/index.jsp"><button class="btn btn-light bg-dark text-light" type="button">
								홈으로
							</button></a>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<footer class="text-dark">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>



</body>

<script type="text/javascript">
function checkPassword(){
	var passwd = $("#memberEditPasswd").val();
    var passwd1 = $("#memberEditPasswd1").val();
	
    if(passwd === passwd1){
    	 updateInfo()
	}
    else {
		alert("변경할 비밀번호와 비밀번호 확인이 일치하지않습니다. 다시 시도해 주세요.")
	}
	
}



function updateInfo() {
    // Get values from the input fields
    var memberId = $("#memberId").val();
    var memberPasswd = $("#memberPasswd").val();
    var memberEditPasswd = $("#memberEditPasswd").val();
 
   
    // Create data object to be sent in the request
    var data = {
    	memberId: memberId,
      memberPasswd: memberPasswd,
      memberEditPasswd: memberEditPasswd,
    };


    $.ajax({
      type: "PUT",
      url: "/member",
      contentType: "application/json;charset=UTF-8",
      data: JSON.stringify(data),
      success: function (response) {
        alert(response);
        location.href = "/member/memberInfo.jsp";
      },
      error: function (error) {
    	  var errorMessage = error.responseText;
			alert(errorMessage);
       
      }
    });
  }

</script>


<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</html>