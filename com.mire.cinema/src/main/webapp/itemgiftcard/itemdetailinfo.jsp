<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
    <title>MIRE MOVIE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="/itemgiftcard/tab.js"></script>
    <link rel="stylesheet" href="/itemgiftcard/tab.css">
    <link rel="stylesheet" type="text/css" href="/css/common.css">
    <style>
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

        p {
            color: rgb(204, 204, 204);
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
        <%@ include file="../WEB-INF/header.jsp" %>
    </header>

    <!-- itemTab -->
    <div style="display: flex; justify-content: space-between; align-items: center;" class="container">
        <table>
            <tbody>

                <tr>
                    <td colspan="2" style="font-weight: 500; font-size: 25px;" id="itemName"></td>
                </tr>
                <tr>
                    <td colspan="2" id="itemSize"></td>
                </tr>

                <tr style="border-top: 1px solid black;">
                    <td rowspan="8"><img src="/img/item02.PNG"
                            style="width: 500px; height: 500px; border-right: 1px solid black; margin-right: 30px;">
                    </td>
                </tr>

                <tr>
                    <td id="hd">사용극장</td>
                    <td>모든 지점</td>
                </tr>
                <tr>
                    <td id="hd">유효기간</td>

                    <td id="itemType">구매일로부터 24개월 이내</td>
                </tr>
                <tr>
                    <td id="hd">판매수량</td>

                    <td>1회 8개 구매가능</td>
                </tr>
                <tr>
                    <td id="hd">구매 후 취소&nbsp;&nbsp;&nbsp;&nbsp;</td>

                    <td>구매일로부터 10일 이내 취소 가능</td>
                </tr>
                <tr>
                    <td id="hd">수량/금액</td>

                    <td><button id="decreaseBtn">-</button> <span id="quantity" style="color: black;"></span> 개
                        <button id="increaseBtn">+</button> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
                            style="color: black; font-size: 30px; font-weight: 600;" id="itemPrice"></span></td>

                </tr>
                <tr>
                    <td id="hd">원산지</td>
                    <td id="itemInfo"></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <button id="purchaseBtn">구매하기</button>
                    </td>
                </tr>

            </tbody>
        </table>
    </div>
    <!-- itemTab -->

    <!-- 푸터-->
    <footer class="py-3 my-4" style="background-color: rgb(17, 17, 17);">
        <%@ include file="../WEB-INF/footer.jsp" %>
    </footer>

   <script type="text/javascript">
    $(document).ready(function () {
        // 페이지 로드 시 sessionStorage에서 선택한 상품 정보를 가져와서 폼에 표시
        var selectedItem = sessionStorage.getItem('selectedItem');

        if (selectedItem) {
            selectedItem = JSON.parse(selectedItem);

            // 상품 정보 표시
            $('#itemName').text(selectedItem.itemName);
            $('#itemType').text(selectedItem.itemType);
            $('#itemPrice').text(selectedItem.itemPrice);
            $('#itemSize').text(selectedItem.itemSize);
            $('#itemInfo').text(selectedItem.itemInfo);

            // 개당 가격 설정
            var unitPrice = selectedItem.itemPrice;
            // 초기 수량 설정
            var quantity = 1;
            // 최대 수량 설정
            var maxQuantity = 8;

            // 수량 및 금액 업데이트 함수
            function updateQuantityAndPrice() {
                $("#quantity").text(quantity);
                $("#itemPrice").text((quantity * unitPrice).toLocaleString() + "원");
            }

            // 감소 버튼에 대한 이벤트 리스너
            $("#decreaseBtn").on("click", function () {
                if (quantity > 1) {
                    quantity -= 1;
                    updateQuantityAndPrice();
                }
            });

            // 증가 버튼에 대한 이벤트 리스너
            $("#increaseBtn").on("click", function () {
                if (quantity < maxQuantity) {
                    quantity += 1;
                    updateQuantityAndPrice();
                }
            });

            // 초기 업데이트
            updateQuantityAndPrice();
        } else {
            // 세션 스토리지에 선택한 상품 정보가 없을 경우에 대한 처리
            console.warn('sessionStorage에서 선택한 상품 정보를 찾을 수 없습니다.');
        }
    });
</script>


</body>

</html>
