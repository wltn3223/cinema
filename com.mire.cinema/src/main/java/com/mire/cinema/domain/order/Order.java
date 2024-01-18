package com.mire.cinema.domain.order;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Builder
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class Order {
	private long orderNo;
	private int orderQuantiy;
	private int order_price;
	private int discount_price;
	private String order_status;
	private int order_date;
	private int item_no;
	private int member_id;

}
