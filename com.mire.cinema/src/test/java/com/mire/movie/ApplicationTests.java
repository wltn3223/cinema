package com.mire.movie;

import java.time.LocalDateTime;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;

import com.mire.cinema.Application;
import com.mire.cinema.domain.movieschedule.MovieSchedule;
import com.mire.cinema.repository.MovieScheduleMapper;
import com.mire.cinema.service.MovieScheduleService;

@SpringBootTest
@ContextConfiguration(classes = Application.class)
class ApplicationTests {

	@Autowired
	MovieScheduleService movieScheduleService;

	@Autowired
	MovieScheduleMapper movieScheduleMapper;

	LocalDateTime dateTime = LocalDateTime.of(2024, 1, 20, 11, 1);

	@Test
	void testGetScheduleMap() {
		System.out.println( movieScheduleMapper.selectMovieSchedule(MovieSchedule.builder().screenNo(1).movieNo(8).scheduleDate(dateTime).build()));
	}
}
