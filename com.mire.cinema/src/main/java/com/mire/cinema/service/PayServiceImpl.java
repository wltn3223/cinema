package com.mire.cinema.service;


import org.springframework.stereotype.Service;

import com.mire.cinema.domain.order.Order;
import com.mire.cinema.domain.order.OrderStatus;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.repository.OrderMapper;
import com.siot.IamportRestClient.response.Payment;

import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;
@Log
@Service
@RequiredArgsConstructor
public class PayServiceImpl implements PayService {
	private final OrderMapper orderMapper;

	@Override 
	public void verifyOrder(Payment payInfo, String orderId) {
		Order order = orderMapper.selectOrderById(orderId);
		System.out.println("주문정보:" + order);
		log.info("가격" + payInfo.getAmount().intValue());
		log.info("구매자이름:" + payInfo.getBuyerName());
		log.info("아이디비교:" + orderId +"아이디2:" + payInfo.getMerchantUid());
	
	
		if(payInfo.getAmount().intValue() != order.getDiscountPrice() || !payInfo.getBuyerName().equals(order.getMemberId())
			||	!payInfo.getMerchantUid().equals(orderId)) {
			orderMapper.updateStatus(orderId, OrderStatus.FAIL);
			throw new IllegalArgumentException(ErrorMsg.BADPAYINFO);
		} 
		
		
		orderMapper.updateStatus(orderId, OrderStatus.COMPLETE);
	}

}
