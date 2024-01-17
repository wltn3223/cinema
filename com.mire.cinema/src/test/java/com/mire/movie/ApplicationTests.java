package com.mire.movie;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;

import com.mire.cinema.Application;
import com.mire.cinema.domain.member.MemberDTO;
import com.mire.cinema.domain.member.MemberDTO.search;
import com.mire.cinema.domain.notice.NoticeDTO;
import com.mire.cinema.repository.MemberMapper;
import com.mire.cinema.repository.NoticeMapper;
import com.mire.cinema.service.MemberService;
import com.mire.cinema.service.MovieService;
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

	@Test
	void testSelectItemGiftCard() {
		NoticeDTO.Search dto = new NoticeDTO.Search();
		dto.setStartNum(1);
		dto.setEndNum(2);
		dto.setBoardTitle("미래");
		mapper.searchNoticeList(dto).forEach(data -> log.info(data.toString()));

	}
}