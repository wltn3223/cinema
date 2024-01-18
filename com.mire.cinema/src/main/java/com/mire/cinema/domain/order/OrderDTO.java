package com.mire.cinema.domain.order;

import java.util.Date;

import com.mire.cinema.domain.member.DiscountGrade;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

public class OrderDTO {
	
	@Data
	@Builder
	@AllArgsConstructor
	@NoArgsConstructor
	public static class Info{
		private String orderId; 
		private String memberId;
		private String memberGrade;
		private long itemNo;
		private String itemName;
		private String itemUuid;
		private int number;
		private int price;
		private int totalPrice;
		private int discountPrice;
		
		public void calTotalPrice(){
			this.totalPrice = number * price;
			
		}
		
		public void calDistcountPrice(double discountRate) {
			this.discountPrice = (int)(totalPrice * (100 - discountRate)/100);
			this.orderId = "merchant_" + new Date().getTime();
		}
	
	}
}