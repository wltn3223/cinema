package com.mire.cinema.domain.order;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Builder
@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class Order {
	private long orderNo;
	private String orderId;
	private int orderQuantity;
	private int orderPrice;
	private int discountPrice;
	private String orderStatus;
	private Date orderDate;
	private long itemNo;
	private String memberId;
	
	


}
