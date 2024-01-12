package com.mire.cinema.exception;

import org.eclipse.tags.shaded.org.apache.bcel.classfile.Code;

import com.mire.cinema.response.ErrorCode;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Getter
public class CommonException extends RuntimeException{
	
	private final Error code;
	

}
