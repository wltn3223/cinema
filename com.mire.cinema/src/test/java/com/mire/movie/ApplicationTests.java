package com.mire.movie;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;

import com.mire.cinema.Application;
import com.mire.cinema.domain.itemgiftcard.ItemGiftCard;
import com.mire.cinema.repository.ItemGiftCardMapper;

import lombok.extern.java.Log;

@Log
@SpringBootTest
@ContextConfiguration(classes = Application.class)
class ApplicationTests {
	@Autowired
	ItemGiftCardMapper itemGiftCardMapper;

	 @Test
	    void testSelectItemGiftCard() {
	       
	        ItemGiftCard selectedGiftCard = itemGiftCardMapper.selectItemGiftCard("test1");
	        log.info("Selected Item: " + selectedGiftCard);
	    }
}