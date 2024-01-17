package com.mire.movie;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;

import com.mire.cinema.Application;
import com.mire.cinema.domain.member.MemberDTO;
import com.mire.cinema.domain.member.MemberDTO.search;
import com.mire.cinema.repository.MemberMapper;
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
	@Autowired
	MemberMapper mapper;

	 @Test
	    void testSelectItemGiftCard() {
	       
		 	MemberDTO.search  dto= new search();
		 	dto.setStartNum(1);
		 	dto.setEndNum(2);
		 	dto.setMemberId("admin");
	       mapper.countsearchMember("hi");
	       mapper.searchPartList(dto).forEach(data -> log.info(data.toString()));
	        
	    }
}