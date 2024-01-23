package com.mire.cinema.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mire.cinema.domain.order.OrderDTO;
import com.mire.cinema.domain.pay.PayDTO;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.exception.SucessMsg;
import com.mire.cinema.service.OrderService;
import com.mire.cinema.service.PayService;
import com.mire.cinema.service.ReserveService;
import com.siot.IamportRestClient.exception.IamportResponseException;

import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;

@Log
@RestController
@RequestMapping("/pay")
@RequiredArgsConstructor
public class PayController {
	
	private final PayService payService;
	private final OrderService orderService;
	private final ReserveService reserveService;
	
	
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
	
	@PostMapping("/reserve")
	public ResponseEntity<String> reserveItem(@RequestBody PayDTO.ReserveInfo imp_uid)  {
		
		
		if(imp_uid == null) {
			throw new NullPointerException(ErrorMsg.BADTYPE);
		}
		log.info(imp_uid.toString());
		
		try {
			payService.verifyReserve(imp_uid);
			
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
	@GetMapping("/list/{pageNum}")
	public ResponseEntity<Map<String,Object>> getAllList(@PathVariable Integer pageNum) {
		System.out.println(pageNum);
		return new ResponseEntity<>(orderService.getAllOrderMap(pageNum),HttpStatus.OK);
		
	}
	
	@GetMapping("/list/seats/{scheduleNo}")
	public ResponseEntity<List<Integer>> getAllSeats(@PathVariable Integer scheduleNo) {
		
		return new ResponseEntity<>(reserveService.getSeats(scheduleNo),HttpStatus.OK);
		
	}
	
	@GetMapping("/list/reserve/{pageNum}/{memberId}")
	public ResponseEntity<Map<String,Object>>getAllSeats(@PathVariable Integer pageNum, @PathVariable(required = false) String memberId) {
		
		
		return new ResponseEntity<>(reserveService.getReserveMap(pageNum, memberId),HttpStatus.OK);
		
	}
	@DeleteMapping("/{orderId}")
	public ResponseEntity<String> cancelOrder(@PathVariable String orderId) {
		int n = orderService.selectOrder(orderId);
		if(n == 0) {
			throw new NullPointerException(ErrorMsg.NOTFOUNDSEARCH);
		} 
		try {
			String token = payService.getToken();
			payService.refund(token, orderId);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return new ResponseEntity<>(SucessMsg.DELETE,HttpStatus.OK);
		
		
}
	
	@DeleteMapping("/reserve/{orderId}")
	public ResponseEntity<String> cancelReserve(@PathVariable String orderId) {
		int n = reserveService.checkReserve(orderId);
		if(n == 0) {
			throw new NullPointerException(ErrorMsg.NOTFOUNDSEARCH);
		} 
		try {
			String token = payService.getToken();
			payService.refundReserve(token, orderId);
			reserveService.delete(orderId);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return new ResponseEntity<>(SucessMsg.DELETE,HttpStatus.OK);
}
}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
