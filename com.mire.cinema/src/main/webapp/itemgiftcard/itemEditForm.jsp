<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <title>상품수정</title>
</head>

<body>
    <header>
        <%@ include file="../WEB-INF/header.jsp"%>
    </header>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <h1 class="text-center mb-4">상품 수정</h1>
                <form>
                    <div class="form-group">
                        <label for="itemName">상품명</label>
                        <input type="text" class="form-control" id="itemName" readonly>
                    </div>

                    <div class="form-group">
                        <label for="itemType">상품분류</label>
                        <select class="form-control" id="itemType">
                            <option>식품</option>
                            <option>음료</option>
                            <option>셋트</option>
                            <option>기타</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="itemPrice">상품금액</label>
                        <input type="text" class="form-control" id="itemPrice">
                    </div>

                    <div class="form-group">
                        <label for="itemSize">사이즈</label>
                        <input type="text" class="form-control" id="itemSize">
                    </div>

                    <div class="form-group">
                        <label for="itemInfo">상품정보</label>
                        <textarea class="form-control" id="itemInfo" style="height: 200px;"></textarea>
                    </div>

                    <div class="d-flex justify-content-center">
                        <div class="text-center">
                            <button class="btn btn-light bg-dark text-light" type="button" onclick="updateInfo()">수정하기</button>
                            <button class="btn btn-light bg-dark text-light" type="button" onclick="removeItem()">삭제하기</button>
                        </div>
                        <div class="text-center">
                            <a href="/itemgiftcard/itemlist.jsp">
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

    
    <script type="text/javascript">
        $(document).ready(function () {
            // 페이지 로드 시 sessionStorage에서 선택한 상품 정보를 가져와서 폼에 표시
            var selectedItem = sessionStorage.getItem('selectedItem');
            if (selectedItem) {
                selectedItem = JSON.parse(selectedItem);
                $('#itemName').val(selectedItem.itemName);
                $('#itemType').val(selectedItem.itemType);
                $('#itemPrice').val(selectedItem.itemPrice);
                $('#itemSize').val(selectedItem.itemSize);
                $('#itemInfo').val(selectedItem.itemInfo);
            } else {
                console.error('No selected item information found in sessionStorage.');
            }
        });

        function updateInfo() {
            var itemName = $("#itemName").val();
            var itemType = $("#itemType").val();
            var itemPrice = $("#itemPrice").val();
            var itemSize = $("#itemSize").val();
            var itemInfo = $("#itemInfo").val();

            var data = {
                itemName: itemName,
                itemType: itemType,
                itemPrice: itemPrice,
                itemSize: itemSize,
                itemInfo: itemInfo
            };

            $.ajax({
                type: "PUT",
                url: "/item",
                contentType: "application/json; charset=UTF-8",
                data: JSON.stringify(data),
                success: function (response) {
                    console.log("수정 성공:", response);
                    alert("상품이 수정되었습니다.");
                    location.href = "/itemgiftcard/itemlist.jsp"
                },
                error: function (error) {
                    var errorMessage = error.responseText;
                    alert(errorMessage);
                }
            });
        }

        function removeItem() {
            var itemName = $("#itemName").val();

            $.ajax({
                type: "DELETE",
                url: "/item/" + itemName,
                success: function (response) {
                    console.log("Delete successful:", response);
                    alert("상품이 삭제되었습니다.");
                    location.href = "/itemgiftcard/itemlist.jsp"
                },
                error: function (error) {
                    var errorMessage = error.responseText;
                    alert(errorMessage);
                }
            });
        }
        
        //상품금액 1000자리 단위 , 로 구분
        document.getElementById('itemPrice').addEventListener('input', function () {
            var value = this.value.replace(/[^0-9]/g, ''); // 숫자 이외의 문자 제거
            this.value = addCommas(value); // 쉼표 추가하여 표시
        });

        function addCommas(number) {
            return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
        
      
    </script>

    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>
