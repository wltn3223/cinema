package com.mire.cinema.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import io.jsonwebtoken.io.IOException;
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
	@ExceptionHandler({IOException.class ,IllegalStateException.class})
	public ResponseEntity<String> fileHandler(Exception e){
		
		return new ResponseEntity<>(ErrorMsg.FILESAVE,HttpStatus.BAD_REQUEST);
	}
	@ExceptionHandler(NumberFormatException.class)
	public ResponseEntity<String> fileHandler(NumberFormatException e){
		
		return new ResponseEntity<>(ErrorMsg.BADTYPE,HttpStatus.BAD_REQUEST);
	}


}
