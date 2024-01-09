package com.mire.cinema.response;

import org.springframework.http.HttpStatus;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Getter
public enum ErrorCode {
	
	LOGIN(HttpStatus.BAD_REQUEST,"아이디 혹은 비밀번호가 일치 하지 않습니다."),
	JOIN(HttpStatus.BAD_REQUEST,"회원가입 실패");
	
	
	
	
	
	private final HttpStatus httpStatus;
	private final String message;
}
