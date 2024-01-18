package com.mire.movie;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;

import com.mire.cinema.Application;
import com.mire.cinema.controller.NoticeController;
import com.mire.cinema.domain.notice.NoticeDTO;
import com.mire.cinema.repository.NoticeMapper;
import com.mire.cinema.service.NoticeService;

import lombok.extern.java.Log;

@Log
@SpringBootTest
@ContextConfiguration(classes = Application.class)
class ApplicationTests {
	@Autowired
	NoticeService movieService;
	@Autowired
	NoticeMapper mapper;
	@Autowired
	NoticeController controller;

	@Test
	void test() {
		NoticeDTO.Search dto = new NoticeDTO.Search();
		controller.findNoticeInfo("r");
		System.out.println("여기에요"+controller.toString());
		dto.setStartNum(1);
		dto.setEndNum(2);
		dto.setBoardTitle("r");
		mapper.searchNoticeList(dto).forEach(data -> log.info(data.toString()));

	}
}