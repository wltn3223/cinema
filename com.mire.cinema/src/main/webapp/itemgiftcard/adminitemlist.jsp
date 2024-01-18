<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<title>MIRE MOVIE</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="/itemgiftcard/tab.js"></script>
<link rel="stylesheet" href="/itemgiftcard/tab.css">

<style>

button {
	border: 1px solid black;
	border-radius: 8px;
	background-color: #1f1d1d;
	padding: 10px 10px;
	margin: 10px;
	color: white;
}

p {
	color: black;
}

.dropdown:hover .dropdown-menu {
	display: block;
	margin-top: 0;
}

.jb-900 {
	font-style: oblique;
}
</style>
</head>

<body>
	<!-- 헤더 -->
	<header>
		<%@ include file="../WEB-INF/header.jsp"%>
	</header>

	<!-- itemTab -->
	<div
		style="display: flex; justify-content: space-between; align-items: center;"
		class="container">
		<div class="tab">
			<h1>관리자 전용 상품 페이지입니다.</h1>
			<br>
			<div
				style="display: flex; align-items: center; justify-content: space-between;">
				<div>
					<a href="/itemgiftcard/adminiteminsert.jsp" class="btn btn-dark">상품
						등록</a>
				</div>

				<div style="display: flex; align-items: center;">
					<input type="text" placeholder="상품명으로 검색하세요" id="itemName"
						style="color: black; background-color: transparent; border: 1px solid white; border-radius: 8px; padding: 10px 10px; margin: 10px; font-size: 14px; width: 80%;">
					<button class="btn btn-dark ms-1"
						style="width: 120px; border-radius: 8px; padding: 10px 10px; margin: 10px;"
						onclick="fetchItems(1, document.getElementById('itemName').value)">상품
						검색</button>
				</div>
			</div>

			<ul class="tabnav">
				<li><a href="#tab01">팝콘/음료/굿즈</a></li>
				<li><a href="#tab02">포인트 몰</a></li>
			</ul>
			<div class="tabcontent">
				<div id="tab01">
					<a href="#"><img src="/img/item01.PNG" width="1000px"
						height="400px" style="margin-bottom: 120px; margin-left: 70px;"></a>
					<div class="item-container" id="itemList">

						<c:forEach var="item" items="${itemList}">
							<div class="item">
								<input type="hidden" class="itemNo" name="itemNo"
									value="${item.itemNo}"> <a href="#"
									onclick="loadItemInfo(${item.itemNo})"> <img
									src="../upload/${item.imageUuid}" class="item-image">
									<p class="item-name" style="color: black; font-weight: bold;">${item.itemName}</p>
									<p class="item-info" style="color: black; font-size: 13px;">${item.itemSize}</p>
									<p class="item-price"
										style="color: #9d00f7; font-size: 25px; font-weight: 400;">${item.itemPrice}원</p>
								</a>
								<button class="updateButton" onclick="editItem(${item.itemNo})">수정/삭제</button>
							</div>
						</c:forEach>
					</div>
				</div>
				<div id="tab02">
					<br>
					<h2>등록된 상품이 없습니다.</h2>
					<br>
				</div>
			</div>
			<!-- 페이지 버튼 -->
			<div id="paging" class="d-flex container justify-content-center mt-5">
				<div id="prev" class="mx-4"></div>
				<div id="pageNum"></div>
				<div id="next" class="mx-4"></div>
			</div>
		</div>
	</div>
	<!-- itemTab -->

	<!-- 푸터-->
	<footer class="py-3 my-4" style="background-color: rgb(17, 17, 17);">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>

	<script>
        document.addEventListener('DOMContentLoaded', function () {
            fetchItems(1); // Initial fetch with page 1
        });

        function fetchItems(pageNum,itemName) {
        	
        	
        	var url = (itemName === null || itemName === '' || itemName === undefined)?
        			'/item/list/' + pageNum:'/item/list/' + pageNum +'/item/' +itemName;
        	console.log(url);
            fetch(url, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                },
            })
                .then(response => {
                    if (!response.ok) {
                        return response.json().then(errorData => {
                            alert("서버내부 오류: " + errorData.message);
                            throw new Error('Server error');
                        });
                    }
                    return response.json();
                })
                .then(data => {
                   
                    console.log(data.list);
                    console.log(data.searchList);
                    console.log(data.page);
                  
                    let items = (data.list === undefined)?data.searchList:data.list;
                    let paginationData = data.page;
                    createPaginationButtons(paginationData.beginPage, paginationData.endPage, paginationData.prev, paginationData.next,data);
                    displayItems(items);

                })
                .catch(error => {
                    console.error('Fetch error:', error.message);
                });
        }

        function displayItems(items) {
            $('#itemList').empty();

            function addCommaToPrice(price) {
                return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            }
            
            for (var itemGiftCard of items) {
                
                let itemInfo =
                    '<div class="item">'
                    + '<input type="hidden" class="itemNo" name="itemNo" value="' + itemGiftCard.itemNo + '">'
                    + '<a href="#" onclick="loadItemInfo(' + itemGiftCard.itemNo + ')">'
                    + '<img src="../upload/' + itemGiftCard.imageUuid + '" class="item-image">'
                    + '<p class="item-name" style="color: black; font-weight: bold;">'
                    + itemGiftCard.itemName
                    + '</p>'
                    + '<p class="item-info" style="color: black; font-size: 13px;">'
                    + itemGiftCard.itemSize
                    + '</p>'
                    + '<p class="item-price" style="color: #9d00f7; font-size: 25px; font-weight: 400;">'
                    + addCommaToPrice(itemGiftCard.itemPrice) + '원</p>' + '</a>'
                    + '<button class="updateButton" onclick="editItem('
                    + itemGiftCard.itemNo + ')">수정/삭제</button>'
                    + '</div>';  

                $('#itemList').append(itemInfo);
            }

        }

        function createPaginationButtons(begin, end, prev, next, data) {
            let prevPage = begin - 1;
            let nextPage = end + 1;
            $('#pageNum').empty();

            if (data.list !== undefined || (begin === 1 && end === 1)) { // 수정된 부분
                $('#prev').html(prevPage? '<button onclick="fetchItems(' + prevPage + ')">이전</button>' : '');
                $('#next').html(nextPage? '<button onclick="fetchItems(' + nextPage + ')">다음</button>' : '');
                for (let i = begin; i <= end; i++) {
                    $('#pageNum').append('<button onclick="fetchItems(' + i + ')" class="mx-2">' + i + '</button>');
                }
            } else {
                console.log(data.keyword);
                $('#prev').html(prevPage? '<button onclick="fetchItems(' + prevPage + ', \'' + data.keyword + '\')">이전</button>' : '');
                $('#next').html(nextPage? '<button onclick="fetchItems(' + nextPage + ', \'' + data.keyword + '\')">다음</button>' : '');
                for (let i = begin; i <= end; i++) {
                    $('#pageNum').append('<button onclick="fetchItems(' + i + ', \'' + data.keyword + '\')" class="mx-2">' + i + '</button>');
                }
            }
        }

        // 클릭 시 호출되는 함수로 선택한 아이템의 정보를 localStorage에 저장
        function loadItemInfo(itemNo) {
            $.ajax({
                type: 'GET',
                url: '/item/info/' + itemNo,
                contentType: 'application/json',
                success: function (response) {
                    console.log(response);
                    // 선택한 아이템의 정보를 localStorage에 저장
                    localStorage.setItem('selectedItemNo', itemNo);
                    // adminitemEditForm.jsp로 이동
                    location.href = '/itemgiftcard/adminitemeditform.jsp';
                },
                error: function (error) {
                    var errorMessage = error.responseText;
                    alert(errorMessage);
                }
            });
        }
		
        
        function editItem(itemNo) {
            localStorage.setItem('selectedItemNo', itemNo);
            location.href = '/itemgiftcard/adminitemeditform.jsp?itemNo=' + itemNo;
        }
    </script>
</body>

</html>