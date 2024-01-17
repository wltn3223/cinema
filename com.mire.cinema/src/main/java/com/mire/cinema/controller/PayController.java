package com.mire.cinema.controller;

import java.io.IOException;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.Payment;

import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;

@Log
@RequiredArgsConstructor
@RestController("/pay")
public class PayController {
	private final IamportClient api;
	
	
	public PayController() {
		this.api = new IamportClient("6388583122352787", "PTdaWySYsdP5YJEfWiS98hTKw5xPoCr7Br6gVltdrq2UQdjZsS0qCjrt4A8ATj62gyUwa9RX2AQpW9fY");
		
		
	}
	
	@PostMapping("/pay")
	public String payItem(@RequestBody String imp_uid) throws IamportResponseException, IOException {
		log.info("제발 와줘");

		
		Payment payment = this.api.paymentByImpUid(imp_uid).getResponse();
		System.out.println(payment);
		
		
		return "ok";
	}
}
