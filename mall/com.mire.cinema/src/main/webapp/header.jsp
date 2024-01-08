<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <!-- 헤더 -->
    <header>
        <div class="container">
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <a href="/" class="text-dark text-decoration-none">
                    <h2>MIRE MOVIE</h2>
                </a>
                <div>
                  
                        <p style="margin: auto;"><a href="/login.html">로그인</a> <a href="/join.html">회원가입</a></p>
                        <!--  <p style="margin: auto;">홍길동님 환영합니다.</p> -->
                 
                    </a>
                   <!-- 
							<ul class="dropdown-menu text-small" aria-labelledby="dropdownUser1">
                        <li><a class="dropdown-item" href="#">회원 정보 수정</a></li>
                        <li><a class="dropdown-item" href="#">회원 정보 조회</a></li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li><a class="dropdown-item" href="#">로그아웃</a></li>
                    </ul> --> 
                </div>
            </div>
        </div>
    </header>
    <!-- nav -->
    <nav class="navbar navbar-expand-sm navbar-dark bg-dark">
        <div class="container-fluid ">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mynavbar">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="mynavbar">
                <ul class="navbar-nav ">
                    &nbsp;&nbsp;
                    <li class="nav-item dropdown">
                        <a class="nav-link jb-900" href="#" role="button" data-bs-toggle="dropdown">영화</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">전체영화</a></li>
                            <li><a class="dropdown-item" href="#">큐레이션</a></li>
                            <li><a class="dropdown-item" href="#">무비포스트</a></li>
                        </ul>
                    </li>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <li class="nav-item dropdown">
                        <a class="nav-link jb-900" href="#" role="button" data-bs-toggle="dropdown">예매</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">영화예매</a></li>
                            <li><a class="dropdown-item" href="#">영화예매내역</a></li>
                            <li><a class="dropdown-item" href="#">영화예매취소</a></li>
                        </ul>
                    </li>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <li class="nav-item dropdown">
                        <a class="nav-link jb-900" href="#" role="button" data-bs-toggle="dropdown">상품</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">상품목록</a></li>
                            <li><a class="dropdown-item" href="#">상품</a></li>
                            <li><a class="dropdown-item" href="#">상품</a></li>
                        </ul>
                    </li>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <li class="nav-item dropdown">
                        <a class="nav-link jb-900" href="#" role="button" data-bs-toggle="dropdown">공지사항</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">이벤트</a></li>
                            <li><a class="dropdown-item" href="#">이벤트</a></li>
                            <li><a class="dropdown-item" href="#">이벤트</a></li>
                        </ul>
                    </li>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <li class="nav-item dropdown">
                        <a class="nav-link jb-900" href="#" role="button" data-bs-toggle="dropdown">고객센터 </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">문의내역등록</a></li>
                            <li><a class="dropdown-item" href="#">문의내역조회</a></li>
                            <li><a class="dropdown-item" href="#"></a></li>
                        </ul>
                    </li>
                </ul>
            </div>
            <form class="d-flex">
                <input type="search" placeholder="영화를 검색하세요." aria-label="Search">
                <button type="submit">search</button>
            </form>
        </div>
    </nav>
</body>
</html>