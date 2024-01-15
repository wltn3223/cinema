package com.mire.movie;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;

import com.mire.cinema.Application;
import com.mire.cinema.service.MemberService;
import com.mire.cinema.service.MovieService;

import lombok.extern.java.Log;

@Log
@SpringBootTest
@ContextConfiguration(classes = Application.class)
class ApplicationTests {
	@Autowired
	MemberService memberService;
	
	@Autowired
	MovieService movieService;

	 @Test
	    void testSelectItemGiftCard() {
	       
	       System.out.println(movieService.getPartList(1,2));
	        
	    }
}