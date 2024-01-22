package com.mire.cinema.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import com.mire.cinema.domain.cinema.Cinema;
import com.mire.cinema.domain.movie.Movie;
import com.mire.cinema.domain.movieschedule.MovieSchedule;
import com.mire.cinema.domain.movieschedule.MovieScheduleDTO;
import com.mire.cinema.domain.movieschedule.MovieScheduleDTO.schedule;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.exception.SucessMsg;
import com.mire.cinema.service.CinemaService;
import com.mire.cinema.service.MovieScheduleService;
import com.mire.cinema.service.MovieService;
import com.mire.cinema.service.ScreenService;
import com.siot.IamportRestClient.response.Schedule;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
@RequestMapping("/movieschedule")
public class MovieScheduleController {
	private final MovieScheduleService service;
	private final MovieService movieService;
	private final CinemaService cinemaService;

	// 스케줄 등록
	@PostMapping
	public ResponseEntity<String> saveSchedule(@RequestBody @Valid MovieScheduleDTO.Insert dto,
			BindingResult bindingResult) {
		int moviePlayTime = movieService.findMovie(dto.getMovieNo()).getMoviePlayTime();

		if (bindingResult.hasErrors()) {
			return new ResponseEntity<>(bindingResult.getAllErrors().get(0).getDefaultMessage(),
					HttpStatus.BAD_REQUEST);
		}

		MovieSchedule newSchedule = MovieSchedule.builder().scheduleStartTime(dto.getScheduleStartTime())
				.scheduleFinishTime(dto.getScheduleStartTime().plusMinutes(moviePlayTime))
				.screenTotalSeat(dto.getScreenTotalSeat()).screenNo(dto.getScreenNo()).movieNo(dto.getMovieNo())
				.build();

		List<MovieSchedule> list = service.scheduleList();

		for (MovieSchedule existingSchedule : list) {
			LocalDateTime existingStartTime = existingSchedule.getScheduleStartTime();
			LocalDateTime existingFinishTime = existingSchedule.getScheduleFinishTime();

			if (dto.getScreenNo() == existingSchedule.getScreenNo()
					&& !newSchedule.getScheduleFinishTime().isBefore(existingStartTime)
					&& !newSchedule.getScheduleStartTime().isAfter(existingFinishTime)) {
				return new ResponseEntity<>(ErrorMsg.SCHEDULEOVERLAP, HttpStatus.BAD_REQUEST);
			}
		}
		service.saveMovieSchedule(newSchedule);
		return new ResponseEntity<>(SucessMsg.INSERT, SucessMsg.statusOK);
	}

	@GetMapping("/{scheduleNo}")
	public ResponseEntity<Long> findSchedule(@PathVariable long scheduleNo) {
		MovieSchedule foundSchedule = service.findSchedule(scheduleNo);
		if (scheduleNo == 0) {
			throw new NullPointerException(ErrorMsg.NOTFOUNDSEARCH);
		}
		return new ResponseEntity<>(foundSchedule.getScheduleNo(), SucessMsg.statusOK);
	}

	@GetMapping("/info/{scheduleNo}")
	public ResponseEntity<MovieScheduleDTO.Info> findMemberInfo(@PathVariable long scheduleNo) {
		MovieSchedule info = service.findSchedule(scheduleNo);
		if (info == null) {
			throw new IllegalArgumentException(ErrorMsg.USERINFO);
		}
		MovieScheduleDTO.Info schedule = MovieScheduleDTO.Info.builder().scheduleNo(info.getScheduleNo()).build();
		return new ResponseEntity<>(schedule, SucessMsg.statusOK);
	}

	@GetMapping("/list/{pageNum}")
	public ResponseEntity<Map<String, Object>> getscheduleList(@PathVariable Integer pageNum) {
		return new ResponseEntity<>(service.getScheduleMap(pageNum, 0), HttpStatus.OK);
	}

	@GetMapping("/list/{pageNum}/movieschedule/{scheduleNo}")
	public ResponseEntity<Map<String, Object>> getscheduleList(@PathVariable Integer pageNum,
			@PathVariable Long scheduleNo) {
		return new ResponseEntity<>(service.getScheduleMap(pageNum, scheduleNo), HttpStatus.OK);

	}

	// 스케줄 업데이트
	@PostMapping("/update")
	public ResponseEntity<String> updateMovieSchedule(@RequestBody @Valid MovieScheduleDTO.Update request) {
		if (isScheduleConflict(request.getScreenNo(), request.getScheduleStartTime(),
				request.getScheduleFinishTime())) {
			return new ResponseEntity<>(ErrorMsg.SCHEDULEOVERLAP, HttpStatus.BAD_REQUEST);
		}

		service.modifyMovieSchedule(request);

		return new ResponseEntity<>(SucessMsg.UPDATE, HttpStatus.OK);
	}

	private boolean isScheduleConflict(long screenNo, LocalDateTime startTime, LocalDateTime finishTime) {
		List<MovieSchedule> scheduleList = service.scheduleList();

		for (MovieSchedule schedule : scheduleList) {
			LocalDateTime existingStartTime = schedule.getScheduleStartTime();
			LocalDateTime existingFinishTime = schedule.getScheduleFinishTime();

			if (screenNo == schedule.getScreenNo()
					&& (startTime.isBefore(existingFinishTime) || startTime.isEqual(existingFinishTime))
					&& (finishTime.isAfter(existingStartTime) || finishTime.isEqual(existingStartTime))) {
				return true;
			}
		}
		return false;
	}

	// 스케줄 삭제하기
	@DeleteMapping("/{scheduleNo}")
	public ResponseEntity<String> removeNotice(@PathVariable Long scheduleNo) {
		service.removeMovieSchedule(scheduleNo);
		return new ResponseEntity<>(SucessMsg.DELETE, SucessMsg.statusOK);
	}

	// 예매를 위한 리스트 추가
	@GetMapping("/getMovieSchedule/{movieNo}/{cinemaNo}/{schedule}")
	public List<MovieScheduleDTO.schedule> getMovieSchedule(@PathVariable long movieNo, @PathVariable long cinemaNo,
			@PathVariable(value = "schedule") String scheduleStr) {

		LocalDate scheduleDate = service.getDateTime(scheduleStr);

		return service.movieScheduleMap(movieNo, cinemaNo, scheduleDate);
	}

	// 예매를 위한 리스트 추가
	@GetMapping("/MovieInfo")
	public Map<String, Object> getMovieScheduleInfo() {
		Map<String, Object> list = new HashMap<>();

		List<Cinema> cinemaList = cinemaService.seeCinema();
		List<Movie> movies = movieService.getTotalList();

		list.put("cinema", cinemaList);
		list.put("movie", movies);

		return list;
	}

}
