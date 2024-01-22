package com.mire.movie;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;

import com.mire.cinema.Application;
import com.mire.cinema.domain.itemgiftcard.ItemGiftCardDTO;
import com.mire.cinema.domain.member.MemberDTO;
import com.mire.cinema.domain.member.MemberDTO.search;
import com.mire.cinema.domain.order.OrderDTO;
import com.mire.cinema.repository.ItemGiftCardMapper;
import com.mire.cinema.repository.MemberMapper;
import com.mire.cinema.repository.MovieMapper;
import com.mire.cinema.repository.OrderMapper;
import com.mire.cinema.service.ItemGiftCardService;
import com.mire.cinema.service.ItemGiftCardServiceImpl;
import com.mire.cinema.service.MemberService;
import com.mire.cinema.service.MovieService;
import com.mire.cinema.service.MovieServiceImpl;

import lombok.extern.java.Log;

@Log
@SpringBootTest
@ContextConfiguration(classes = Application.class)
class ApplicationTests {
	@Autowired
	MovieService Service;
	
	@Autowired
	MovieServiceImpl ServiceImpl;
	
	@Autowired
    MovieMapper mapper;

	 @Test
	    void testSelectItemGiftCard() {
	       System.out.println(Service.findSearchMovie("무서운"));
	    }
}