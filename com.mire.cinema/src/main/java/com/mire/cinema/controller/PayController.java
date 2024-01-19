package com.mire.cinema.controller;

import java.io.IOException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.mire.cinema.domain.order.OrderDTO;
import com.mire.cinema.domain.pay.PayDTO;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.exception.SucessMsg;
import com.mire.cinema.service.OrderService;
import com.mire.cinema.service.PayService;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.Payment;

import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;

@Log
@RestController
@RequestMapping("/pay")
@RequiredArgsConstructor
public class PayController {
	
	private final PayService payService;
	private final OrderService orderService;
	
	@PostMapping("/item")
	public ResponseEntity<String> payItem(@RequestBody PayDTO.Info imp_uid)  {
		

		
		if(imp_uid == null) {
			throw new NullPointerException(ErrorMsg.BADTYPE);
		}
		
		try {
			payService.verifyOrder(imp_uid);
		} catch (IamportResponseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		
		
		
		return new ResponseEntity<>(SucessMsg.PAY,HttpStatus.OK);
	}
	

	

	@GetMapping("/memberId/{memberId}/itemNo/{itemNo}/number/{number}")
	public ResponseEntity<OrderDTO.Info> getBuyerInfo(@PathVariable String memberId,
			@PathVariable Long itemNo, @PathVariable int number) {
		
		OrderDTO.Info info = orderService.getBuyerInfo(memberId,itemNo,number);
		
		
		return new ResponseEntity<OrderDTO.Info>(info, HttpStatus.OK);
	}
	@GetMapping("/list/{pageNum}/member/{memberId}")
	public ResponseEntity<Map<String,Object>> getMemberList(@PathVariable Integer pageNum, @PathVariable String memberId) {
		return new ResponseEntity<>(orderService.getOrderMap(pageNum,memberId),HttpStatus.OK);

	}
}
