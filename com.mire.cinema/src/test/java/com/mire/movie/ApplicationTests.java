package com.mire.movie;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;

import com.mire.cinema.Application;
import com.mire.cinema.domain.reserve.ReserveDTO;
import com.mire.cinema.domain.reserve.ReserveDTO.Count;
import com.mire.cinema.repository.ReserveMapper;

import lombok.extern.java.Log;

@Log
@SpringBootTest
@ContextConfiguration(classes = Application.class)
class ApplicationTests {

	@Autowired
	ReserveMapper mapper2;
	 @Test
	    void testSelectItemGiftCard() {
	    
	       
	    
	      
	       
	       ReserveDTO.Count count = new Count();
	       count.setStart(1);
	       count.setEnd(3);
	       count.setMemberId("wltn3223");
	       System.out.println(mapper2.getPartMyList(count).size());
	
	        
	    }
}