package com.mire.cinema.exception;

import java.sql.SQLException;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.multipart.MultipartException;

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
	//파일용량초량초과 
	@ExceptionHandler
	public ResponseEntity<String> FileUploadMaxException(MultipartException e){
		return new ResponseEntity<>(ErrorMsg.FILEUPLOADEMAX,HttpStatus.BAD_REQUEST);
	}
	
	@ExceptionHandler
	public ResponseEntity<String> sqlException(SQLException e){
		return new ResponseEntity<>(ErrorMsg.BADTYPE,HttpStatus.BAD_REQUEST);
	}
}
