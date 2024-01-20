package com.mire.movie;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;

import com.mire.cinema.Application;
import com.mire.cinema.domain.cinema.Cinema;
import com.mire.cinema.domain.itemgiftcard.ItemGiftCardDTO;
import com.mire.cinema.domain.member.MemberDTO;
import com.mire.cinema.domain.member.MemberDTO.search;
import com.mire.cinema.repository.ItemGiftCardMapper;
import com.mire.cinema.repository.MemberMapper;
import com.mire.cinema.service.CinemaService;
import com.mire.cinema.service.CinemaServiceImpl;
import com.mire.cinema.service.ItemGiftCardService;
import com.mire.cinema.service.ItemGiftCardServiceImpl;
import com.mire.cinema.service.MemberService;
import com.mire.cinema.service.MovieService;

import lombok.extern.java.Log;

@Log
@SpringBootTest
@ContextConfiguration(classes = Application.class)
class ApplicationTests {
	@Autowired
	CinemaService Service;
	@Autowired
	CinemaServiceImpl movieService;

	 @Test
	    void testSelectItemGiftCard() {
		Cinema cinema = null;
		Service.findCinema(1);
		System.out.println(Service.findCinema(1));
		
	    }
}