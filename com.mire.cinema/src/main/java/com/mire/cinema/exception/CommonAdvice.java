package com.mire.cinema.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import lombok.extern.java.Log;

@Log
@RestControllerAdvice
public class CommonAdvice {
	
	
	@ExceptionHandler(IllegalArgumentException.class)
	public ResponseEntity<String> IllgalHandler(IllegalArgumentException e){
		log.info(e.getMessage());
		return new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
	}
	
	@ExceptionHandler(NullPointerException.class)
	public ResponseEntity<String> NullHandler(NullPointerException e){
		
		return new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
	}
}
