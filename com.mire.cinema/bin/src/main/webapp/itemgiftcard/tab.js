$(function(){
  $('.tabcontent > div').hide();
  $('.tabnav a').click(function () {
    $('.tabcontent > div').hide().filter(this.hash).fadeIn();
    $('.tabnav a').removeClass('active');
    $(this).addClass('active');
    return false;
  }).filter(':eq(0)').click();
  });
  
   $(document).ready(function() {
    var quantity = 1; // 초기 수량
    var maxQuantity = 8; // 최대 수량
    var unitPrice = 43000; // 개당 가격

    // 수량 및 금액 업데이트 함수
    function updateQuantityAndPrice() {
        $("#quantity").text(quantity);
        $("#totalPrice").text((quantity * unitPrice).toLocaleString() + "원");
    }

    // 감소 버튼에 대한 이벤트 리스너
    $("#decreaseBtn").on("click", function() {
        if (quantity > 1) {
            quantity -= 1;
            updateQuantityAndPrice();
        }
    });

    // 증가 버튼에 대한 이벤트 리스너
    $("#increaseBtn").on("click", function() {
        if (quantity < maxQuantity) {
            quantity += 1;
            updateQuantityAndPrice();
        }
    });

    // 초기 업데이트
    updateQuantityAndPrice();
});