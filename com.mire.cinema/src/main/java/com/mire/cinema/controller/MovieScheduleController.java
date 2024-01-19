package com.mire.cinema.controller;

import java.util.Date;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mire.cinema.domain.movie.Movie;
import com.mire.cinema.domain.movieschedule.MovieSchedule;
import com.mire.cinema.domain.movieschedule.MovieScheduleDTO;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.exception.SucessMsg;
import com.mire.cinema.service.MovieScheduleService;
import com.mire.cinema.service.MovieService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;

@Log
@RequiredArgsConstructor
@RestController
@RequestMapping("/movieschedule")
public class MovieScheduleController {
	private final MovieScheduleService service;
	private final MovieService movieService;
	// 스케줄 등록
	@PostMapping
	public ResponseEntity<String> saveSchedule(@RequestBody @Valid MovieScheduleDTO.Insert dto,
			BindingResult bindingResult) {
		movieService.getTotalList();
		
		if (bindingResult.hasErrors()) {
			return new ResponseEntity<>(bindingResult.getAllErrors().get(0).getDefaultMessage(),
					HttpStatus.BAD_REQUEST);
		}
		
		MovieSchedule schedule = MovieSchedule.builder().scheduleStartTime(dto.getScheduleStartTime())
				.scheduleFinishTime(dto.getScheduleFinishTime()).scheduleFinishTime(dto.getScheduleFinishTime()).screenTotalSeat(dto.getScreenTotalSeat())
				.screenNo(dto.getScreenNo()).movieNo(dto.getMovieNo()).build();

		log.info("스케줄" + schedule);
		List<MovieSchedule> list = service.ScheduleList(); // list를 어떻게 초기화하는지에 따라 달라집니다.
		log.info("리스트" + list);
		for (MovieSchedule existingSchedule : list) {
			Date existingStartTime = existingSchedule.getScheduleStartTime();
			Date existingFinishTime = existingSchedule.getScheduleFinishTime();

			// 같은 상영관에 같은 시간대의 영화를 상영할 수 없는 조건 확인
			if (dto.getScreenNo() == existingSchedule.getScreenNo()
					&& !dto.getScheduleFinishTime().before(existingStartTime)
					&& !dto.getScheduleStartTime().after(existingFinishTime)) {

				return new ResponseEntity<>(ErrorMsg.SCHEDULEOVERLAP, HttpStatus.BAD_REQUEST);
			}
		}

		service.saveMovieSchedule(schedule);
		return new ResponseEntity<>(SucessMsg.INSERT, SucessMsg.statusOK);
	}

	// 스케줄 리스트
	@GetMapping("/list")
	public ResponseEntity<List<MovieSchedule>> ScreenList() {
		List<MovieSchedule> scheduleList = service.ScheduleList();
		return new ResponseEntity<>(scheduleList, SucessMsg.statusOK);
	}

	// 스케줄 업데이트
	@PostMapping("/update")
	public ResponseEntity<String> modifySchedule(@Valid MovieScheduleDTO.Update dto) {
		service.modifyMovieSchedule(dto);
		return new ResponseEntity<>(SucessMsg.UPDATE, SucessMsg.statusOK);
	}

	// 스케줄 삭제하기
	@DeleteMapping("/{scheduleNo}")
	public ResponseEntity<String> removeNotice(@PathVariable Long scheduleNo) {
		service.removeMovieSchedule(scheduleNo);
		return new ResponseEntity<>(SucessMsg.DELETE, SucessMsg.statusOK);
	}
}
