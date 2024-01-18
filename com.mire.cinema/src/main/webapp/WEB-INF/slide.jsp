<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제목을 입력하세요</title>
<style>
  #slideShow {
    position: relative;
  }

  #slides {
    position: relative;
    width: 100%; /* 너비를 100%로 설정 */
    overflow: hidden; /* 버튼이 내려가지 않도록 오버플로우 숨김 */
  }

  #prev, #next {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    background-color: transparent; /* 백그라운드 색 투명으로 설정 */
    color: black; /* 글자 색을 검정색으로 설정 */
    border: none;
    padding: 10px;
    cursor: pointer;
  }

  #prev {
    left: 0; /* 왼쪽에 prev 버튼 정렬 */
    transform: translateX(50%);
  }

  #next {
    right: 95%; /* 우측 버튼을 화면 가운데로 정렬 */
    transform: translateX(95%); /* 우측 버튼 가운데 정렬을 위한 추가 변형 */
  }
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		var slides = document.querySelectorAll("#slides > img");
		var prev = document.getElementById("prev");
		var next = document.getElementById("next");
		var current = 0;
		var slideInterval;

		showSlides(current);
		prev.onclick = prevSlide;
		next.onclick = nextSlide;

		slideInterval = setInterval(nextSlide, 2000);

		document.getElementById("slides").addEventListener("mouseover",
				function() {
					clearInterval(slideInterval);
				});

		document.getElementById("slides").addEventListener("mouseout",
				function() {
					slideInterval = setInterval(nextSlide, 2000);
				});

		function showSlides(n) {
			for (let i = 0; i < slides.length; i++) {
				slides[i].style.display = "none";
			}
			slides[n].style.display = "block";
		}

		function prevSlide() {
			if (current > 0)
				current -= 1;
			else
				current = slides.length - 1;
			showSlides(current);
		}

		function nextSlide() {
			if (current < slides.length - 1)
				current += 1;
			else
				current = 0;
			showSlides(current);
		}
	});
</script>
</head>
<body>
	<div id="slideShow">
		<div id="slides">
			<img src="/image/ht01.PNG" alt="">
			<img src="/image/ht02.PNG" alt="">
			<img src="/image/ht03.PNG" alt="">
			<img src="/image/ht04.PNG" alt="">
			<button id="prev">&lang;</button>
			<button id="next">&rang;</button>
		</div>
	</div>
</body>
</html>
