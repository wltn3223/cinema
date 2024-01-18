package com.mire.cinema.service;

import com.siot.IamportRestClient.response.Payment;

public interface PayService {
	public void verifyOrder(Payment payInfo,String orderId);
	

}
