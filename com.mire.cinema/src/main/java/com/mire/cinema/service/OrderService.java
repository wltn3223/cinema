package com.mire.cinema.service;

import java.util.Map;

import com.mire.cinema.domain.order.Order;
import com.mire.cinema.domain.order.OrderDTO;

public interface OrderService {	
	public void createOrder(OrderDTO.Info order);
	public void modifyStatus(int orderNo) ;
	public Order selectOrder(int orderNo) ;
	public void deleteOrder(int orderNo); 
	public OrderDTO.Info getBuyerInfo(String memberId,long itemNo, int number);
	public Map<String,Object> getOrderMap(Integer pageNum, String memberId);
	public int countOrder(String memberId);
	

}
