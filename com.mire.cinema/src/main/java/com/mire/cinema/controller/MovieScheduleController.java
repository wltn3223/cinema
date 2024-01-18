package com.mire.cinema.controller;

import java.security.Provider.Service;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mire.cinema.domain.movieschedule.MovieSchedule;
import com.mire.cinema.domain.movieschedule.MovieScheduleDTO;
import com.mire.cinema.exception.SucessMsg;
import com.mire.cinema.service.MovieScheduleService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;

@Log
@RequiredArgsConstructor
@RestController
@RequestMapping("/movieschedule")
public class MovieScheduleController {
	private final MovieScheduleService service;

	@PostMapping
	public ResponseEntity<String> saveSchedule(@Valid MovieSchedule schedule) {
		schedule = MovieSchedule.builder()
				.scheduleNo(schedule.getScheduleNo())
				.scheduleStartTime(schedule.getScheduleStartTime())
				.scheduleFinishTime(schedule.getScheduleFinishTime())
				.build();
		service.saveMovieSchedule(schedule);
		return new ResponseEntity<>(SucessMsg.INSERT, SucessMsg.statusOK);
	}
	
	@PostMapping("/update")
	public ResponseEntity<String> modifySchedule(@Valid MovieScheduleDTO.update dto){
		
	}
}
