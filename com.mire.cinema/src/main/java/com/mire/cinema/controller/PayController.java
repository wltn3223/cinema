package com.mire.cinema.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.mire.cinema.domain.pay.PayDTO;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.exception.SucessMsg;
import com.mire.cinema.service.PayService;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.Payment;

import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;

@Log
@RestController
@RequestMapping("/pay")
public class PayController {
	
	private IamportClient api;
	@Autowired
	private PayService payService;
	

	public PayController() {
		this.api = new IamportClient("6388583122352787", "PTdaWySYsdP5YJEfWiS98hTKw5xPoCr7Br6gVltdrq2UQdjZsS0qCjrt4A8ATj62gyUwa9RX2AQpW9fY");
	}
	
	
	@PostMapping
	public ResponseEntity<String> payItem(@RequestBody PayDTO.Info imp_uid) throws IamportResponseException, IOException {
		log.info("제발 와줘");

		
		if(imp_uid == null) {
			throw new NullPointerException(ErrorMsg.BADTYPE);
		}
		
		Payment payment = this.api.paymentByImpUid(imp_uid.getImp_uid()).getResponse();
		
		payService.verifyOrder(payment,imp_uid.getMerchant_uid());
	
		
		
		
		return new ResponseEntity<>(SucessMsg.PAY,HttpStatus.OK);
	}
}
