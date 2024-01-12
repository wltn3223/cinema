package com.mire.cinema.response;

import org.springframework.http.HttpStatus;

public interface SucessMessage {
	 String LOGIN= "로그인 성공";
	    String INSERT= "등록 성공";
	    String SELECT= "조회 성공";
	    String UPDATE = "정보 수정 성공";
	    String DELETE = "삭제 성공";
	    // 다른 성공 메시지들도 추가 가능

	 
	    HttpStatus statusOK = HttpStatus.OK;

}