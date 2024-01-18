package com.mire.cinema.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mire.cinema.domain.order.OrderDTO;
import com.mire.cinema.service.OrderService;

import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;

@Log
@RequiredArgsConstructor
@RestController
@RequestMapping("/order")
public class OrderController {
			
	private final OrderService orderService;

	

	@GetMapping("/memberId/{memberId}/itemNo/{itemNo}/number/{number}")
	public ResponseEntity<OrderDTO.Info> getBuyerInfo(@PathVariable String memberId,
			@PathVariable Long itemNo, @PathVariable int number) {
		
		OrderDTO.Info info = orderService.getBuyerInfo(memberId,itemNo,number);
		
		
		return new ResponseEntity<OrderDTO.Info>(info, HttpStatus.OK);
	}
	
	
}
