package com.mire.cinema.exception;

public interface ErrorMsg {
	String USERINFO = "회원님의 아이디 또는 비밀번호가 일치하지 않습니다.";
	String USERNOTFOUND = "해당 ID와 일치하는 회원정보를 찾을 수 없습니다.";
	
	String FILESAVE = "파일 등록에러";
	
	String IMAGENOTFOUND = "해당 게시물의 이미지를 찾을수없습니다.";
	String BADTYPE = "잘못된 형식을 입력하셨습니다. 다시시도해주세요.";
	String DataNOTFOUND = "해당 테이블에 데이터가 존재하지않습니다.";
	String BoardNOTFOUND = "해당 게시물을 찾을수없습니다.";
}
