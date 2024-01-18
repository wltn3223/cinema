package com.mire.cinema.service;

import com.mire.cinema.domain.order.Order;

public interface OrderService {	
	public void createOrder(Order order);
	public void modifyStatus(int orderNo) ;
	public void modifyOrderInfo(Order order) ;
	public Order selectOrder(int orderNo) ;
	public void deleteOrder(int orderNo); 
	

}
