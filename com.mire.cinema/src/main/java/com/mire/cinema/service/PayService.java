package com.mire.cinema.service;

import java.io.IOException;

import com.mire.cinema.domain.pay.PayDTO;
import com.mire.cinema.domain.pay.PayDTO.ReserveInfo;
import com.siot.IamportRestClient.exception.IamportResponseException;

public interface PayService  {
	public void verifyOrder(PayDTO.Info imp_uid) throws IamportResponseException, IOException;
	public void verifyReserve(PayDTO.ReserveInfo imp_uid) throws IamportResponseException, IOException;
	
	public void refund(String token, String orderId) throws IOException;
	public void refundReserve(String token, String orderId) throws IOException;
	public void reserve(ReserveInfo info);
	
	public String getToken() throws IOException;

}
